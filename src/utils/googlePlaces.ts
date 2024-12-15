import { connectDB } from './mongodb';
import { PlaceCache } from '@/models/PlaceCache';

interface GooglePlacesResponse {
  results: Place[];
  status: string;
  error_message?: string;
}

interface Place {
  place_id: string;
  name: string;
  formatted_address: string;
  rating?: number;
  user_ratings_total?: number;
  photos?: { photo_reference: string }[];
  categories?: string[];
  phone?: string;
  website?: string;
  geometry?: {
    location: {
      lat: number;
      lng: number;
    };
  };
}

interface PlaceApiResponse {
  places: {
    id: string;
    displayName: {
      text: string;
    };
    formattedAddress: string;
    rating?: number;
    userRatingCount?: number;
  }[];
}

const CACHE_PREFIX = 'places_';

export async function searchPlaces(
  keyword: string,
  location: string
): Promise<GooglePlacesResponse> {
  try {
    await connectDB();

    // Check cache first
    const cacheKey = `${CACHE_PREFIX}${keyword}-${location}`.toLowerCase();
    const cachedResult = await PlaceCache.findOne({ cacheKey });

    if (cachedResult) {
      console.log('Cache hit:', cacheKey);
      return {
        results: [cachedResult.data],
        status: 'OK'
      };
    }

    console.log('Cache miss:', cacheKey);

    // Make API request
    const apiKey = process.env.GOOGLE_PLACES_API_KEY;
    if (!apiKey) {
      throw new Error('Google Places API key not configured');
    }

    const url = new URL('https://places.googleapis.com/v1/places:searchText');
    const body = {
      textQuery: `${keyword} near ${location}`,
      languageCode: 'en',
      locationBias: {
        circle: {
          center: {
            latitude: 39.7392,
            longitude: -104.9903
          },
          radius: 50000.0
        }
      }
    };

    const response = await fetch(url.toString(), {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'places.id,places.displayName,places.formattedAddress,places.rating,places.userRatingCount'
      },
      body: JSON.stringify(body)
    });

    if (!response.ok) {
      throw new Error(`API request failed: ${response.statusText}`);
    }

    const data = await response.json() as PlaceApiResponse;
    const places = data.places || [];

    // Transform results
    const results: GooglePlacesResponse = {
      results: places.map((place) => ({
        place_id: place.id,
        name: place.displayName?.text || '',
        formatted_address: place.formattedAddress || '',
        rating: place.rating || 0,
        user_ratings_total: place.userRatingCount || 0,
        geometry: {
          location: {
            lat: 39.7392,
            lng: -104.9903
          }
        }
      })),
      status: 'OK'
    };

    // Cache results
    await cachePlaces(results, cacheKey);

    return results;
  } catch (error) {
    console.error('Search error:', error);
    return {
      results: [],
      status: 'ERROR',
      error_message: error instanceof Error ? error.message : 'Unknown error'
    };
  }
}

async function cachePlaces(response: GooglePlacesResponse, cacheKey: string): Promise<void> {
  try {
    await PlaceCache.findOneAndUpdate(
      { cacheKey },
      {
        $set: {
          data: response.results,
          timestamp: new Date()
        }
      },
      { upsert: true }
    );
  } catch (error) {
    console.error('Cache error:', error);
  }
}