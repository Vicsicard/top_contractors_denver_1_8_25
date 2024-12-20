import { NextRequest, NextResponse } from 'next/server';
import { makeRequestWithBackoff } from '@/utils/apiUtils';

// This ensures the route is handled at runtime
export const dynamic = 'force-dynamic';
export const runtime = 'edge';

// Skip API calls during build time
const isBuildTime = process.env.NODE_ENV === 'production' && process.env.NEXT_PHASE === 'phase-production-build';

interface Place {
  place_id: string;
  name: string;
  formatted_address: string;
  geometry?: {
    location: {
      lat: number;
      lng: number;
    };
  };
  rating?: number;
  types?: string[];
  formatted_phone_number?: string;
  website?: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
}

interface PlaceDetailsResult {
  formatted_phone_number?: string;
  website?: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
}

interface PlacesApiResponse {
  results: Place[];
  status: string;
  error_message?: string;
}

interface PlaceDetailsApiResponse {
  result: PlaceDetailsResult;
  status: string;
}

export async function GET(request: NextRequest) {
  // Return mock data during build time
  if (isBuildTime) {
    return NextResponse.json({
      results: [],
      status: 'success',
      _info: 'Build time response'
    });
  }

  // Only access API key after build time check
  const GOOGLE_PLACES_API_KEY = process.env.GOOGLE_PLACES_API_KEY;

  try {
    const GOOGLE_PLACES_API_URL = 'https://places.googleapis.com/v1/places:searchText';
    const GOOGLE_PLACES_DETAILS_URL = 'https://places.googleapis.com/v1/places';

    if (!GOOGLE_PLACES_API_KEY) {
      console.warn('API key not configured');
      return NextResponse.json(
        { error: 'Service temporarily unavailable' },
        { status: 503 }
      );
    }

    const { searchParams } = new URL(request.url);
    const query = searchParams.get('query');
    const location = searchParams.get('location') || 'Denver, CO';

    if (!query) {
      return NextResponse.json(
        { error: 'Query parameter is required' },
        { status: 400 }
      );
    }

    const searchQuery = `${query} in ${location}`;
    
    // Using the new Places API v3 format
    const searchRequest = {
      textQuery: searchQuery,
      languageCode: 'en',
      maxResultCount: 20,
      locationBias: {
        circle: {
          center: {
            latitude: 39.7392,  // Denver's latitude
            longitude: -104.9903  // Denver's longitude
          },
          radius: 50000.0  // 50km radius
        }
      }
    };

    const searchResponse = await makeRequestWithBackoff(() => 
      fetch(GOOGLE_PLACES_API_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': GOOGLE_PLACES_API_KEY,
          'X-Goog-FieldMask': 'places.id,places.displayName,places.formattedAddress,places.location,places.rating,places.types'
        },
        body: JSON.stringify(searchRequest)
      })
    );

    const data = await searchResponse.json();
    
    if (!data.places || !Array.isArray(data.places)) {
      throw new Error('Invalid response format from Places API');
    }

    // Transform the response to match our expected format
    const transformedResults = data.places.map(place => ({
      place_id: place.id,
      name: place.displayName?.text || '',
      formatted_address: place.formattedAddress || '',
      geometry: place.location ? {
        location: {
          lat: place.location.latitude,
          lng: place.location.longitude
        }
      } : undefined,
      rating: place.rating,
      types: place.types || []
    }));

    // Fetch additional details for each place
    const placesWithDetails = await Promise.all(
      transformedResults.map(async (place) => {
        try {
          const detailsResponse = await makeRequestWithBackoff(() =>
            fetch(`${GOOGLE_PLACES_DETAILS_URL}/${place.place_id}`, {
              headers: {
                'X-Goog-Api-Key': GOOGLE_PLACES_API_KEY,
                'X-Goog-FieldMask': 'phoneNumber,websiteUri,currentOpeningHours'
              }
            })
          );

          const details = await detailsResponse.json();

          return {
            ...place,
            phone_number: details.phoneNumber,
            website: details.websiteUri,
            opening_hours: details.currentOpeningHours ? {
              open_now: details.currentOpeningHours.openNow,
              weekday_text: details.currentOpeningHours.weekdayDescriptions
            } : undefined
          };
        } catch (error) {
          console.error('Error fetching place details:', error);
          return place;
        }
      })
    );

    return NextResponse.json({
      results: placesWithDetails,
      status: 'success'
    });
  } catch (error) {
    console.error('Search places error:', error);
    return NextResponse.json(
      { 
        error: 'Failed to fetch data',
        message: error instanceof Error ? error.message : 'Unknown error'
      },
      { status: 500 }
    );
  }
}
