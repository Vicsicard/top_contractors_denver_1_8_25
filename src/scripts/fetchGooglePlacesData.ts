import { Client } from "@googlemaps/google-maps-services-js";
import { createClient } from '@supabase/supabase-js';
import { PlaceDetails, PlaceResult, PlaceSearchResponse } from '@/types/database';
import * as dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env.local') });

// Initialize clients
const googleMapsClient = new Client({});
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

// Define exact search terms for each category
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

// Define exact coordinates for each subregion
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

async function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function formatPhoneNumber(phone: string | null | undefined): string | null {
  if (!phone) return null;
  return phone.replace(/\D/g, '');
}

function formatWebsite(website: string | null | undefined): string | null {
  if (!website) return null;
  return website.toLowerCase();
}

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
  contractor_name: string;
  address: string;
  phone: string | null;
  website: string | null;
  google_rating: number;
  category_id: number;
  subregion_id: number;
  slug: string;
}

async function fetchContractorsForCategory(
  categoryId: number,
  categorySlug: string,
  subregionId: number,
  subregionSlug: string,
  location: { lat: number; lng: number }
) {
  try {
    const searchTerms = categorySearchTerms[categorySlug as keyof typeof categorySearchTerms];
    const validResults = new Set();

    for (const searchTerm of searchTerms) {
      const searchResult = await searchPlaces(`${searchTerm} near ${location.lat},${location.lng}`);
      for (const place of searchResult) {
        if (!validResults.has(place.place_id)) {
          validResults.add(place.place_id);
          
          await delay(200);
          const details = await fetchPlaceDetails(place.place_id);

          if (details) {
            const contractorData: ContractorData = {
              contractor_name: details.name,
              address: details.formatted_address,
              phone: formatPhoneNumber(details.formatted_phone_number || null),
              website: formatWebsite(details.website || null),
              google_rating: details.rating,
              category_id: categoryId,
              subregion_id: subregionId,
              slug: `${details.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-${place.place_id.substring(0, 6)}`
            };

            await supabase.from('contractors').upsert(contractorData, {
              onConflict: 'slug'
            });

            console.log(`Added/Updated: ${details.name} (${categorySlug} in ${subregionSlug})`);
          }
        }
      }
    }
  } catch (error) {
    console.error(`Error processing ${categorySlug}:`, error);
  }
}

async function populateContractors() {
  try {
    const { data: categories } = await supabase
      .from('categories')
      .select('*');

    const { data: subregions } = await supabase
      .from('subregions')
      .select('*');

    if (!categories || !subregions) {
      throw new Error('Failed to fetch categories or subregions');
    }

    for (const category of categories) {
      for (const subregion of subregions) {
        const location = subregionCoordinates[subregion.slug as keyof typeof subregionCoordinates];
        if (!location) continue;

        console.log(`Processing ${category.category_name} in ${subregion.subregion_name}`);
        
        await fetchContractorsForCategory(
          category.id,
          category.slug,
          subregion.id,
          subregion.slug,
          location
        );

        await delay(1000);
      }
    }
  } catch (error) {
    console.error('Error in populateContractors:', error);
  }
}

// Run the script
populateContractors().catch(console.error);
