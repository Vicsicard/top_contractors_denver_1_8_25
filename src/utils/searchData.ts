import { Contractor } from '@/types/routes';
import { Location } from '@/types/location';
import { Business } from '@/types/business';

// Mock data for development
const MOCK_LOCATIONS: Location[] = [
  {
    location: 'Denver',
    name: 'Denver City',
    services: ['Plumbing', 'Electrical', 'HVAC']
  },
  {
    location: 'Aurora',
    name: 'Aurora City',
    services: ['Roofing', 'Landscaping']
  },
  {
    location: 'Lakewood',
    name: 'Lakewood Area',
    services: ['Painting', 'Carpentry']
  },
  {
    location: 'Arvada',
    name: 'Arvada District',
    services: ['Flooring', 'Windows']
  },
  {
    location: 'Westminster',
    name: 'Westminster Zone',
    services: ['Electrical', 'Plumbing']
  }
];

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

function locationToBusiness(location: Location): Business {
  return {
    name: location.location,
    rating: 0,
    reviewCount: 0,
    address: location.location,
    categories: [],
    phone: ''
  };
}

export async function loadLocations(query: string, options?: SearchOptions): Promise<SearchResult> {
  // Mock implementation for now
  const mockLocations: Location[] = MOCK_LOCATIONS;

  const { skip = 0, limit = 10 } = options || {};
  const filteredLocations = mockLocations
    .filter(loc => loc.location.toLowerCase().includes(query.toLowerCase()))
    .map(locationToBusiness);

  return {
    locations: filteredLocations.slice(skip, skip + limit),
    total: filteredLocations.length
  };
}

export async function loadContractors(_keyword: string, _location: string): Promise<Contractor[]> {
  // In a real app, this would fetch from an API or database
  return MOCK_CONTRACTORS;
}

export function loadSearchData(): { keywords: string[]; locations: Location[] } {
  return {
    keywords: MOCK_KEYWORDS,
    locations: MOCK_LOCATIONS
  };
}
