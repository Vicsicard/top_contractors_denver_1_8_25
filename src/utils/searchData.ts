import { Business } from '@/types/business';
import { Contractor } from '@/types/routes';
import { searchPlaces, PlaceResult } from './googlePlaces';

interface SearchOptions {
  skip?: number;
  limit?: number;
  sort?: string;
  order?: 'asc' | 'desc';
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
  
  if (!query) {
    console.log('Empty query, returning empty results');
    return {
      locations: [],
      total: 0
    };
  }

  try {
    const placesResponse = await searchPlaces(query, 'Denver, Colorado');
    console.log(`Received ${placesResponse.results.length} places from Google Places API`);
    
    const businesses = placesResponse.results.map(locationToBusiness);
    console.log(`Transformed ${businesses.length} places to businesses`);

    const skip = options?.skip || 0;
    const limit = options?.limit || 10;
    const paginatedResults = businesses.slice(skip, skip + limit);

    return {
      locations: paginatedResults,
      total: businesses.length
    };
  } catch (error) {
    console.error('Error loading locations:', error);
    return {
      locations: [],
      total: 0
    };
  }
}

export async function loadContractors(keyword: string, location: string): Promise<Contractor[]> {
  const placesResponse = await searchPlaces(keyword, location);
  const businesses = placesResponse.results.map(locationToBusiness);
  return businesses.map(businessToContractor);
}

export async function searchBusinesses(
  keyword: string,
  location: string,
  options: SearchOptions = {}
): Promise<{ businesses: Business[]; total: number }> {
  try {
    const placesResponse = await searchPlaces(keyword, location);
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
