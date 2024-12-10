import { PlaceCache } from '@/models/PlaceCache';

interface GooglePlace {
  id: string;
  displayName: {
    text: string;
  };
  formattedAddress: string;
  rating?: number;
  userRatingCount?: number;
}

interface PlaceSearchResponse {
  places: GooglePlace[];
}

interface PlacesSearchResult {
  name: string;
  formatted_address: string;
  place_id: string;
  rating?: number;
  user_ratings_total?: number;
}

interface PlacesApiError {
  error: {
    code: number;
    message: string;
    status: string;
  };
}

export async function searchPlaces(keyword: string, location: string): Promise<PlacesSearchResult[]> {
  const apiKey = process.env.GOOGLE_PLACES_API_KEY;
  if (!apiKey) {
    throw new Error('Google Places API key not found');
  }

  // Check cache first
  const cachedResults = await PlaceCache.find({
    keyword,
    location,
    createdAt: { $gt: new Date(Date.now() - 180 * 24 * 60 * 60 * 1000) } // 180 days
  }).lean();

  if (cachedResults.length > 0) {
    return cachedResults.map(result => result.data);
  }

  // If not in cache, fetch from Google Places API
  const searchQuery = `${keyword} in ${location}`;
  const url = 'https://places.googleapis.com/v1/places:searchText';
  
  const headers = new Headers({
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': apiKey,
    'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.id,places.rating,places.userRatingCount'
  });

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers,
      body: JSON.stringify({
        textQuery: searchQuery,
        languageCode: 'en',
        maxResultCount: 10
      })
    });

    if (!response.ok) {
      throw new Error(`Google Places API error: ${response.statusText}`);
    }

    const data = await response.json() as PlaceSearchResponse | PlacesApiError;
    
    if ('error' in data) {
      throw new Error(`Google Places API error: ${data.error.message}`);
    }
    
    const results = data.places.map(place => ({
      name: place.displayName.text,
      formatted_address: place.formattedAddress,
      place_id: place.id,
      rating: place.rating,
      user_ratings_total: place.userRatingCount
    }));

    // Cache the results
    await Promise.all(results.map(result =>
      PlaceCache.create({
        placeId: result.place_id,
        data: {
          ...result,
          last_updated: new Date()
        },
        keyword,
        location
      })
    ));

    return results;
  } catch (error) {
    console.error('Error fetching places:', error);
    throw error;
  }
}