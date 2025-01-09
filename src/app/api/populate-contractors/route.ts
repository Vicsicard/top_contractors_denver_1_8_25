import { Client } from "@googlemaps/google-maps-services-js";
import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';
import { PlaceDetails, PlaceResult, PlaceSearchResponse, Contractor } from '@/types/database';

// Initialize clients
const googleMapsClient = new Client({});
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

// Define search terms for each category
const categorySearchTerms = {
  'plumbers': ['plumber', 'plumbing contractor', 'plumbing service'],
  'electricians': ['electrician', 'electrical contractor', 'electrical service'],
  'hvac': ['hvac contractor', 'air conditioning contractor', 'heating contractor'],
  'roofers': ['roofing contractor', 'roof repair', 'roofer'],
  'painters': ['painting contractor', 'house painter', 'commercial painter'],
  'landscapers': ['landscaping contractor', 'landscape service', 'landscaper'],
  'home-remodelers': ['home remodeling contractor', 'renovation contractor'],
  'bathroom-remodelers': ['bathroom remodeling', 'bathroom renovation contractor'],
  'kitchen-remodelers': ['kitchen remodeling', 'kitchen renovation contractor'],
  'siding-gutters': ['siding contractor', 'gutter installation', 'gutter service'],
  'masonry': ['masonry contractor', 'brick contractor', 'stone mason'],
  'decks': ['deck builder', 'deck contractor', 'deck installation'],
  'flooring': ['flooring contractor', 'floor installation', 'hardwood flooring'],
  'windows': ['window contractor', 'window installation', 'window replacement'],
  'fencing': ['fence contractor', 'fence installation', 'fencing company'],
  'epoxy-garage': ['epoxy flooring contractor', 'garage floor coating']
};

// Define coordinates for each subregion
const subregionCoordinates = {
  'arvada': { lat: 39.8028, lng: -105.0875 },
  'aurora': { lat: 39.7294, lng: -104.8319 },
  'broomfield': { lat: 39.9205, lng: -105.0867 },
  'central-parks-area': { lat: 39.7557, lng: -104.8897 },
  'central-shopping-area': { lat: 39.7439, lng: -104.9883 },
  'denver-tech-center': { lat: 39.6478, lng: -104.8936 },
  'downtown-denver': { lat: 39.7392, lng: -104.9903 },
  'east-colfax-area': { lat: 39.7400, lng: -104.9030 },
  'lakewood': { lat: 39.7047, lng: -105.0814 },
  'littleton': { lat: 39.6133, lng: -105.0166 },
  'northeast-area': { lat: 39.7631, lng: -104.9703 },
  'northglenn': { lat: 39.8850, lng: -104.9811 },
  'park-hill-area': { lat: 39.7496, lng: -104.9225 },
  'thornton': { lat: 39.8680, lng: -104.9719 },
  'westminster': { lat: 39.8367, lng: -105.0372 }
};

// Helper functions
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

const formatPhoneNumber = (phone: string | null | undefined): string | null => {
  if (!phone) return null;
  // Remove all non-numeric characters
  const cleaned = phone.replace(/\D/g, '');
  // Format as (XXX) XXX-XXXX
  const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
  if (match) {
    return `(${match[1]}) ${match[2]}-${match[3]}`;
  }
  return null;
};

const formatWebsite = (website: string | null | undefined): string | null => {
  if (!website) return null;
  try {
    const url = new URL(website);
    return url.toString();
  } catch {
    return null;
  }
};

async function searchPlaces(query: string): Promise<PlaceResult[]> {
  try {
    const response = await googleMapsClient.textSearch({
      params: {
        query: query,
        key: process.env.GOOGLE_PLACES_API_KEY || '',
      },
    }) as PlaceSearchResponse;

    return response.data.results.filter((result): result is PlaceResult => 
      typeof result.place_id === 'string' && 
      typeof result.name === 'string'
    );
  } catch (error) {
    console.error('Error searching places:', error);
    return [];
  }
}

