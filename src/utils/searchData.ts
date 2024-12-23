import { Business } from '@/types/business';
import { Contractor } from '@/types/routes';
import { searchPlaces } from './googlePlaces';
import { PlaceResult } from '@/types/places';

interface SearchOptions {
  skip?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
  location?: string;
}

interface SearchResult {
  locations: Business[];
  total: number;
}

function locationToBusiness(place: PlaceResult): Business {
  return {
    id: place.place_id,
    name: place.name,
    rating: place.rating || 0,
    reviewCount: place.user_ratings_total || 0,
    address: place.formatted_address,
    categories: place.types || [],
    phone: place.international_phone_number || '',
    website: place.website || '',
    location: {
      lat: place.geometry.location.lat,
      lng: place.geometry.location.lng
    }
  };
}

function businessToContractor(business: Business): Contractor {
  return {
    id: business.name.toLowerCase().replace(/\s+/g, '-'),
    name: business.name,
    rating: business.rating,
    reviewCount: business.reviewCount,
    address: business.address,
    phone: business.phone,
    website: business.website,
    services: business.categories || []
  };
}

export async function loadLocations(query: string, options?: SearchOptions): Promise<SearchResult> {
  console.log('Loading locations for query:', query);
  
  // During build time, return mock data
  if (process.env.NODE_ENV === 'production' && process.env.NEXT_PHASE === 'phase-production-build') {
    return {
      locations: [],
      total: 0
    };
  }
  
  const defaultOptions = {
    skip: 0,
    limit: 10,
    sort: 'rating',
    order: 'desc' as const,
    location: 'Denver, CO'
  };

  const mergedOptions = { ...defaultOptions, ...options };
  
  try {
    // Remove any 'contractors' suffix if present
    const cleanQuery = query.toLowerCase().replace(/\s+contractors?$/, '').trim();
    console.log('Clean query:', cleanQuery);

    const placesResponse = await searchPlaces(cleanQuery, mergedOptions.location);
    
    if (!placesResponse.results) {
      console.log('No results found for query:', cleanQuery);
      return { locations: [], total: 0 };
    }

    const businesses = placesResponse.results.map(locationToBusiness);
    
    return {
      locations: businesses,
      total: businesses.length
    };
  } catch (error) {
    console.error('Error loading locations:', error);
    return { locations: [], total: 0 };
  }
}

export async function loadContractors(keyword: string, location: string): Promise<Contractor[]> {
  try {
    console.log('Loading contractors:', { keyword, location });

    // Clean up the keyword to ensure it's contractor-focused
    const searchKeyword = keyword.toLowerCase().includes('contractor') ? 
      keyword : 
      `${keyword} contractor`;

    // Search for contractors
    console.log('Searching with keyword:', searchKeyword);
    const placesResponse = await searchPlaces(searchKeyword, location);
    
    if (!placesResponse.results || placesResponse.results.length === 0) {
      console.log('No results found for:', { searchKeyword, location });
      return [];
    }

    console.log(`Found ${placesResponse.results.length} results`);
    
    // Convert places to businesses then to contractors
    const businesses = placesResponse.results.map(locationToBusiness);
    const contractors = businesses.map(businessToContractor);

    console.log('Processed contractors:', {
      count: contractors.length,
      firstContractor: contractors[0]?.name
    });

    return contractors;
  } catch (error) {
    console.error('Error loading contractors:', error);
    throw error;
  }
}

export async function searchBusinesses(
  keyword: string,
  location: string,
  options: SearchOptions = {}
): Promise<{ businesses: Business[]; total: number }> {
  try {
    // Ensure location is in Colorado
    const fullLocation = `${location}, Colorado`;
    console.log(`Searching businesses in ${fullLocation}`);
    const placesResponse = await searchPlaces(keyword, fullLocation);
    const places = placesResponse.results;

    const businesses: Business[] = places.map((place: PlaceResult) => ({
      id: place.place_id,
      name: place.name,
      address: place.formatted_address,
      rating: place.rating || 0,
      reviewCount: place.user_ratings_total || 0,
      location: {
        lat: place.geometry.location.lat,
        lng: place.geometry.location.lng
      }
    }));

    // Apply pagination
    const skip = options.skip || 0;
    const limit = options.limit || 10;
    const paginatedBusinesses = businesses.slice(skip, skip + limit);

    return {
      businesses: paginatedBusinesses,
      total: businesses.length
    };
  } catch (error) {
    console.error('Error searching businesses:', error);
    return {
      businesses: [],
      total: 0
    };
  }
}

export function loadSearchData(): { keywords: string[]; locations: string[] } {
  return {
    keywords: [],
    locations: []
  };
}
