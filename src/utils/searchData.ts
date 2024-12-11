import { Contractor, Location } from '@/types/routes';

// Mock data for development
const MOCK_LOCATIONS: Location[] = [
  { location: 'Denver', county: 'Denver County' },
  { location: 'Aurora', county: 'Arapahoe County' },
  { location: 'Lakewood', county: 'Jefferson County' },
  { location: 'Arvada', county: 'Jefferson County' },
  { location: 'Westminster', county: 'Adams County' }
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

export async function loadLocations(_keyword: string): Promise<Location[]> {
  // In a real app, this would fetch from an API or database
  return MOCK_LOCATIONS;
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