async function fetchPlaceDetails(placeId: string): Promise<PlaceDetails | null> {
  try {
    const response = await googleMapsClient.placeDetails({
      params: {
        place_id: placeId,
        key: process.env.GOOGLE_PLACES_API_KEY || '',
        fields: ['name', 'formatted_address', 'formatted_phone_number', 'website', 'rating']
      }
    });

    const details = response.data.result;
    if (details.name && details.formatted_address && details.rating) {
      return {
        name: details.name,
        formatted_address: details.formatted_address,
        formatted_phone_number: details.formatted_phone_number,
        website: details.website,
        rating: details.rating
      };
    }
    return null;
  } catch (error) {
    console.error('Error fetching place details:', error);
    return null;
  }
}

interface ContractorData {
  name: string;
  address: string;
  phone: string | null;
  website: string | null;
  rating: number;
  category_id: number;
  subregion_id: number;
  created_at: string;
  updated_at: string;
  slug: string;
}

async function fetchContractorsForCategory(
  categoryId: number,
  categorySlug: string,
  subregionId: number
) {
  const results: ContractorData[] = [];
  try {
    const searchQueries = categorySearchTerms[categorySlug as keyof typeof categorySearchTerms];

    for (const query of searchQueries) {
      const places = await searchPlaces(`${query} in Denver, CO`);
      
      for (const place of places) {
        await delay(200);
        const details = await fetchPlaceDetails(place.place_id);

        if (details) {
          const contractorData: ContractorData = {
            name: details.name,
            address: details.formatted_address,
            phone: formatPhoneNumber(details.formatted_phone_number || null),
            website: formatWebsite(details.website || null),
            rating: details.rating,
            category_id: categoryId,
            subregion_id: subregionId,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString(),
            slug: `${details.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-${place.place_id.substring(0, 6)}`
          };

          await supabase.from('contractors').upsert(contractorData, {
            onConflict: 'slug'
          });

          results.push(contractorData);
        }
      }
    }

    return results;
  } catch (error) {
    console.error(`Error processing ${categorySlug}:`, error);
    return [];
  }
}

export const dynamic = 'force-dynamic';

export async function GET() {
  try {
    const { data: categories, error: categoriesError } = await supabase
      .from('categories')
      .select('*');

    if (categoriesError) {
      console.error('Error fetching categories:', categoriesError);
      return NextResponse.json({ error: 'Error fetching categories' }, { status: 500 });
    }

    const results = [];
    for (const category of categories) {
      const categoryName = category.category_name;
      const categorySlug = category.slug;

      const { data: subregions, error: subregionsError } = await supabase
        .from('subregions')
        .select('*');

      if (subregionsError) {
        console.error('Error fetching subregions:', subregionsError);
        return NextResponse.json({ error: 'Error fetching subregions' }, { status: 500 });
      }

      // Process each category and subregion
      for (const subregion of subregions) {
        const location = subregionCoordinates[subregion.slug as keyof typeof subregionCoordinates];
        if (!location) continue;

        const contractors = await fetchContractorsForCategory(
          category.id,
          categorySlug,
          subregion.id
        );

        results.push({
          category: categoryName,
          subregion: subregion.subregion_name,
          contractors_added: contractors.length
        });

        await delay(1000); // Delay between regions
      }
    }

    return NextResponse.json({
      success: true,
      results
    });
  } catch (error) {
    console.error('Error:', error);
    return NextResponse.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    }, { status: 500 });
  }
}

export async function POST(
  req: Request,
  { params }: { params: { categorySlug: string } }
) {
  const results: Contractor[] = [];
  try {
    const searchQueries = categorySearchTerms[params.categorySlug as keyof typeof categorySearchTerms];

    for (const query of searchQueries) {
      const places = await searchPlaces(`${query} in Denver, CO`);
      
      for (const place of places) {
        if (!place.place_id) continue;
        
        await delay(200);
        const details = await fetchPlaceDetails(place.place_id);

        if (details) {
          const contractor: Contractor = {
            contractor_name: details.name,
            address: details.formatted_address,
            phone: formatPhoneNumber(details.formatted_phone_number || null),
            website: formatWebsite(details.website || null),
            google_rating: details.rating,
            category_id: 1, // default category id
            subregion_id: 1, // default subregion id
            slug: `${details.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-${place.place_id.substring(0, 6)}`
          };

          await supabase.from('contractors').upsert(contractor, {
            onConflict: 'slug'
          });

          results.push(contractor);
        }
      }
    }

    return NextResponse.json({
      success: true,
      results
    });
  } catch (error) {
    console.error('Error:', error);
    return NextResponse.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    }, { status: 500 });
  }
}
