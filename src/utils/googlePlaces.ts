import { PlaceCache } from '../models/PlaceCache';
import { connectDB } from './mongodb';
import Bottleneck from 'bottleneck';

// Track API usage
let tokenUsage = 0; // Track tokens used
const tokenLimit = 100000; // Set max tokens per hour
const requestLimit = 100; // Set max requests per hour

const limiter = new Bottleneck({
  maxConcurrent: 1, // Ensure one request at a time
  reservoir: requestLimit, // Max requests allowed before pause
  reservoirRefreshAmount: requestLimit,
  reservoirRefreshInterval: 60 * 60 * 1000, // Reset hourly
});

setInterval(() => {
  tokenUsage = 0; // Reset token usage counter hourly
}, 60 * 60 * 1000);

async function makeRequest(apiUrl, options, estimatedTokens) {
  return limiter.schedule(async () => {
    if (tokenUsage + estimatedTokens > tokenLimit) {
      console.log("Token limit reached. Waiting for reset.");
      await new Promise(resolve => setTimeout(resolve, 60 * 60 * 1000)); // Wait for reset
      tokenUsage = 0;
    }

    try {
      const response = await fetch(apiUrl, options);

      if (response.status === 429) {
        const retryAfter = parseInt(response.headers.get("Retry-After"), 10) || 60;
        console.log(`Rate limit exceeded. Retrying after ${retryAfter} seconds.`);
        await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
        return makeRequest(apiUrl, options, estimatedTokens); // Retry
      }

      if (!response.ok) {
        throw new Error(`HTTP Error: ${response.status}`);
      }

      tokenUsage += estimatedTokens; // Increment token usage
      return await response.json();
    } catch (error) {
      console.error("Request error:", error.message);
      throw error;
    }
  });
}

export interface PlaceLocation {
  lat: number;
  lng: number;
}

export interface PlaceGeometry {
  location: PlaceLocation;
}

export interface PlaceResult {
  place_id: string;
  name: string;
  formatted_address: string;
  geometry: PlaceGeometry;
  rating?: number;
  user_ratings_total?: number;
  formatted_phone_number?: string;
  international_phone_number?: string;
  website?: string;
  email?: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
  types?: string[];
}

type PlaceDetails = {
  name: string;
  formatted_address: string;
  formatted_phone_number?: string;
  website?: string;
  rating?: number;
  user_ratings_total?: number;
  photos?: Array<{
    photo_reference: string;
    width: number;
    height: number;
  }>;
  opening_hours?: {
    weekday_text?: string[];
  };
  reviews?: Array<{
    author_name: string;
    rating: number;
    text: string;
    time: number;
  }>;
};

type PlaceDetailsResponse = {
  result: PlaceDetails;
  status: string;
  error_message?: string;
};

export interface PlacesApiResponse {
  results: PlaceResult[];
  status: string;
  error_message?: string;
}

export interface PlacesApiOptions {
  keyword: string;
  location: string;
  locationBias?: {
    southwest: { lat: number; lng: number };
    northeast: { lat: number; lng: number };
  };
}

const CACHE_EXPIRY_DAYS = 180; // 180 days
const _MAX_RETRIES = 5; // Increased from 3 to 5
const _BASE_DELAY = 2000; // Increased from 1000 to 2000ms
const _MAX_DELAY = 60000; // 60 seconds maximum delay

// Define Denver metro area boundaries
const DENVER_BOUNDS = {
  southwest: { lat: 39.614431, lng: -105.109927 }, // Southwest corner of Denver metro
  northeast: { lat: 39.891651, lng: -104.600296 }  // Northeast corner of Denver metro
};

