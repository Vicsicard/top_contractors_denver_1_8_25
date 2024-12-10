import { getPlacesData } from './placesApi.js';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables from .env.local
dotenv.config({ path: join(__dirname, '../../.env.local') });

async function testPlacesCache() {
  try {
    console.log('Starting Places API cache test...');

    // Test environment variables
    if (!process.env.MONGODB_URI) {
      throw new Error('MONGODB_URI is not defined');
    }
    if (!process.env.NEXT_GOOGLE_PLACES_API_KEY) {
      throw new Error('NEXT_GOOGLE_PLACES_API_KEY is not defined');
    }

    const searchOptions = {
      keyword: 'plumbers',
      location: 'Denver',
    };

    console.log('\nFirst call - should fetch from Google Places API:');
    console.time('First call');
    const firstCall = await getPlacesData(searchOptions);
    console.timeEnd('First call');
    console.log(`Found ${firstCall.results?.length || 0} results`);

    // Wait 2 seconds
    console.log('\nWaiting 2 seconds before second call...');
    await new Promise(resolve => setTimeout(resolve, 2000));

    console.log('\nSecond call - should fetch from cache:');
    console.time('Second call');
    const secondCall = await getPlacesData(searchOptions);
    console.timeEnd('Second call');
    console.log(`Found ${secondCall.results?.length || 0} results`);

    // Verify results match
    const firstCallIds = new Set(firstCall.results.map(r => r.place_id));
    const secondCallIds = new Set(secondCall.results.map(r => r.place_id));
    const resultsMatch = firstCallIds.size === secondCallIds.size && 
      [...firstCallIds].every(id => secondCallIds.has(id));

    console.log('\nResults comparison:');
    console.log('- First call results:', firstCallIds.size);
    console.log('- Second call results:', secondCallIds.size);
    console.log('- Results match:', resultsMatch);

    if (!resultsMatch) {
      console.warn('Warning: Results from cache do not match original results');
    }

    console.log('\nTest completed successfully!');
  } catch (error) {
    console.error('\nTest failed with error:', error);
    if (error instanceof Error) {
      console.error('Error details:', {
        message: error.message,
        stack: error.stack,
      });
    }
    process.exit(1);
  }
}

// Run the test
testPlacesCache().catch(error => {
  console.error('Unhandled error:', error);
  process.exit(1);
});
