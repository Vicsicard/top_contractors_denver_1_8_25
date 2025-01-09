require('dotenv').config({ path: '.env.local' });
const { Client } = require('@googlemaps/google-maps-services-js');
const { createClient } = require('@supabase/supabase-js');

// Initialize clients
const googleMapsClient = new Client({});
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
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
      console.log(`Searching for ${searchTerm} in ${subregionSlug}...`);
      
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
            const contractor = {
              contractor_name: details.name,
              address: details.address,
              phone: details.phone,
              website: details.website,
              google_rating: details.rating,
              category_id: categoryId,
              subregion_id: subregionId,
              slug: `${details.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-${place.place_id.substring(0, 6)}`
            };

            const { error } = await supabase
              .from('contractors')
              .upsert(contractor, { onConflict: 'slug' });

            if (error) {
              console.error('Error inserting contractor:', error);
            } else {
              console.log(`Added/Updated: ${details.name}`);
            }
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
    console.log('Fetching categories and subregions...');
    
    const { data: categories } = await supabase
      .from('categories')
      .select('*');

    const { data: subregions } = await supabase
      .from('subregions')
      .select('*');

    if (!categories || !subregions) {
      throw new Error('Failed to fetch categories or subregions');
    }

    console.log(`Found ${categories.length} categories and ${subregions.length} subregions`);

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

    console.log('Finished populating contractors!');
  } catch (error) {
    console.error('Error in populateContractors:', error);
  }
}

// Run the script
console.log('Starting contractor population script...');
populateContractors().catch(console.error);
