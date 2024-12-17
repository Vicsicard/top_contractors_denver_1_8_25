import { PlaceCache } from '../models/PlaceCache';
import { connectDB } from './mongodb';
import Bottleneck from 'bottleneck';

// Track API usage
let tokenUsage = 0;
const TOKEN_LIMIT = 100000; // Google Places API daily quota
const REQUEST_LIMIT = 100; // Requests per hour limit
const HOURLY_RESET = 60 * 60 * 1000; // 1 hour in milliseconds

// Configure rate limiter with token and request tracking
const limiter = new Bottleneck({
  maxConcurrent: 1, // Process one request at a time
  reservoir: REQUEST_LIMIT, // Hourly request limit
  reservoirRefreshAmount: REQUEST_LIMIT,
  reservoirRefreshInterval: HOURLY_RESET, // Reset hourly
  minTime: 200 // Minimum time between requests
});

// Reset token usage counter hourly
setInterval(() => {
  tokenUsage = 0;
  console.log('Token usage reset');
}, HOURLY_RESET);

// Track rate limit state
let isRateLimited = false;
const _RATE_LIMIT_RESET_TIME = 60 * 1000; // 1 minute cooldown

async function makeRequestWithRetry(
  url: string,
  options: RequestInit,
  estimatedTokens: number = 1000, // Default token estimation
  retryCount = 0
): Promise<PlacesApiResponse | PlaceDetailsResponse> {
  const _maxRetries = 5;

  return limiter.schedule(async () => {
    // Check token usage
    if (tokenUsage + estimatedTokens > TOKEN_LIMIT) {
      console.warn('Token limit reached. Waiting for reset...');
      await new Promise(resolve => setTimeout(resolve, HOURLY_RESET));
      tokenUsage = 0;
    }

    try {
      // Check rate limit status
      if (isRateLimited) {
        console.warn('Rate limit active. Waiting for cooldown...');
        await new Promise(resolve => setTimeout(resolve, _RATE_LIMIT_RESET_TIME));
        isRateLimited = false;
      }

      console.log(`Making request to: ${url}`);
      console.log(`Current token usage: ${tokenUsage}/${TOKEN_LIMIT}`);
      
      const response = await fetch(url, options);
      
      // Handle rate limiting
      if (response.status === 429) {
        isRateLimited = true;
        const retryAfter = parseInt(response.headers.get("Retry-After") || "60", 10);
        console.warn(`Rate limit exceeded. Waiting ${retryAfter} seconds...`);
        await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
        
        if (retryCount < _maxRetries) {
          return makeRequestWithRetry(url, options, estimatedTokens, retryCount + 1);
        }
        throw new Error('Max retries reached for rate limit');
      }

      if (!response.ok) {
        throw new Error(`HTTP Error: ${response.status}`);
      }

      const data = await response.json();
      
      // Update token usage
      tokenUsage += estimatedTokens;
      console.log(`Updated token usage: ${tokenUsage}/${TOKEN_LIMIT}`);
      
      return data;
    } catch (error) {
      console.error('Request error:', error);
      if (retryCount < _maxRetries) {
        const delay = Math.min(1000 * Math.pow(2, retryCount), 60000);
        console.warn(`Request failed. Retrying in ${delay}ms...`);
        await new Promise(resolve => setTimeout(resolve, delay));
        return makeRequestWithRetry(url, options, estimatedTokens, retryCount + 1);
      }
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

type PlaceDetailsResponse = {
  result: {
    name: string;
    formatted_address: string;
    formatted_phone_number?: string;
    international_phone_number?: string;
    website?: string;
    opening_hours?: {
      open_now?: boolean;
      weekday_text?: string[];
    };
    rating?: number;
    user_ratings_total?: number;
    reviews?: any[];
    formatted_address?: string;
  };
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
}

const CACHE_EXPIRY_DAYS = 180; // 180 days
const _MAX_RETRIES = 5; // Increased from 3 to 5
const _BASE_DELAY = 2000; // Increased from 1000 to 2000ms
const _MAX_DELAY = 60000; // 60 seconds maximum delay

async function fetchFromGooglePlaces(options: PlacesApiOptions): Promise<PlacesApiResponse> {
  const GOOGLE_PLACES_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  const GOOGLE_PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place';

  if (!GOOGLE_PLACES_API_KEY) {
    throw new Error('Google Places API key not configured');
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

  const enhancedKeyword = searchTermMap[options.keyword.toLowerCase()] || options.keyword;
  const query = `${enhancedKeyword} ${options.location}`;
  const searchUrl = `${GOOGLE_PLACES_API_URL}/textsearch/json?query=${encodeURIComponent(query)}&key=${GOOGLE_PLACES_API_KEY}`;

  console.log('API Request:', {
    originalKeyword: options.keyword,
    enhancedKeyword,
    query,
    timestamp: new Date().toISOString()
  });

  const searchResponse = await makeRequestWithRetry(searchUrl, {}, 10) as PlacesApiResponse;
  
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

    const alternativeResponse = await makeRequestWithRetry(alternativeUrl, {}, 10) as PlacesApiResponse;
    
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
        const detailsResponse = await makeRequestWithRetry(detailsUrl, {}, 10) as PlaceDetailsResponse;
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
    const response = await fetchFromGooglePlaces({ keyword, location });
    
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