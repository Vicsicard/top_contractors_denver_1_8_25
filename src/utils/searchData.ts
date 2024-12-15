import { Business } from '@/types/business';
import { Contractor } from '@/types/routes';
import { searchPlaces, PlacesSearchResult } from './googlePlaces';

interface SearchOptions {
  skip?: number;
  limit?: number;
}

interface SearchResult {
  locations: Business[];
  total: number;
}

function locationToBusiness(place: PlacesSearchResult): Business {
  return {
    name: place.name,
    rating: place.rating || 0,
    reviewCount: place.user_ratings_total || 0,
    address: place.formatted_address,
    categories: place.categories || [],
    phone: place.phone || '',
    website: place.website || ''
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
    services: business.categories
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
    const places = await searchPlaces(query, 'Denver, Colorado');
    console.log(`Received ${places.length} places from Google Places API`);
    
    const businesses = places.map(locationToBusiness);
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
  const places = await searchPlaces(keyword, location);
  const businesses = places.map(locationToBusiness);
  return businesses.map(businessToContractor);
}

export function loadSearchData(): { keywords: string[]; locations: string[] } {
  return {
    keywords: [],
    locations: []
  };
}
