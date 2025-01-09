import { Client } from '@googlemaps/google-maps-services-js';
import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';
import path from 'path';

// Load environment variables from .env.local
dotenv.config({ path: path.resolve(process.cwd(), '.env.local') });

// Initialize clients
const googleMapsClient = new Client({});
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// Rest of the code converted to JavaScript...
// Define search terms and coordinates...
const categorySearchTerms = {
  'plumbers': ['plumber', 'plumbing contractor', 'plumbing service'],
  'electricians': ['electrician', 'electrical contractor', 'electrical service'],
  // ... other categories
};

const subregionCoordinates = {
  'arvada': { lat: 39.8028, lng: -105.0875 },
  'aurora': { lat: 39.7294, lng: -104.8319 },
  // ... other regions
};

// Helper functions
const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));

function formatPhoneNumber(phone) {
  if (!phone) return null;
  const cleaned = phone.replace(/\D/g, '');
  if (cleaned.length === 10) {
    return `(${cleaned.slice(0, 3)}) ${cleaned.slice(3, 6)}-${cleaned.slice(6)}`;
  }
  return phone;
}

function formatWebsite(website) {
  if (!website) return null;
  try {
    const url = new URL(website);
    return url.toString();
  } catch {
    return null;
  }
}

async function fetchPlaceDetails(placeId) {
  try {
    const response = await googleMapsClient.placeDetails({
      params: {
        place_id: placeId,
        fields: [
          'name',
          'formatted_address',
          'formatted_phone_number',
          'website',
          'rating',
          'business_status'
        ],
        key: process.env.GOOGLE_PLACES_API_KEY
      }
    });

    const details = response.data.result;
    
    if (details.business_status === 'OPERATIONAL' && 
        details.name && 
        details.formatted_address && 
        details.rating) {
      return {
        name: details.name,
        address: details.formatted_address,
        phone: formatPhoneNumber(details.formatted_phone_number),
        website: formatWebsite(details.website),
        rating: details.rating
      };
    }
    return null;
  } catch (error) {
    console.error(`Error fetching place details for ${placeId}:`, error);
    return null;
  }
}

async function fetchContractorsForCategory(
  categoryId,
  categorySlug,
  subregionId,
  subregionSlug,
  location
) {
  try {
    const searchTerms = categorySearchTerms[categorySlug];
    const validResults = new Set();

    for (const searchTerm of searchTerms) {
      const searchResult = await googleMapsClient.placesNearby({
        params: {
          location,
          radius: 5000,
          keyword: searchTerm,
          type: 'business',
          key: process.env.GOOGLE_PLACES_API_KEY
        }
      });

      for (const place of searchResult.data.results) {
        if (!validResults.has(place.place_id)) {
          validResults.add(place.place_id);
          
          await delay(200);
          const details = await fetchPlaceDetails(place.place_id);

          if (details) {
            await supabase.from('contractors').upsert({
              contractor_name: details.name,
              address: details.address,
              phone: details.phone,
              website: details.website,
              google_rating: details.rating,
              category_id: categoryId,
              subregion_id: subregionId,
              slug: `${details.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-${place.place_id.substring(0, 6)}`
            }, {
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
        const location = subregionCoordinates[subregion.slug];
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
