// Helper type for contractor data
interface ContractorData {
  contractor_name: string;
  address: string;
  phone: string;
  website: string;
  reviews_avg: number;
  reviews_count: number;
  categories: string[];
  region_slug: string;
  area_slug: string;
  neighborhood_slug: string;
  business_hours?: string;
  emergency_service?: boolean;
  years_in_business?: number;
}

interface LocationParams {
  trade: string;
  region: string;
  area: string;
}

export function getContractorsByLocation({ trade, region, area }: LocationParams): ContractorData[] {
  return contractorData
    .filter(contractor => 
      contractor.categories.includes(trade.toLowerCase()) &&
      contractor.region_slug === region.toLowerCase() &&
      contractor.area_slug === area.toLowerCase()
    )
    .map(contractor => ({
      contractor_name: contractor.contractor_name,
      address: contractor.address,
      phone: contractor.phone,
      website: contractor.website,
      reviews_avg: contractor.reviews_avg,
      reviews_count: contractor.reviews_count,
      categories: contractor.categories,
      region_slug: contractor.region_slug,
      area_slug: contractor.area_slug,
      neighborhood_slug: contractor.neighborhood_slug,
      business_hours: contractor.business_hours,
      emergency_service: contractor.emergency_service || false,
      years_in_business: contractor.years_in_business || 0
    }));
}

