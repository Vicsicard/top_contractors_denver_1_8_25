type PlacesSearchResult = {
  name: string;
  formatted_address: string;
  place_id: string;
  rating?: number;
  user_ratings_total?: number;
}

export async function searchPlaces(keyword: string, location: string): Promise<PlacesSearchResult[]> {
  const apiKey = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  
  // Format the query string
  const query = `${keyword} in ${location}`;
  
  // Encode the query for URL
  const encodedQuery = encodeURIComponent(query);
  
  try {
    const response = await fetch(
      `https://places.googleapis.com/v1/places:searchText`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': apiKey!,
          'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.id,places.rating,places.userRatingCount'
        },
        body: JSON.stringify({
          textQuery: query,
          languageCode: "en"
        })
      }
    );

    if (!response.ok) {
      throw new Error(`Google Places API error: ${response.statusText}`);
    }

    const data = await response.json();
    
    return data.places.map((place: any) => ({
      name: place.displayName.text,
      formatted_address: place.formattedAddress,
      place_id: place.id,
      rating: place.rating,
      user_ratings_total: place.userRatingCount
    }));
  } catch (error) {
    console.error('Error fetching places:', error);
    throw error;
  }
} 