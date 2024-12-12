import { loadLocations } from '../utils/searchData';

async function testPlacesApi(): Promise<void> {
  try {
    console.log('Testing Places API with query: "plumbers"...');
    const results = await loadLocations('plumbers');
    
    console.log('\nResults:', JSON.stringify(results, null, 2));
    console.log(`\nFound ${results.total} results`);
    
    if (results.locations.length > 0) {
      console.log('\nFirst result:', results.locations[0]);
    }
  } catch (error) {
    console.error('Test failed:', error);
  }
}

testPlacesApi();
