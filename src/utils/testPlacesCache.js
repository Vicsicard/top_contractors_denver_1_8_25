import { getPlacesData } from './placesApi.js';

async function testPlacesCache(): Promise<void> {
  try {
    console.log('First call - should fetch from Google Places API:');
    console.time('First call');
    const firstCall = await getPlacesData({
      keyword: 'plumbers',
      location: 'Denver',
    });
    console.timeEnd('First call');
    console.log(`Found ${firstCall.results?.length || 0} results`);

    // Wait 2 seconds
    await new Promise(resolve => setTimeout(resolve, 2000));

    console.log('\nSecond call - should fetch from cache:');
    console.time('Second call');
    const secondCall = await getPlacesData({
      keyword: 'plumbers',
      location: 'Denver',
    });
    console.timeEnd('Second call');
    console.log(`Found ${secondCall.results?.length || 0} results`);
  } catch (error) {
    console.error('Error:', error);
  }
}

// Run the test
testPlacesCache().catch(console.error);
