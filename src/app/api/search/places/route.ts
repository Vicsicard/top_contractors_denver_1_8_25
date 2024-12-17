import { NextRequest, NextResponse } from 'next/server';
import { makeRequestWithBackoff } from '@/utils/apiUtils';

const GOOGLE_PLACES_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
const GOOGLE_PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place/textsearch/json';
const GOOGLE_PLACES_DETAILS_URL = 'https://maps.googleapis.com/maps/api/place/details/json';

// Log environment check at startup
console.log('Environment check:', {
  hasApiKey: !!GOOGLE_PLACES_API_KEY,
  apiKeyLength: GOOGLE_PLACES_API_KEY?.length,
  apiKeyValue: GOOGLE_PLACES_API_KEY?.substring(0, 5) + '...',  // Only show first 5 chars
  allEnvVars: Object.keys(process.env),  // Only log the keys, not the values
  apiUrl: GOOGLE_PLACES_API_URL
});

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

interface PlaceDetails {
  result: {
    formatted_phone_number?: string;
    website?: string;
    opening_hours?: {
      open_now?: boolean;
      weekday_text?: string[];
    };
  };
  status: string;
}

interface GooglePlacesResponse {
  results: Place[];
  status: string;
  error_message?: string;
}

export async function GET(request: NextRequest): Promise<NextResponse> {
  console.log('API Route: Received request');
  try {
    const searchParams = request.nextUrl.searchParams;
    const keyword = searchParams.get('keyword') || 'contractor';
    const location = searchParams.get('location') || 'Denver, CO';
    
    console.log('Search parameters:', { keyword, location, apiKeyExists: !!GOOGLE_PLACES_API_KEY });
    
    if (!GOOGLE_PLACES_API_KEY) {
      console.error('API Error: Google Places API key not configured');
      return NextResponse.json(
        { 
          error: 'API configuration error', 
          message: 'Google Places API key is not configured'
        },
        { 
          status: 500,
          headers: { 'Content-Type': 'application/json' }
        }
      );
    }

    // Construct the search query
    const query = `${keyword} in ${location}`.trim();
    console.log('Constructed query:', query);

    const placesUrl = `${GOOGLE_PLACES_API_URL}?query=${encodeURIComponent(query)}&key=${GOOGLE_PLACES_API_KEY}&type=business`;
    
    const data = await makeRequestWithBackoff(
      placesUrl,
      {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        }
      }
    );

    const googlePlacesResponse = data as GooglePlacesResponse;
    console.log('Response data:', {
      status: googlePlacesResponse.status,
      resultsCount: googlePlacesResponse.results?.length,
      errorMessage: googlePlacesResponse.error_message
    });

    if (googlePlacesResponse.status !== 'OK') {
      console.error('Google Places API Error:', googlePlacesResponse.error_message);
      return NextResponse.json(
        { 
          error: 'Google Places API Error', 
          message: googlePlacesResponse.error_message 
        },
        { 
          status: 400,
          headers: { 'Content-Type': 'application/json' }
        }
      );
    }

    // Fetch additional details for each place
    const placesWithDetails = await Promise.all(
      googlePlacesResponse.results.map(async (place) => {
        try {
          const detailsUrl = `${GOOGLE_PLACES_DETAILS_URL}?place_id=${place.place_id}&key=${GOOGLE_PLACES_API_KEY}&fields=formatted_phone_number,website,opening_hours`;
          
          const detailsData = await makeRequestWithBackoff(
            detailsUrl,
            {
              method: 'GET',
              headers: {
                'Content-Type': 'application/json',
              }
            }
          );

          const placeDetails = detailsData as PlaceDetails;

          if (placeDetails.status !== 'OK') {
            console.error('Error fetching place details:', {
              placeId: place.place_id,
              status: placeDetails.status,
              error: placeDetails.error_message
            });
            return place;
          }

          return {
            ...place,
            phone_number: placeDetails.result?.formatted_phone_number,
            website: placeDetails.result?.website,
            opening_hours: placeDetails.result?.opening_hours
          };
        } catch (error) {
          console.error('Error fetching place details:', error);
          return place;
        }
      })
    );

    return NextResponse.json(
      { 
        results: placesWithDetails,
        status: 'success'
      },
      { 
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      }
    );

  } catch (error) {
    console.error('Unexpected error:', error);
    return NextResponse.json(
      { 
        error: 'Internal server error', 
        message: error instanceof Error ? error.message : 'Unknown error'
      },
      { 
        status: 500,
        headers: { 'Content-Type': 'application/json' }
      }
    );
  }
}
