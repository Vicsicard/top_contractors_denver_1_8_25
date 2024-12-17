import { NextRequest } from 'next/server';

const GOOGLE_PLACES_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
const GOOGLE_PLACES_API_URL = 'https://maps.googleapis.com/maps/api/place/textsearch/json';
const GOOGLE_PLACES_DETAILS_URL = 'https://maps.googleapis.com/maps/api/place/details/json';

// Log environment check at startup
console.log('Environment check:', {
  hasApiKey: !!GOOGLE_PLACES_API_KEY,
  apiKeyLength: GOOGLE_PLACES_API_KEY?.length,
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

export async function GET(request: NextRequest): Promise<Response> {
  try {
    const searchParams = request.nextUrl.searchParams;
    const keyword = searchParams.get('keyword') || 'contractor';
    const location = searchParams.get('location') || 'Denver, CO';
    
    console.log('Search request:', { keyword, location });
    
    if (!GOOGLE_PLACES_API_KEY) {
      console.error('API Error: Google Places API key not configured');
      return Response.json(
        { 
          error: 'API configuration error', 
          message: 'Google Places API key is not configured'
        },
        { status: 500 }
      );
    }

    // Construct the search query
    const query = `${keyword} in ${location}`.trim();
    
    // Build URL with parameters
    const url = new URL(GOOGLE_PLACES_API_URL);
    url.searchParams.append('query', query);
    url.searchParams.append('key', GOOGLE_PLACES_API_KEY);
    url.searchParams.append('type', 'business');
    
    // Log the request URL (without API key)
    const logUrl = url.toString().replace(GOOGLE_PLACES_API_KEY, '[REDACTED]');
    console.log('Fetching from Google Places API:', logUrl);
    
    // Make the request
    const response = await fetch(url.toString());

    // Log response status
    console.log('Google Places API response:', {
      status: response.status,
      ok: response.ok,
      statusText: response.statusText
    });

    const data = await response.json() as GooglePlacesResponse;
    console.log('API Response data:', {
      status: data.status,
      hasResults: !!data.results,
      resultsCount: data.results?.length,
      errorMessage: data.error_message
    });

    if (!response.ok) {
      console.error('API Error:', {
        status: response.status,
        statusText: response.statusText,
        data
      });
      return Response.json(
        { 
          error: 'Google Places API Error',
          message: data.error_message || 'Failed to fetch places from Google API',
          status: response.status 
        },
        { status: response.status }
      );
    }

    if (data.status !== 'OK') {
      console.error('Google Places API Error:', data.error_message);
      return Response.json(
        { 
          error: 'Google Places API Error',
          message: data.error_message || 'Failed to fetch places',
          status: data.status
        },
        { status: 400 }
      );
    }

    // Fetch additional details for each place
    const placesWithDetails = await Promise.all(
      data.results.map(async (place) => {
        try {
          const detailsUrl = new URL(GOOGLE_PLACES_DETAILS_URL);
          detailsUrl.searchParams.append('place_id', place.place_id);
          detailsUrl.searchParams.append('key', GOOGLE_PLACES_API_KEY);
          detailsUrl.searchParams.append('fields', 'formatted_phone_number,website,opening_hours');

          const detailsResponse = await fetch(detailsUrl.toString());
          const detailsData = await detailsResponse.json() as PlaceDetails;

          if (!detailsResponse.ok) {
            console.error('Error fetching place details:', {
              placeId: place.place_id,
              status: detailsResponse.status,
              error: detailsData.error_message
            });
            return place;
          }

          return {
            ...place,
            phone_number: detailsData.result?.formatted_phone_number,
            website: detailsData.result?.website,
            opening_hours: detailsData.result?.opening_hours
          };
        } catch (error) {
          console.error('Error fetching place details:', error);
          return place;
        }
      })
    );

    return Response.json({ 
      results: placesWithDetails,
      status: 'success'
    });
    
  } catch (error) {
    console.error('Unexpected error:', error);
    return Response.json(
      { 
        error: 'Internal Server Error',
        message: 'An unexpected error occurred while fetching results',
        details: error instanceof Error ? error.message : 'Unknown error'
      },
      { status: 500 }
    );
  }
}
