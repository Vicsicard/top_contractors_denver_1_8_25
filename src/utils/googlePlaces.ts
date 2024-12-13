import { connectDB } from './mongodb';
import { PlaceCache } from '@/models/PlaceCache';

interface GooglePlace {
  id: string;
  displayName: {
    text: string;
  };
  formattedAddress: string;
  rating?: number;
  userRatingCount?: number;
  types?: string[];
  internationalPhoneNumber?: string;
  websiteUri?: string;
}

interface PlaceSearchResponse {
  places: GooglePlace[];
}

export interface PlacesSearchResult {
  name: string;
  formatted_address: string;
  place_id: string;
  rating?: number;
  user_ratings_total?: number;
  categories?: string[];
  phone?: string;
  website?: string;
}

interface PlacesApiError {
  error: {
    code: number;
    message: string;
    status: string;
  };
}

const CACHE_DURATION = 7 * 24 * 60 * 60 * 1000; // 7 days in milliseconds (as per docs)
const MAX_RETRIES = 3;
const RETRY_DELAY = 1000; // 1 second

async function delay(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export async function searchPlaces(
  keyword: string,
  location: string
): Promise<PlacesSearchResult[]> {
  try {
    // Connect to MongoDB
    await connectDB();

    // Check cache first
    const cachedResults = await PlaceCache.findByKeywordAndLocation(keyword, location);
    if (cachedResults.length > 0) {
      console.log(' Cache HIT:', {
        keyword,
        location,
        resultCount: cachedResults.length,
        timestamp: new Date().toISOString()
      });
      return cachedResults.map(result => result.data);
    }

    console.log(' Cache MISS:', {
      keyword,
      location,
      timestamp: new Date().toISOString()
    });

    // If not in cache, fetch from Google Places API
    const apiKey = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
    if (!apiKey) {
      throw new Error('Google Places API key not found');
    }

    const searchQuery = `${keyword} in ${location}`;
    const endpoint = 'https://places.googleapis.com/v1/places:searchText';
    
    const response = await fetch(endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.id,places.rating,places.userRatingCount,places.types,places.internationalPhoneNumber,places.websiteUri'
      },
      body: JSON.stringify({
        textQuery: searchQuery,
        languageCode: 'en',
        maxResultCount: 20
      })
    });

    if (!response.ok) {
      const error = await response.text();
      throw new Error(`Google Places API error: ${error}`);
    }

    const data = await response.json();
    const places = data.places || [];

    // Transform and cache results
    const results: PlacesSearchResult[] = places.map((place: any) => ({
      name: place.displayName?.text || '',
      formatted_address: place.formattedAddress || '',
      place_id: place.id || '',
      rating: place.rating || 0,
      user_ratings_total: place.userRatingCount || 0,
      categories: place.types || [],
      phone: place.internationalPhoneNumber || '',
      website: place.websiteUri || ''
    }));

    console.log(' Caching results:', {
      keyword,
      location,
      resultCount: results.length,
      timestamp: new Date().toISOString()
    });

    // Cache each result
    const cachePlaces = async (places: PlacesSearchResult[], keyword: string, location: string) => {
      for (const place of places) {
        try {
          await PlaceCache.findOneAndUpdate(
            { placeId: place.place_id },
            {
              $set: {
                data: place,
                keyword: keyword.toLowerCase().trim(),
                location: location.toLowerCase().trim(),
                createdAt: new Date()
              }
            },
            { upsert: true, new: true }
          );
        } catch (error) {
          // Log the error but don't throw it - we want to continue caching other places
          console.error('Server', 'Error caching place:', error);
        }
      }
    };

    await cachePlaces(results, keyword, location);

    return results;
  } catch (error) {
    console.error('Error in searchPlaces:', error);
    throw error;
  }
}