async function fetchFromGooglePlaces(options: PlacesApiOptions): Promise<PlacesApiResponse> {
  const GOOGLE_PLACES_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  const GOOGLE_PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place';

  if (!GOOGLE_PLACES_API_KEY) {
    console.warn('Google Places API key not configured. Some features may not work properly.');
  }

  const searchTermMap: { [key: string]: string } = {
    'home remodeling': 'home remodeling contractor',
    'bathroom remodeling': 'bathroom remodeling contractor',
    'kitchen remodeling': 'kitchen remodeling contractor',
    'siding & gutters': 'siding and gutter contractor',
    'masonry': 'masonry contractor',
    'decks': 'deck builder',
    'flooring': 'flooring contractor',
    'windows': 'window installation',
    'fencing': 'fence contractor'
  };

  const locationMap: { [key: string]: string } = {
    'aurora': 'Aurora, Colorado',
    'lakewood': 'Lakewood, Colorado',
    'arvada': 'Arvada, Colorado',
    'westminster': 'Westminster, Colorado',
    'thornton': 'Thornton, Colorado',
    'centennial': 'Centennial, Colorado',
    'denver': 'Denver, Colorado'
  };

  const enhancedKeyword = searchTermMap[options.keyword.toLowerCase()] || options.keyword;
  const query = `${enhancedKeyword} near ${locationMap[options.location.toLowerCase()] || `${options.location}, Colorado`}`;
  const searchUrl = `${GOOGLE_PLACES_API_URL}/textsearch/json?query=${encodeURIComponent(query)}&key=${GOOGLE_PLACES_API_KEY}`;

  if (options.locationBias) {
    searchUrl += `&locationbias=ipbias&location=${options.locationBias.southwest.lat},${options.locationBias.southwest.lng}&radius=100000`;
  }

  console.log('API Request:', {
    originalKeyword: options.keyword,
    enhancedKeyword,
    query,
    timestamp: new Date().toISOString()
  });

  const searchResponse = await makeRequest(searchUrl, {}, 10) as PlacesApiResponse;
  
  console.log('API Response:', {
    status: searchResponse.status,
    resultsCount: searchResponse.results?.length || 0,
    errorMessage: searchResponse.error_message,
    timestamp: new Date().toISOString()
  });

  if (searchResponse.results.length === 0) {
    console.log('No results found. Trying alternative search term...');
    // Try an alternative search if the first one yields no results
    const alternativeQuery = options.keyword.toLowerCase() === 'handyman' 
      ? `home repair ${options.location}`  // More generic alternative for handyman
      : `${options.keyword} repair service ${options.location}`;
    const alternativeUrl = `${GOOGLE_PLACES_API_URL}/textsearch/json?query=${encodeURIComponent(alternativeQuery)}&key=${GOOGLE_PLACES_API_KEY}`;
    
    console.log('Alternative API Request:', {
      query: alternativeQuery,
      timestamp: new Date().toISOString()
    });

    const alternativeResponse = await makeRequest(alternativeUrl, {}, 10) as PlacesApiResponse;
    
    console.log('Alternative API Response:', {
      status: alternativeResponse.status,
      resultsCount: alternativeResponse.results?.length || 0,
      errorMessage: alternativeResponse.error_message,
      timestamp: new Date().toISOString()
    });

    if (alternativeResponse.results.length > 0) {
      searchResponse.results = alternativeResponse.results;
    }
  }
  
  // Fetch additional details for each place
  const detailedResults = await Promise.all(
    searchResponse.results.map(async (place) => {
      const fields = [
        'formatted_phone_number',
        'international_phone_number',
        'website',
        'opening_hours',
        'rating',
        'user_ratings_total',
        'reviews',
        'formatted_address'
      ].join(',');
      const detailsUrl = `${GOOGLE_PLACES_API_URL}/details/json?place_id=${place.place_id}&fields=${fields}&key=${GOOGLE_PLACES_API_KEY}`;
      
      try {
        const detailsResponse = await makeRequest(detailsUrl, {}, 10) as PlaceDetailsResponse;
        const details = detailsResponse.result;
        
        return {
          ...place,
          formatted_phone_number: details.formatted_phone_number,
          international_phone_number: details.international_phone_number,
          website: details.website,
          opening_hours: details.opening_hours,
          rating: details.rating,
          user_ratings_total: details.user_ratings_total,
          reviews: details.reviews,
          formatted_address: details.formatted_address
        };
      } catch (error) {
        console.error(`Error fetching details for place ${place.place_id}:`, error);
        return place;
      }
    })
  );

  return {
    ...searchResponse,
    results: detailedResults
  };
}

export async function searchPlaces(
  keyword: string,
  location: string
): Promise<PlacesApiResponse> {
  try {
    await connectDB();
    console.log(`Searching for places with keyword: "${keyword}" in location: "${location}"`);
    
    // Force cache refresh for specific categories that need better results
    const forceRefreshCategories = ['handyman', 'masonry', 'decks', 'flooring', 'windows', 'fencing'];
    const shouldForceRefresh = forceRefreshCategories.includes(keyword.toLowerCase());

    // Check cache first
    const cachedData = await PlaceCache.findOne({
      keyword: keyword.toLowerCase(),
      location: location.toLowerCase(),
    });

    if (cachedData && !shouldForceRefresh) {
      console.log('Cache hit! Returning cached data');
      // Check if cache is still valid
      const cacheAge = (Date.now() - cachedData.createdAt.getTime()) / (1000 * 60 * 60 * 24); // age in days
      if (cacheAge < CACHE_EXPIRY_DAYS) {
        return cachedData.data;
      }
      console.log('Cache expired, fetching fresh data');
      await PlaceCache.deleteOne({ _id: cachedData._id });
    } else {
      console.log('Cache miss or force refresh, fetching from Google Places API');
    }

    // If not in cache or expired, fetch from Google Places API
    const searchQuery = `${keyword} in ${location}`;
    const options: PlacesApiOptions = {
      keyword: searchQuery,
      location,
      locationBias: DENVER_BOUNDS // Add location bias to Denver metro area
    };

    const response = await fetchFromGooglePlaces(options);
    
    // Filter results to ensure they're within Denver metro area
    response.results = response.results.filter(place => {
      const lat = place.geometry.location.lat;
      const lng = place.geometry.location.lng;
      return lat >= DENVER_BOUNDS.southwest.lat &&
             lat <= DENVER_BOUNDS.northeast.lat &&
             lng >= DENVER_BOUNDS.southwest.lng &&
             lng <= DENVER_BOUNDS.northeast.lng;
    });

    // Cache the results
    try {
      const newCache = new PlaceCache({
        keyword: keyword.toLowerCase(),
        location: location.toLowerCase(),
        data: response
      });
      await newCache.save();
      console.log('Successfully cached search results');
    } catch (error) {
      console.error('Failed to cache search results:', error);
    }

    return response;
  } catch (error) {
    console.error('Error in searchPlaces:', error);
    return {
      results: [],
      status: 'ERROR',
      error_message: error instanceof Error ? error.message : 'Unknown error occurred'
    };
  }
}