import { getPlaceDetails, transformToContractorData, delay } from '../lib/google-places';
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

const UPDATE_INTERVAL = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

async function updateContractors() {
  try {
    // Get all contractors from database
    const { data: contractors, error } = await supabase
      .from('contractors')
      .select('place_id, last_updated')
      .order('last_updated', { ascending: true });

    if (error) {
      throw error;
    }

    console.log(`Found ${contractors.length} contractors to update`);

    for (const contractor of contractors) {
      try {
        // Get updated details from Google Places
        const details = await getPlaceDetails(contractor.place_id);
        const updatedData = transformToContractorData(details);

        // Update in database
        const { error: updateError } = await supabase
          .from('contractors')
          .update({
            name: updatedData.name,
            address: updatedData.address,
            phone: updatedData.phone,
            website: updatedData.website,
            rating: updatedData.rating,
            reviews_count: updatedData.reviews_count,
            latitude: updatedData.latitude,
            longitude: updatedData.longitude,
            last_updated: new Date().toISOString()
          })
          .eq('place_id', contractor.place_id);

        if (updateError) {
          console.error(`Error updating contractor ${contractor.place_id}:`, updateError);
        } else {
          console.log(`Updated: ${updatedData.name}`);
        }

        // Rate limiting delay
        await delay(200);
      } catch (error) {
        console.error(`Error processing contractor ${contractor.place_id}:`, error);
        continue;
      }
    }

    console.log('Update complete!');
  } catch (error) {
    console.error('Fatal error during update:', error);
  }
}

// Run updates periodically
async function startUpdateCycle() {
  while (true) {
    await updateContractors();
    console.log(`Waiting ${UPDATE_INTERVAL/1000/60/60} hours until next update...`);
    await delay(UPDATE_INTERVAL);
  }
}

// Start the update cycle
startUpdateCycle();
