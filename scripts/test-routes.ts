import fetch from 'node-fetch';

// Test data from database
const testData = {
  trades: [
    { name: 'Plumbers', slug: 'plumbers' },
    { name: 'Electricians', slug: 'electricians' },
    { name: 'HVAC', slug: 'hvac' },
    { name: 'Roofers', slug: 'roofers' },
    { name: 'Painters', slug: 'painters' },
  ],
  regions: [
    { name: 'Central Denver', slug: 'central-denver' },
    { name: 'East Denver', slug: 'east-denver' },
    { name: 'Northwest Suburbs', slug: 'northwest-suburbs' },
    { name: 'Northeast Suburbs', slug: 'northeast-suburbs' },
    { name: 'Southeast Suburbs', slug: 'southeast-suburbs' },
  ],
  areas: [
    { name: 'Downtown Area', slug: 'downtown-area' },
    { name: 'Central Parks Area', slug: 'central-parks-area' },
    { name: 'Central Shopping Area', slug: 'central-shopping-area' },
  ],
};

// Test cases with various input formats
const urlTestCases = [
  // Test exact database slugs
  ...testData.trades.flatMap(trade => 
    testData.regions.flatMap(region => 
      testData.areas.map(area => ({
        trade: trade.slug,
        region: region.slug,
        area: area.slug,
        description: `Database slugs: ${trade.slug}/${region.slug}/${area.slug}`
      }))
    )
  ),
  
  // Test with spaces instead of hyphens
  ...testData.trades.flatMap(trade => 
    testData.regions.flatMap(region => 
      testData.areas.map(area => ({
        trade: trade.name.toLowerCase(),
        region: region.name.toLowerCase(),
        area: area.name.toLowerCase(),
        description: `Lowercase with spaces: ${trade.name.toLowerCase()}/${region.name.toLowerCase()}/${area.name.toLowerCase()}`
      }))
    )
  ),
  
  // Test with original capitalization
  ...testData.trades.flatMap(trade => 
    testData.regions.flatMap(region => 
      testData.areas.map(area => ({
        trade: trade.name,
        region: region.name,
        area: area.name,
        description: `Original capitalization: ${trade.name}/${region.name}/${area.name}`
      }))
    )
  ),
  
  // Test without area suffix
  ...testData.trades.flatMap(trade => 
    testData.regions.flatMap(region => 
      testData.areas.map(area => ({
        trade: trade.slug,
        region: region.slug,
        area: area.slug.replace('-area', ''),
        description: `Without area suffix: ${trade.slug}/${region.slug}/${area.slug.replace('-area', '')}`
      }))
    )
  ),
];

async function testUrl(baseUrl: string, testCase: typeof urlTestCases[0]) {
  const url = `${baseUrl}/api/locations/${encodeURIComponent(testCase.trade)}/${encodeURIComponent(testCase.region)}/${encodeURIComponent(testCase.area)}`;
  
  try {
    const response = await fetch(url);
    const text = await response.text();
    
    if (response.ok) {
      try {
        const data = JSON.parse(text);
        if (data && data.contractors && data.contractors.length > 0) {
          console.log(`[OK] ${testCase.description}`);
          console.log(`URL: ${url}`);
          console.log(`Found ${data.contractors.length} contractors\n`);
          return true;
        } else {
          console.log(`[WARN] ${testCase.description}`);
          console.log(`URL: ${url}`);
          console.log('No contractors found in response\n');
          return false;
        }
      } catch (e) {
        console.log(`[WARN] ${testCase.description}`);
        console.log(`URL: ${url}`);
        console.log('Invalid JSON response\n');
        return false;
      }
    } else {
      console.log(`[FAIL] ${testCase.description}`);
      console.log(`URL: ${url}`);
      console.log(`Status: ${response.status} ${response.statusText}`);
      console.log(`Response: ${text}\n`);
      return false;
    }
  } catch (error) {
    console.log(`[ERROR] ${testCase.description}`);
    console.log(`URL: ${url}`);
    console.log(`Error: ${error}\n`);
    return false;
  }
}

async function runTests() {
  console.log('Starting URL tests...\n');
  
  const BASE_URL = 'http://localhost:3000';
  let successCount = 0;
  let failCount = 0;
  
  for (const testCase of urlTestCases) {
    const success = await testUrl(BASE_URL, testCase);
    if (success) {
      successCount++;
    } else {
      failCount++;
    }
  }
  
  console.log('\nTest Summary:');
  console.log(`Total Tests: ${urlTestCases.length}`);
  console.log(`Passed: ${successCount}`);
  console.log(`Failed: ${failCount}`);
  
  if (failCount > 0) {
    process.exit(1);
  }
}

// Start the tests
runTests().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});
