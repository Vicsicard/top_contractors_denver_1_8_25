import { config } from 'dotenv';
import * as path from 'path';

// Load environment variables from .env.local
config({ path: path.resolve(process.cwd(), '.env.local') });

// Validate environment variables
const requiredEnvVars = [
  'NEXT_PUBLIC_SUPABASE_URL',
  'SUPABASE_SERVICE_ROLE_KEY',
  'GOOGLE_PLACES_API_KEY'
];

for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Missing required environment variable: ${envVar}`);
  }
}

console.log('Environment variables loaded successfully');
console.log('Google Places API Key:', process.env.GOOGLE_PLACES_API_KEY?.substring(0, 10) + '...');
console.log('Supabase URL:', process.env.NEXT_PUBLIC_SUPABASE_URL);

import { searchPlaces, getPlaceDetails, transformToContractorData, delay } from '../lib/google-places';
import { createClient } from '@supabase/supabase-js';
import slugify from 'slugify';

// Initialize Supabase client with service role key
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  }
);

const TRADES = [
  { name: 'Plumbers', slug: 'plumbers', searchTerm: 'plumber' },
  { name: 'Electricians', slug: 'electricians', searchTerm: 'electrician' },
  { name: 'HVAC Contractors', slug: 'hvac-contractors', searchTerm: 'hvac contractor' },
  { name: 'Carpenters', slug: 'carpenters', searchTerm: 'carpenter' },
  { name: 'Painters', slug: 'painters', searchTerm: 'painting contractor' },
  { name: 'Roofers', slug: 'roofers', searchTerm: 'roofing contractor' },
  { name: 'Landscapers', slug: 'landscapers', searchTerm: 'landscaping contractor' },
  { name: 'General Contractors', slug: 'general-contractors', searchTerm: 'general contractor' },
  { name: 'Bathroom Remodelers', slug: 'bathroom-remodelers', searchTerm: 'bathroom remodeling contractor' },
  { name: 'Kitchen Remodelers', slug: 'kitchen-remodelers', searchTerm: 'kitchen remodeling contractor' },
  { name: 'Flooring Contractors', slug: 'flooring-contractors', searchTerm: 'flooring contractor' },
  { name: 'Drywall Contractors', slug: 'drywall-contractors', searchTerm: 'drywall contractor' },
  { name: 'Concrete Contractors', slug: 'concrete-contractors', searchTerm: 'concrete contractor' },
  { name: 'Fence Contractors', slug: 'fence-contractors', searchTerm: 'fence contractor' },
  { name: 'Window Contractors', slug: 'window-contractors', searchTerm: 'window contractor' },
  { name: 'Door Contractors', slug: 'door-contractors', searchTerm: 'door contractor' }
];

const SUBREGIONS = [
  { name: 'Central Denver', slug: 'central-denver', searchArea: 'Central Denver, CO' },
  { name: 'North Denver', slug: 'north-denver', searchArea: 'North Denver, CO' },
  { name: 'South Denver', slug: 'south-denver', searchArea: 'South Denver, CO' },
  { name: 'East Denver', slug: 'east-denver', searchArea: 'East Denver, CO' },
  { name: 'West Denver', slug: 'west-denver', searchArea: 'West Denver, CO' },
  { name: 'Northwest Denver', slug: 'northwest-denver', searchArea: 'Northwest Denver, CO' },
  { name: 'Northeast Denver', slug: 'northeast-denver', searchArea: 'Northeast Denver, CO' },
  { name: 'Southwest Denver', slug: 'southwest-denver', searchArea: 'Southwest Denver, CO' },
  { name: 'Southeast Denver', slug: 'southeast-denver', searchArea: 'Southeast Denver, CO' },
  { name: 'Downtown Denver', slug: 'downtown-denver', searchArea: 'Downtown Denver, CO' },
  { name: 'Cherry Creek', slug: 'cherry-creek', searchArea: 'Cherry Creek, Denver, CO' },
  { name: 'Capitol Hill', slug: 'capitol-hill', searchArea: 'Capitol Hill, Denver, CO' },
  { name: 'Five Points', slug: 'five-points', searchArea: 'Five Points, Denver, CO' },
  { name: 'Park Hill', slug: 'park-hill', searchArea: 'Park Hill, Denver, CO' },
  { name: 'Washington Park', slug: 'washington-park', searchArea: 'Washington Park, Denver, CO' }
];

async function ensureCategoriesExist() {
  for (const trade of TRADES) {
    const { error } = await supabase
      .from('categories')
      .upsert({
        category_name: trade.name,
        slug: trade.slug
      }, {
        onConflict: 'slug'
      });

    if (error) {
      console.error(`Error creating category ${trade.name}:`, error);
    }
  }
}

async function ensureSubregionsExist() {
  for (const subregion of SUBREGIONS) {
    const { error } = await supabase
      .from('subregions')
      .upsert({
        subregion_name: subregion.name,
        slug: subregion.slug
      }, {
        onConflict: 'slug'
      });

    if (error) {
      console.error(`Error creating subregion ${subregion.name}:`, error);
    }
  }
}

async function getCategoryId(slug: string) {
  const { data, error } = await supabase
    .from('categories')
    .select('id')
    .eq('slug', slug)
    .single();

  if (error) throw error;
  return data.id;
}

async function getSubregionId(slug: string) {
  const { data, error } = await supabase
    .from('subregions')
    .select('id')
    .eq('slug', slug)
    .single();

  if (error) throw error;
  return data.id;
}

async function populateContractors() {
  try {
    // First ensure all categories and subregions exist
    console.log('Ensuring categories exist...');
    await ensureCategoriesExist();
    console.log('Ensuring subregions exist...');
    await ensureSubregionsExist();

    for (const trade of TRADES) {
      console.log(`Processing ${trade.name}...`);
      const categoryId = await getCategoryId(trade.slug);
      
      for (const subregion of SUBREGIONS) {
        console.log(`  Searching in ${subregion.name}...`);
        const subregionId = await getSubregionId(subregion.slug);
        
        // Search for contractors
        const searchResults = await searchPlaces({
          query: `${trade.searchTerm}`,
          location: subregion.searchArea,
          radius: 5000 // 5km radius
        });

        // Get top 10 results
        const topResults = searchResults.slice(0, 10);
        
        for (const result of topResults) {
          try {
            // Get detailed information
            if (!result.place_id) {
              console.error('No place_id found for result:', result);
              return null;
            }
            const details = await getPlaceDetails(result.place_id);
            const contractorData = transformToContractorData(details);

            // Create slug from contractor name
            const slug = slugify(contractorData.name, {
              lower: true,
              strict: true
            });

            // Save to database
            const { error } = await supabase
              .from('contractors')
              .upsert({
                category_id: categoryId,
                subregion_id: subregionId,
                contractor_name: contractorData.name,
                address: contractorData.address,
                phone: contractorData.phone || '(000) 000-0000', // Default if missing
                website: contractorData.website,
                reviews_avg: contractorData.rating || 0,
                reviews_count: contractorData.reviews_count || 0,
                slug: `${slug}-${subregion.slug}`, // Make slug unique per subregion
                updated_at: new Date().toISOString()
              }, {
                onConflict: 'slug'
              });

            if (error) {
              console.error('Error saving contractor:', error);
            } else {
              console.log(`    Saved: ${contractorData.name} in ${subregion.name}`);
            }

            // Rate limiting delay
            await delay(200);
          } catch (error) {
            console.error(`Error processing contractor ${result.place_id}:`, error);
            continue;
          }
        }
      }
    }
    console.log('Population complete!');
  } catch (error) {
    console.error('Fatal error during population:', error);
  }
}

// Run the population script
populateContractors();
