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
  businessStatus?: string;
  phoneNumber?: string;
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

const CACHE_DURATION = 180 * 24 * 60 * 60 * 1000; // 180 days in milliseconds
const MAX_RETRIES = 3;
const RETRY_DELAY = 1000; // 1 second

async function delay(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export async function searchPlaces(keyword: string, location: string): Promise<PlacesSearchResult[]> {
  const apiKey = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  console.log('Starting Google Places search with:', { keyword, location });
  
  if (!apiKey) {
    console.error('API key missing in environment variables');
    throw new Error('Google Places API key not found');
  }

  // Check cache first
  try {
    const cachedResults = await PlaceCache.find({
      keyword: keyword.toLowerCase(),
      location: location.toLowerCase(),
      createdAt: { $gt: new Date(Date.now() - CACHE_DURATION) }
    }).lean();

    if (cachedResults.length > 0) {
      console.log('Cache hit! Returning cached results:', cachedResults.length);
      return cachedResults.map(result => result.data);
    }

    console.log('Cache miss. Fetching from Google Places API...');

    // If not in cache, fetch from Google Places API
    const searchQuery = `${keyword} in ${location}`;
    const url = 'https://places.googleapis.com/v1/places:searchText';
    
    console.log('Making API request to:', url);
    console.log('Search query:', searchQuery);
    
    const headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask': [
        'places.id',
        'places.displayName',
        'places.formattedAddress',
        'places.rating',
        'places.userRatingCount',
        'places.types',
        'places.businessStatus',
        'places.phoneNumber',
        'places.websiteUri'
      ].join(',')
    };

    console.log('Request headers:', { ...headers, 'X-Goog-Api-Key': '[REDACTED]' });

    let lastError: Error | null = null;
    
    for (let attempt = 1; attempt <= MAX_RETRIES; attempt++) {
      try {
        console.log(`Attempt ${attempt} of ${MAX_RETRIES}`);
        
        const response = await fetch(url, {
          method: 'POST',
          headers,
          body: JSON.stringify({
            textQuery: searchQuery,
            languageCode: 'en',
            maxResultCount: 20,
            locationBias: {
              circle: {
                center: {
                  latitude: 39.7392,  // Denver's latitude
                  longitude: -104.9903 // Denver's longitude
                },
                radius: 30000.0 // 30km radius
              }
            }
          })
        });

        console.log('Response status:', response.status);
        
        if (!response.ok) {
          const errorText = await response.text();
          console.error('API Error Response:', errorText);
          throw new Error(`HTTP error! status: ${response.status}, body: ${errorText}`);
        }

        const data = await response.json() as PlaceSearchResponse | PlacesApiError;
        
        if ('error' in data) {
          console.error('Google Places API error:', data.error);
          throw new Error(`Google Places API error: ${data.error.message}`);
        }
        
        console.log('Successfully received', data.places.length, 'results from API');
        
        const results = data.places.map(place => ({
          name: place.displayName.text,
          formatted_address: place.formattedAddress,
          place_id: place.id,
          rating: place.rating,
          user_ratings_total: place.userRatingCount,
          categories: place.types?.filter(type => !type.startsWith('gc_')) || [],
          phone: place.phoneNumber,
          website: place.websiteUri
        }));

        // Cache the results
        console.log('Caching', results.length, 'results');
        await Promise.all(results.map(result =>
          PlaceCache.create({
            placeId: result.place_id,
            data: result,
            keyword: keyword.toLowerCase(),
            location: location.toLowerCase(),
            createdAt: new Date()
          })
        ));

        console.log(`Successfully fetched and cached ${results.length} results`);
        return results;
        
      } catch (error) {
        lastError = error instanceof Error ? error : new Error('Unknown error occurred');
        console.error(`Attempt ${attempt} failed:`, lastError.message);
        
        if (attempt < MAX_RETRIES) {
          const delayMs = RETRY_DELAY * Math.pow(2, attempt - 1);
          console.log(`Retrying in ${delayMs}ms...`);
          await delay(delayMs);
        }
      }
    }

    console.error('All retry attempts failed');
    throw lastError || new Error('Failed to fetch places after all retries');
  } catch (error) {
    console.error('Fatal error in searchPlaces:', error);
    throw error;
  }
}