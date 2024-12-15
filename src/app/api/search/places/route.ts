import { NextResponse } from 'next/server';

const GOOGLE_PLACES_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
const GOOGLE_PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place';

interface PlaceDetails {
  formatted_phone_number?: string;
  international_phone_number?: string;
  website?: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
  rating?: number;
  user_ratings_total?: number;
}

interface Place {
  place_id: string;
  name: string;
  formatted_address: string;
  geometry: {
    location: {
      lat: number;
      lng: number;
    };
  };
  types?: string[];
}

interface PlaceSearchResponse {
  results: Place[];
  status: string;
  error_message?: string;
}

interface PlaceDetailsResponse {
  result: PlaceDetails;
  status: string;
  error_message?: string;
}

interface SearchResult {
  results: (Place & PlaceDetails)[];
  status: string;
}

async function getPlaceDetails(placeId: string): Promise<PlaceDetails | null> {
  const fields = [
    'formatted_phone_number',
    'international_phone_number',
    'website',
    'opening_hours',
    'rating',
    'user_ratings_total'
  ].join(',');

  const detailsUrl = `${GOOGLE_PLACES_API_URL}/details/json?place_id=${placeId}&fields=${fields}&key=${GOOGLE_PLACES_API_KEY}`;
  
  try {
    const response = await fetch(detailsUrl);
    if (!response.ok) {
      throw new Error('Failed to fetch place details');
    }
    const data = await response.json() as PlaceDetailsResponse;
    if (data.status !== 'OK') {
      console.error('Place Details API Error:', data);
      return null;
    }
    return data.result;
  } catch (error) {
    console.error(`Error fetching details for place ${placeId}:`, error);
    return null;
  }
}

export async function GET(request: Request): Promise<NextResponse> {
  try {
    const { searchParams } = new URL(request.url);
    const keyword = searchParams.get('keyword');
    const location = searchParams.get('location') || 'Denver, CO';

    if (!keyword) {
      return NextResponse.json(
        { error: 'Search term is required' },
        { status: 400 }
      );
    }

    if (!GOOGLE_PLACES_API_KEY) {
      return NextResponse.json(
        { error: 'Google Places API key not configured' },
        { status: 500 }
      );
    }

    const query = `${keyword} in ${location}`;
    const searchUrl = `${GOOGLE_PLACES_API_URL}/textsearch/json?query=${encodeURIComponent(
      query
    )}&key=${GOOGLE_PLACES_API_KEY}`;

    const response = await fetch(searchUrl);
    if (!response.ok) {
      throw new Error('Failed to fetch from Google Places API');
    }

    const data = await response.json() as PlaceSearchResponse;
    if (data.status !== 'OK') {
      console.error('Text Search API Error:', data);
      return NextResponse.json(
        { error: data.error_message || 'No results found' },
        { status: data.status === 'ZERO_RESULTS' ? 404 : 500 }
      );
    }
    
    // Fetch additional details for each place
    const detailedResults = await Promise.all(
      data.results.map(async (place: Place) => {
        const details = await getPlaceDetails(place.place_id);
        return {
          ...place,
          ...details
        };
      })
    );

    // Filter out any null results
    const validResults = detailedResults.filter(result => result !== null);

    if (validResults.length === 0) {
      return NextResponse.json(
        { error: 'No results found for your search' },
        { status: 404 }
      );
    }

    return NextResponse.json({ 
      results: validResults,
      status: 'OK'
    } as SearchResult, {
      headers: {
        'Cache-Control': 'no-store, must-revalidate',
        'Expires': '0',
      }
    });
  } catch (error) {
    console.error('Places API Error:', error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'Failed to fetch results' },
      { status: 500 }
    );
  }
}
