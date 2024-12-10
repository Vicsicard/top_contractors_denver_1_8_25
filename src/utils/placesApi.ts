import { PlaceCache } from '../models/PlaceCache';
import { connectDB } from './mongodb';

export interface PlacesApiOptions {
  keyword: string;
  location: string;
}

export interface PlacesApiResponse {
  results: Array<any>;
  status: string;
  error_message?: string;
}

const CACHE_EXPIRY_DAYS = 180; // 180 days

export async function getPlacesData(options: PlacesApiOptions): Promise<PlacesApiResponse> {
  try {
    await connectDB();
    console.log(`Searching for places with keyword: "${options.keyword}" in location: "${options.location}"`);
    
    // Check cache first
    const cachedData = await PlaceCache.findOne({
      keyword: options.keyword.toLowerCase(),
      location: options.location.toLowerCase(),
    });

    if (cachedData) {
      console.log('Cache hit! Returning cached data');
      // Check if cache is still valid
      const cacheAge = (Date.now() - cachedData.createdAt.getTime()) / (1000 * 60 * 60 * 24); // age in days
      if (cacheAge < CACHE_EXPIRY_DAYS) {
        return cachedData.data;
      }
      console.log('Cache expired, fetching fresh data');
      await PlaceCache.deleteOne({ _id: cachedData._id });
    } else {
      console.log('Cache miss, fetching from Google Places API');
    }

    // If not in cache or expired, fetch from Google Places API
    const response = await fetchFromGooglePlaces(options);
    
    // Cache the results
    try {
      await PlaceCache.create({
        placeId: `${options.keyword.toLowerCase()}-${options.location.toLowerCase()}`,
        data: response,
        keyword: options.keyword.toLowerCase(),
        location: options.location.toLowerCase(),
        createdAt: new Date(),
      });
      console.log('Successfully cached the results');
    } catch (cacheError) {
      console.error('Error caching results:', cacheError);
      // Don't throw here - we still want to return the response even if caching fails
    }

    return response;
  } catch (error) {
    console.error('Error in getPlacesData:', error);
    if (error instanceof Error) {
      console.error('Error details:', {
        message: error.message,
        stack: error.stack,
      });
    }
    throw error;
  }
}

async function fetchFromGooglePlaces(options: PlacesApiOptions): Promise<PlacesApiResponse> {
  const { keyword, location } = options;
  const apiKey = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  
  console.log('Environment variables:', {
    hasGoogleKey: !!process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY,
    hasMongoUri: !!process.env.MONGODB_URI,
    envKeys: Object.keys(process.env)
  });
  
  if (!apiKey) {
    throw new Error('Google Places API key is not configured');
  }

  try {
    const searchQuery = encodeURIComponent(`${keyword} in ${location}`);
    const url = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${searchQuery}&key=${apiKey}`;

    console.log('Fetching data from Google Places API...');
    const response = await fetch(url);
    const data = await response.json();

    if (!response.ok) {
      throw new Error(`Google Places API error: ${data.error_message || 'Unknown error'}`);
    }

    if (data.status !== 'OK' && data.status !== 'ZERO_RESULTS') {
      throw new Error(`Google Places API returned status: ${data.status}`);
    }

    console.log(`Successfully fetched ${data.results?.length || 0} results from Google Places API`);
    return data;
  } catch (error) {
    console.error('Error fetching from Google Places API:', error);
    throw error;
  }
}
