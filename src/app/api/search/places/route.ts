import { NextResponse } from 'next/server';

const GOOGLE_PLACES_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
const GOOGLE_PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place';

async function getPlaceDetails(placeId: string) {
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
    const data = await response.json();
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
    const location = searchParams.get('location');

    if (!keyword || !location) {
      return NextResponse.json(
        { error: 'Missing required parameters' },
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

    const data = await response.json();
    
    // Fetch additional details for each place
    const detailedResults = await Promise.all(
      data.results.map(async (place: any) => {
        const details = await getPlaceDetails(place.place_id);
        return {
          ...place,
          ...details
        };
      })
    );

    return NextResponse.json({ results: detailedResults });
  } catch (error) {
    console.error('Places API Error:', error);
    return NextResponse.json(
      { error: 'Failed to fetch results' },
      { status: 500 }
    );
  }
}
