import { NextRequest, NextResponse } from 'next/server';
import { makeRequestWithBackoff } from '@/utils/apiUtils';

// Make the route static by default
export const dynamic = 'force-static';
export const revalidate = 3600; // Revalidate every hour

// Skip API calls during build time
const isBuildTime = process.env.NODE_ENV === 'production' && process.env.NEXT_PHASE === 'phase-production-build';

// Validate environment variables at module level
if (!isBuildTime && !process.env.GOOGLE_PLACES_API_KEY) {
  console.error('GOOGLE_PLACES_API_KEY is not defined in environment variables');
}

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
  user_ratings_total?: number;
  types?: string[];
  business_status?: string;
}

interface PlaceDetailsResult {
  formatted_phone_number?: string;
  website?: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
  business_status?: string;
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
  try {
    // Return mock data during build time
    if (isBuildTime) {
      return NextResponse.json({
        results: [],
        status: 'success',
        _info: 'Build time response'
      });
    }

    const searchParams = request.nextUrl.searchParams;
    const query = searchParams.get('query');
    const location = searchParams.get('location') || 'Denver, CO';
    const type = searchParams.get('type');

    console.log('Received search request:', { query, location, type });

    if (!query) {
      console.error('Missing query parameter');
      return NextResponse.json(
        { 
          error: 'Missing query parameter',
          message: 'A search query is required',
          code: 'MISSING_PARAM'
        },
        { status: 400 }
      );
    }

    // Only access API key after build time check
    const GOOGLE_PLACES_API_KEY = process.env.GOOGLE_PLACES_API_KEY;

    if (!GOOGLE_PLACES_API_KEY) {
      console.error('Google Places API key is not defined');
      return NextResponse.json(
        { 
          error: 'Service configuration error',
          message: 'The service is not properly configured',
          code: 'ENV_VAR_MISSING'
        },
        { status: 503 }
      );
    }

    // Build search query based on category and type
    let searchQuery = query;
    const queryLower = query.toLowerCase();

    // Handle popular trades with specific search terms
    if (type === 'contractor' || !type) {  
      if (queryLower.includes('plumb')) {
        searchQuery = 'plumbing contractor plumber';
      } else if (queryLower.includes('electric')) {
        searchQuery = 'licensed electrical contractor';
      } else if (queryLower.includes('hvac') || queryLower.includes('air condition')) {
        searchQuery = 'licensed hvac contractor';
      } else if (queryLower.includes('roof')) {
        searchQuery = 'licensed roofing contractor';
      } else if (queryLower.includes('landscap')) {
        searchQuery = 'professional landscaping contractor';
      } else if (queryLower.includes('mason')) {
        searchQuery = 'professional masonry contractor';
      } else if (queryLower.includes('deck')) {
        searchQuery = 'professional deck building contractor';
      } else if (queryLower.includes('floor')) {
        searchQuery = 'professional flooring contractor';
      } else if (queryLower.includes('fenc')) {
        searchQuery = 'professional fence installation contractor';
      } else if (queryLower.includes('window')) {
        searchQuery = 'professional window installation contractor';
      } else if (queryLower.includes('paint')) {
        searchQuery = 'professional painting contractor';
      } else if (queryLower.includes('remodel') || queryLower.includes('renovation')) {
        if (queryLower.includes('kitchen')) {
          searchQuery = 'professional kitchen remodeling contractor';
        } else if (queryLower.includes('bathroom')) {
          searchQuery = 'professional bathroom remodeling contractor';
        } else {
          searchQuery = 'professional home remodeling contractor';
        }
      } else if (queryLower.includes('siding') || queryLower.includes('gutter')) {
        searchQuery = 'professional siding and gutter contractor';
      } else if (queryLower.includes('epoxy') || queryLower.includes('garage floor')) {
        searchQuery = 'professional epoxy garage floor contractor';
      } else if (queryLower.includes('carpent')) {
        searchQuery = 'professional carpentry contractor';
      } else {
        // Ensure "contractor" is in the search query
        searchQuery = queryLower.includes('contractor') ? query : `${query} contractor`;
      }
    }

    // Add location to search query if not already present
    const locationLower = location.toLowerCase();
    const finalLocation = locationLower.includes('denver') ? location : `${location}, Denver, CO`;
    
    // Build the final search query
    const searchTerms = [searchQuery];
    if (!searchQuery.toLowerCase().includes(finalLocation.toLowerCase())) {
      searchTerms.push('in', finalLocation);
    }
    const finalQuery = searchTerms.join(' ');

    console.log('Search parameters:', {
      originalQuery: query,
      processedQuery: searchQuery,
      location: finalLocation,
      type: type,
      finalQuery: finalQuery
    });

    // Use Text Search for more accurate category-based results
    const url = new URL('https://maps.googleapis.com/maps/api/place/textsearch/json');
    url.searchParams.append('query', finalQuery);
    url.searchParams.append('key', GOOGLE_PLACES_API_KEY);

    // Add type parameter if specified (but don't use general_contractor as it's too limiting)
    if (type && type !== 'contractor') {
      url.searchParams.append('type', type);
    }

    const logUrl = new URL(url.toString());
    logUrl.searchParams.set('key', 'REDACTED');
    console.log('API URL:', logUrl.toString());
    
    const response = await makeRequestWithBackoff(() => fetch(url.toString()));
    const responseText = await response.text();
    
    console.log('Raw API Response:', responseText.substring(0, 500)); // Log first 500 chars of raw response
    console.log('API Response Status:', response.status);
    console.log('API Response Headers:', Object.fromEntries(response.headers.entries()));
    
    let data;
    try {
      data = JSON.parse(responseText);
      console.log('API Response:', {
        status: data.status,
        resultsCount: data.results?.length || 0,
        errorMessage: data.error_message,
        firstResult: data.results?.[0]?.name,
        results: data.results?.slice(0, 2) // Log first 2 results for debugging
      });

      // Handle specific API response statuses
      if (data.status === 'ZERO_RESULTS') {
        console.log('No results found for query:', finalQuery);
        return NextResponse.json({
          results: [],
          status: 'ZERO_RESULTS',
          message: 'No contractors found for your search. Try broadening your search terms.'
        });
      } else if (data.status === 'REQUEST_DENIED') {
        console.error('API request denied:', data.error_message);
        return NextResponse.json(
          {
            error: 'API Error',
            message: 'Search service is temporarily unavailable. Please try again later.',
            code: 'REQUEST_DENIED'
          },
          { status: 503 }
        );
      } else if (data.status !== 'OK') {
        console.error('API Error:', { status: data.status, error_message: data.error_message });
        return NextResponse.json(
          {
            error: 'API Error',
            message: data.error_message || 'Failed to fetch results',
            code: data.status
          },
          { status: 500 }
        );
      }

      // If we have results, ensure they're relevant
      if (data.results && Array.isArray(data.results)) {
        data.results = data.results.filter(result => {
          const name = (result.name || '').toLowerCase();
          const types = (result.types || []).map(t => t.toLowerCase());
          const address = (result.formatted_address || '').toLowerCase();
          
          // Ensure result is in Denver area
          const isDenverArea = address.includes('denver') || 
                             address.includes('colorado') || 
                             address.includes('co');
          
          // Check if it's a relevant business
          const isRelevantBusiness = 
            name.includes('contractor') ||
            name.includes('construction') ||
            name.includes('service') ||
            name.includes('repair') ||
            name.includes('build') ||
            name.includes('remodel') ||
            types.some(t => 
              t.includes('contractor') || 
              t.includes('service') || 
              t.includes('repair') ||
              t.includes('construction') ||
              t === 'general_contractor' ||
              t === 'home_goods_store' ||
              t === 'store' ||
              t === 'point_of_interest'
            );

          return isDenverArea && isRelevantBusiness;
        });

        console.log('Filtered results:', {
          originalCount: data.results.length,
          filteredCount: data.results.length,
          firstResult: data.results[0]?.name
        });
      }

      return NextResponse.json(data);
    } catch (parseError) {
      console.error('Error parsing response:', parseError);
      return NextResponse.json(
        { 
          error: 'Invalid response',
          message: 'Failed to parse API response',
          code: 'PARSE_ERROR'
        },
        { status: 500 }
      );
    }
  } catch (error) {
    console.error('Error processing request:', error);
    return NextResponse.json(
      { 
        error: 'Server Error',
        message: 'An unexpected error occurred',
        code: 'INTERNAL_ERROR'
      },
      { status: 500 }
    );
  }
}
