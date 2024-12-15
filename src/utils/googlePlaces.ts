import { PlaceCache } from '../models/PlaceCache';
import { connectDB } from './mongodb';

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
  international_phone_number?: string;
  website?: string;
  types?: string[];
}

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
const MAX_RETRIES = 3;
const BASE_DELAY = 1000; // 1 second

async function makeRequestWithRetry(
  url: string,
  options: RequestInit,
  retryCount = 0
): Promise<PlacesApiResponse> {
  try {
    const response = await fetch(url, options);
    
    if (response.status === 429) {
      if (retryCount >= MAX_RETRIES) {
        throw new Error('Max retries exceeded for rate limit');
      }
      const retryAfter = parseInt(response.headers.get('Retry-After') || '0', 10);
      const delay = retryAfter * 1000 || Math.min(BASE_DELAY * Math.pow(2, retryCount), 60000);
      console.log(`Rate limit exceeded. Retrying after ${delay/1000} seconds...`);
      await new Promise(resolve => setTimeout(resolve, delay));
      return makeRequestWithRetry(url, options, retryCount + 1);
    }

    if (!response.ok) {
      throw new Error(`API request failed: ${response.statusText}`);
    }

    return response.json();
  } catch (error) {
    if (error instanceof Error && error.message.includes('rate limit')) {
      throw error;
    }
    if (retryCount < MAX_RETRIES) {
      const delay = BASE_DELAY * Math.pow(2, retryCount);
      console.log(`Request failed. Retrying after ${delay/1000} seconds...`);
      await new Promise(resolve => setTimeout(resolve, delay));
      return makeRequestWithRetry(url, options, retryCount + 1);
    }
    throw error;
  }
}

async function fetchFromGooglePlaces(options: PlacesApiOptions): Promise<PlacesApiResponse> {
  const apiKey = process.env.GOOGLE_PLACES_API_KEY;
  if (!apiKey) {
    throw new Error('Google Places API key not configured');
  }

  const url = new URL('https://maps.googleapis.com/maps/api/place/textsearch/json');
  url.searchParams.set('key', apiKey);
  url.searchParams.set('query', `${options.keyword} near ${options.location}`);

  const requestOptions = {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  };

  const data = await makeRequestWithRetry(url.toString(), requestOptions);
  const results: PlacesApiResponse = {
    results: data.results.map((place) => ({
      place_id: place.place_id,
      name: place.name,
      formatted_address: place.formatted_address,
      geometry: {
        location: {
          lat: place.geometry.location.lat,
          lng: place.geometry.location.lng
        }
      },
      rating: place.rating,
      user_ratings_total: place.user_ratings_total,
      international_phone_number: place.international_phone_number,
      website: place.website,
      types: place.types
    })),
    status: data.status
  };

  return results;
}

export async function searchPlaces(
  keyword: string,
  location: string
): Promise<PlacesApiResponse> {
  try {
    await connectDB();
    console.log(`Searching for places with keyword: "${keyword}" in location: "${location}"`);
    
    // Check cache first
    const cachedData = await PlaceCache.findOne({
      keyword: keyword.toLowerCase(),
      location: location.toLowerCase(),
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