export const contractorData: ContractorData[] = [
  // Downtown Denver Plumbers
  {
    contractor_name: "Mile High Plumbing Pros",
    address: "1700 Broadway, Denver, CO 80202",
    phone: "(303) 555-0101",
    website: "https://milehighplumbing.com",
    reviews_avg: 4.8,
    reviews_count: 156,
    categories: ["plumber"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 15
  },
  {
    contractor_name: "Denver Elite Plumbers",
    address: "1600 Glenarm Pl, Denver, CO 80202",
    phone: "(303) 555-0102",
    website: "https://denvereliteplumbers.com",
    reviews_avg: 4.7,
    reviews_count: 203,
    categories: ["plumber"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 12
  },
  {
    contractor_name: "Capitol Hill Plumbing & Heating",
    address: "1010 E 6th Ave, Denver, CO 80218",
    phone: "(303) 555-0103",
    website: "https://capitolhillplumbing.com",
    reviews_avg: 4.9,
    reviews_count: 178,
    categories: ["plumber", "hvac"],
    region_slug: "central-denver",
    area_slug: "capitol-hill-area",
    neighborhood_slug: "capitol-hill",
    emergency_service: true,
    years_in_business: 20
  },
  {
    contractor_name: "Five Points Plumbing Solutions",
    address: "2855 Larimer St, Denver, CO 80205",
    phone: "(303) 555-0104",
    website: "https://5pointsplumbing.com",
    reviews_avg: 4.6,
    reviews_count: 142,
    categories: ["plumber"],
    region_slug: "central-denver",
    area_slug: "five-points-area",
    neighborhood_slug: "five-points",
    emergency_service: true,
    years_in_business: 8
  },

  // Downtown Denver Electricians
  {
    contractor_name: "Downtown Electric Masters",
    address: "1644 Platte St, Denver, CO 80202",
    phone: "(303) 555-0201",
    website: "https://downtownelectric.com",
    reviews_avg: 4.8,
    reviews_count: 167,
    categories: ["electrician"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 18
  },
  {
    contractor_name: "Urban Circuit Solutions",
    address: "1555 Blake St, Denver, CO 80202",
    phone: "(303) 555-0202",
    website: "https://urbancircuit.com",
    reviews_avg: 4.6,
    reviews_count: 142,
    categories: ["electrician"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 10
  },
  {
    contractor_name: "Capitol Hill Electric Co",
    address: "1200 E 7th Ave, Denver, CO 80218",
    phone: "(303) 555-0203",
    website: "https://capitolhillelectric.com",
    reviews_avg: 4.7,
    reviews_count: 189,
    categories: ["electrician"],
    region_slug: "central-denver",
    area_slug: "capitol-hill-area",
    neighborhood_slug: "capitol-hill",
    emergency_service: true,
    years_in_business: 25
  },

  // Downtown Denver HVAC
  {
    contractor_name: "Denver HVAC Experts",
    address: "1801 California St, Denver, CO 80202",
    phone: "(303) 555-0301",
    website: "https://denverhvacexperts.com",
    reviews_avg: 4.7,
    reviews_count: 189,
    categories: ["hvac"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 15
  },
  {
    contractor_name: "Mile High Heating & Cooling",
    address: "1899 Wynkoop St, Denver, CO 80202",
    phone: "(303) 555-0302",
    website: "https://milehighheating.com",
    reviews_avg: 4.8,
    reviews_count: 234,
    categories: ["hvac"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 22
  },

  // Downtown Denver Roofers
  {
    contractor_name: "Denver Roofing Masters",
    address: "1700 Lincoln St, Denver, CO 80203",
    phone: "(303) 555-0401",
    website: "https://denverroofingmasters.com",
    reviews_avg: 4.9,
    reviews_count: 145,
    categories: ["roofer"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: true,
    years_in_business: 20
  },
  {
    contractor_name: "Capitol Hill Roofing Pros",
    address: "1155 Sherman St, Denver, CO 80203",
    phone: "(303) 555-0402",
    website: "https://capitolhillroofing.com",
    reviews_avg: 4.7,
    reviews_count: 167,
    categories: ["roofer"],
    region_slug: "central-denver",
    area_slug: "capitol-hill-area",
    neighborhood_slug: "capitol-hill",
    emergency_service: true,
    years_in_business: 15
  },

  // Downtown Denver Carpenters
  {
    contractor_name: "Urban Woodworks",
    address: "2001 Market St, Denver, CO 80205",
    phone: "(303) 555-0501",
    website: "https://urbanwoodworks.com",
    reviews_avg: 4.9,
    reviews_count: 123,
    categories: ["carpenter"],
    region_slug: "central-denver",
    area_slug: "lo-do-area",
    neighborhood_slug: "lo-do",
    emergency_service: false,
    years_in_business: 12
  },
  {
    contractor_name: "Denver Custom Carpentry",
    address: "1435 Wazee St, Denver, CO 80202",
    phone: "(303) 555-0502",
    website: "https://denvercustomcarpentry.com",
    reviews_avg: 4.8,
    reviews_count: 156,
    categories: ["carpenter"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 18
  },

  // Downtown Denver Painters
  {
    contractor_name: "Mile High Painters",
    address: "1600 Champa St, Denver, CO 80202",
    phone: "(303) 555-0601",
    website: "https://milehighpainters.com",
    reviews_avg: 4.7,
    reviews_count: 178,
    categories: ["painter"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 10
  },
  {
    contractor_name: "Denver Color Experts",
    address: "1401 17th St, Denver, CO 80202",
    phone: "(303) 555-0602",
    website: "https://denvercolorexperts.com",
    reviews_avg: 4.8,
    reviews_count: 145,
    categories: ["painter"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 8
  },

  // Downtown Denver Landscapers
  {
    contractor_name: "Urban Landscape Design",
    address: "1600 Market St, Denver, CO 80202",
    phone: "(303) 555-0701",
    website: "https://urbanlandscapedenver.com",
    reviews_avg: 4.8,
    reviews_count: 167,
    categories: ["landscaper"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 15
  },
  {
    contractor_name: "Denver Gardens & Lawns",
    address: "1755 Blake St, Denver, CO 80202",
    phone: "(303) 555-0702",
    website: "https://denvergardens.com",
    reviews_avg: 4.6,
    reviews_count: 134,
    categories: ["landscaper"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 12
  },

  // Downtown Denver Kitchen Remodeling
  {
    contractor_name: "Denver Kitchen Designs",
    address: "1601 Wewatta St, Denver, CO 80202",
    phone: "(303) 555-0801",
    website: "https://denverkitchendesigns.com",
    reviews_avg: 4.9,
    reviews_count: 112,
    categories: ["kitchen-remodeling"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 20
  },
  {
    contractor_name: "Mile High Kitchen & Bath",
    address: "1700 Bassett St, Denver, CO 80202",
    phone: "(303) 555-0802",
    website: "https://milehighkitchens.com",
    reviews_avg: 4.7,
    reviews_count: 98,
    categories: ["kitchen-remodeling"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 15
  },

  // Downtown Denver Deck Builders
  {
    contractor_name: "Denver Deck Pros",
    address: "1800 15th St, Denver, CO 80202",
    phone: "(303) 555-0901",
    website: "https://denverdeckpros.com",
    reviews_avg: 4.8,
    reviews_count: 89,
    categories: ["decks"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 10
  },
  {
    contractor_name: "Urban Deck & Patio",
    address: "1900 16th St, Denver, CO 80202",
    phone: "(303) 555-0902",
    website: "https://urbandeckdenver.com",
    reviews_avg: 4.7,
    reviews_count: 76,
    categories: ["decks"],
    region_slug: "central-denver",
    area_slug: "downtown-area",
    neighborhood_slug: "downtown-denver",
    emergency_service: false,
    years_in_business: 8
  },

  // Downtown Denver Fence Contractors
  {
    contractor_name: "Denver Fence Company",
    address: "2000 Larimer St, Denver, CO 80205",
    phone: "(303) 555-1001",
    website: "https://denverfencecompany.com",
    reviews_avg: 4.6,
    reviews_count: 123,
    categories: ["fencing"],
    region_slug: "central-denver",
    area_slug: "lo-do-area",
    neighborhood_slug: "lo-do",
    emergency_service: false,
    years_in_business: 12
  },
  {
    contractor_name: "Mile High Fencing",
    address: "2100 Lawrence St, Denver, CO 80205",
    phone: "(303) 555-1002",
    website: "https://milehighfencing.com",
    reviews_avg: 4.7,
    reviews_count: 145,
    categories: ["fencing"],
    region_slug: "central-denver",
    area_slug: "lo-do-area",
    neighborhood_slug: "lo-do",
    emergency_service: false,
    years_in_business: 15
  }
];

// Generate SQL for database population
export function generateContractorSQL(contractor: ContractorData, id: string): string {
  return `
-- Insert contractor
INSERT INTO contractors (
  id,
  contractor_name,
  address,
  phone,
  website,
  reviews_avg,
  reviews_count,
  business_hours,
  emergency_service,
  years_in_business
) VALUES (
  '${id}',
  '${contractor.contractor_name}',
  '${contractor.address}',
  '${contractor.phone}',
  '${contractor.website}',
  ${contractor.reviews_avg},
  ${contractor.reviews_count},
  ${contractor.business_hours ? `'${contractor.business_hours}'` : 'NULL'},
  ${contractor.emergency_service || false},
  ${contractor.years_in_business || 0}
);

-- Add category relationships
${contractor.categories.map(category => `
INSERT INTO contractor_categories (contractor_id, category_id)
SELECT '${id}', id FROM categories WHERE category_name = '${category}';
`).join('')}

-- Add subregion relationships
INSERT INTO contractor_subregions (contractor_id, subregion_id)
SELECT '${id}', id FROM subregions WHERE slug = '${contractor.neighborhood_slug}';
`;
}
