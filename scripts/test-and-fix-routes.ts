import fetch from 'node-fetch';
import { promises as fs } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

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
        expectedTrade: trade.slug,
        expectedRegion: region.slug,
        expectedArea: area.slug,
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
        expectedTrade: trade.slug,
        expectedRegion: region.slug,
        expectedArea: area.slug,
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
        expectedTrade: trade.slug,
        expectedRegion: region.slug,
        expectedArea: area.slug,
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
        expectedTrade: trade.slug,
        expectedRegion: region.slug,
        expectedArea: area.slug,
        description: `Without area suffix: ${trade.slug}/${region.slug}/${area.slug.replace('-area', '')}`
      }))
    )
  ),
];

async function readFile(filePath: string): Promise<string> {
  return await fs.readFile(filePath, 'utf-8');
}

async function writeFile(filePath: string, content: string): Promise<void> {
  await fs.writeFile(filePath, content, 'utf-8');
}

async function fixSlugFunctions(errors: Array<{ actual: string, expected: string }>) {
  const pagePath = join(dirname(__dirname), 'src/app/[trade]/[region]/[area]/page.tsx');
  const routePath = join(dirname(__dirname), 'src/app/api/locations/[trade]/[region]/[area]/route.ts');
  
  const pageContent = await readFile(pagePath);
  const routeContent = await readFile(routePath);
  
  let updatedPageContent = pageContent;
  let updatedRouteContent = routeContent;
  
  // Fix trade slug function
  const tradeErrors = errors.filter(e => e.actual.split('/')[0] !== e.expected.split('/')[0]);
  if (tradeErrors.length > 0) {
    console.log('\nFixing trade slug function...');
    const newTradeFunction = `function createTradeSlug(trade: string): string {
  const slug = createSlug(trade);
  
  // Handle countable trades (need pluralization)
  const countableTrades = ['plumber', 'electrician', 'roofer', 'painter'];
  if (countableTrades.includes(slug)) {
    return \`\${slug}s\`;
  }
  
  // Handle special cases (no pluralization)
  const specialTrades = ['hvac'];
  if (specialTrades.includes(slug)) {
    return slug;
  }
  
  return slug;
}`;
    
    updatedPageContent = updatedPageContent.replace(/function createTradeSlug[\s\S]*?}/, newTradeFunction);
    updatedRouteContent = updatedRouteContent.replace(/function createTradeSlug[\s\S]*?}/, newTradeFunction);
  }
  
  // Fix region slug function
  const regionErrors = errors.filter(e => e.actual.split('/')[1] !== e.expected.split('/')[1]);
  if (regionErrors.length > 0) {
    console.log('\nFixing region slug function...');
    const newRegionFunction = `function createRegionSlug(region: string): string {
  // All regions follow the same pattern: lowercase with hyphens
  return createSlug(region);
}`;
    
    updatedPageContent = updatedPageContent.replace(/function createRegionSlug[\s\S]*?}/, newRegionFunction);
    updatedRouteContent = updatedRouteContent.replace(/function createRegionSlug[\s\S]*?}/, newRegionFunction);
  }
  
  // Fix area slug function
  const areaErrors = errors.filter(e => e.actual.split('/')[2] !== e.expected.split('/')[2]);
  if (areaErrors.length > 0) {
    console.log('\nFixing area slug function...');
    const newAreaFunction = `function createAreaSlug(area: string): string {
  const slug = createSlug(area);
  
  // All areas end with -area
  return \`\${slug}-area\`;
}`;
    
    updatedPageContent = updatedPageContent.replace(/function createAreaSlug[\s\S]*?}/, newAreaFunction);
    updatedRouteContent = updatedRouteContent.replace(/function createAreaSlug[\s\S]*?}/, newAreaFunction);
  }
  
  if (updatedPageContent !== pageContent) {
    await writeFile(pagePath, updatedPageContent);
    console.log('Updated page.tsx');
  }
  
  if (updatedRouteContent !== routeContent) {
    await writeFile(routePath, updatedRouteContent);
    console.log('Updated route.ts');
  }
}

async function testUrl(baseUrl: string, testCase: typeof urlTestCases[0]) {
  const url = `${baseUrl}/${encodeURIComponent(testCase.trade)}/${encodeURIComponent(testCase.region)}/${encodeURIComponent(testCase.area)}`;
  const expected = `${baseUrl}/${testCase.expectedTrade}/${testCase.expectedRegion}/${testCase.expectedArea}`;
  
  try {
    const response = await fetch(url);
    const text = await response.text();
    
    if (url === expected && response.ok && !text.includes('Error Loading Location Data')) {
      console.log(`[OK] ${testCase.description}`);
      console.log(`URL: ${url}\n`);
      return { success: true };
    } else {
      console.log(`[FAIL] ${testCase.description}`);
      console.log(`URL: ${url}`);
      console.log(`Expected: ${expected}`);
      if (response.ok && text.includes('Error Loading Location Data')) {
        console.log('Page shows error message\n');
      } else {
        console.log(`Status: ${response.status} ${response.statusText}\n`);
      }
      return {
        success: false,
        error: {
          actual: url.replace(baseUrl + '/', ''),
          expected: expected.replace(baseUrl + '/', '')
        }
      };
    }
  } catch (err) {
    console.log(`[ERROR] ${testCase.description}`);
    console.log(`URL: ${url}`);
    console.log(`Error: ${err instanceof Error ? err.message : 'Unknown error'}\n`);
    return { 
      success: false,
      error: {
        actual: url.replace(baseUrl + '/', ''),
        expected: expected.replace(baseUrl + '/', '')
      }
    };
  }
}

async function runTests() {
  const baseUrl = 'http://localhost:3000';
  console.log('\nStarting URL route tests...\n');
  
  let passed = 0;
  let failed = 0;
  const errors: Array<{ actual: string, expected: string }> = [];
  
  for (const testCase of urlTestCases) {
    const result = await testUrl(baseUrl, testCase);
    if (result.success) {
      passed++;
    } else {
      failed++;
      if (result.error) {
        errors.push(result.error);
      }
    }
  }
  
  console.log('\nTest Summary:');
  console.log(`Total Tests: ${urlTestCases.length}`);
  console.log(`Passed: ${passed}`);
  console.log(`Failed: ${failed}`);
  
  if (failed > 0) {
    console.log('\nAttempting to fix errors...');
    await fixSlugFunctions(errors);
    console.log('\nPlease restart the dev server and run the tests again to verify fixes.');
  }
  
  console.log('\nDone!\n');
}

// Start the tests
runTests().catch(console.error);
