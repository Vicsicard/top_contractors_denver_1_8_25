import { Contractor } from '@/types/routes';
import { Location } from '@/types/location';
import { Business } from '@/types/business';
import { searchPlaces, PlacesSearchResult } from './googlePlaces';

// Mock data for development
const MOCK_CONTRACTORS: Contractor[] = [
  {
    id: '1',
    name: 'Denver Best Contractors',
    rating: 4.8,
    reviewCount: 125,
    address: '123 Main St, Denver, CO',
    phone: '(303) 555-0123',
    website: 'https://example.com',
    services: ['Remodeling', 'Renovation', 'New Construction']
  },
  {
    id: '2',
    name: 'Quality Home Services',
    rating: 4.5,
    reviewCount: 89,
    address: '456 Oak Ave, Denver, CO',
    phone: '(303) 555-0124',
    services: ['Home Repair', 'Maintenance']
  }
];

const MOCK_KEYWORDS = [
  'Remodeling',
  'Renovation',
  'New Construction',
  'Home Repair',
  'Maintenance'
];

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

export async function loadLocations(query: string, options?: SearchOptions): Promise<SearchResult> {
  try {
    const places = await searchPlaces(query, 'Denver, Colorado');
    const businesses = places.map(locationToBusiness);
    
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

export async function loadContractors(_keyword: string, _location: string): Promise<Contractor[]> {
  // In a real app, this would fetch from an API or database
  return MOCK_CONTRACTORS;
}

export function loadSearchData(): { keywords: string[]; locations: Location[] } {
  return {
    keywords: MOCK_KEYWORDS,
    locations: []
  };
}
