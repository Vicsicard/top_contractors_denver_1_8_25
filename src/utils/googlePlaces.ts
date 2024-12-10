interface GooglePlace {
  displayName: {
    text: string;
  };
  formattedAddress: string;
  id: string;
  rating?: {
    value: number;
  };
  userRatingCount?: {
    value: number;
  };
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

interface PlacesApiResponse {
  places: GooglePlace[];
}

export async function searchPlaces(keyword: string, location: string): Promise<PlacesSearchResult[]> {
  const apiKey = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  
  // Format the query string
  const query = `${keyword} in ${location}`;
  
  try {
    const response = await fetch(
      `https://places.googleapis.com/v1/places:searchText`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': apiKey,
          'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.id,places.rating,places.userRatingCount',
        },
        body: JSON.stringify({ textQuery: query }),
      }
    );

    if (!response.ok) {
      throw new Error(`Google Places API error: ${response.statusText}`);
    }

    const data = await response.json() as PlacesApiResponse | PlacesApiError;
    
    if ('error' in data) {
      throw new Error(`Google Places API error: ${data.error.message}`);
    }
    
    return data.places.map((place: GooglePlace) => ({
      name: place.displayName.text,
      formatted_address: place.formattedAddress,
      place_id: place.id,
      rating: place.rating?.value,
      user_ratings_total: place.userRatingCount?.value,
    }));
  } catch (error) {
    console.error('Error fetching places:', error);
    throw error;
  }
}