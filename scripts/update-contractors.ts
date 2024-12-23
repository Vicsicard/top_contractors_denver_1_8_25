import fs from 'fs/promises';
import path from 'path';
import dotenv from 'dotenv';

// Load environment variables from .env.local
dotenv.config({ path: '.env.local' });

// List of all trades we want to fetch data for
const TRADES = [
  'plumbers',
  'electricians',
  'hvac',
  'roofers',
  'painters',
  'carpenters',
  'landscapers',
  'bathroom-remodeling',
  'kitchen-remodeling',
  'home-remodeling',
  'windows',
  'flooring',
  'decks',
  'fencing',
  'masonry',
  'siding-and-gutters',
];

// Maximum number of contractors per category
const MAX_CONTRACTORS = 20;

interface PlaceLocation {
  lat: number;
  lng: number;
}

interface PlaceGeometry {
  location: PlaceLocation;
}

interface PlaceResult {
  place_id: string;
  name: string;
  formatted_address: string;
  geometry: PlaceGeometry;
  rating?: number;
  user_ratings_total?: number;
  types?: string[];
}

interface ContractorData {
  trade: string;
  lastUpdated: string;
  results: PlaceResult[];
}

async function fetchTradeData(trade: string): Promise<ContractorData> {
  console.log(`Fetching data for ${trade}...`);
  try {
    const apiKey = process.env.GOOGLE_PLACES_API_KEY;
    if (!apiKey) {
      throw new Error('GOOGLE_PLACES_API_KEY is not set');
    }

    const query = encodeURIComponent(`${trade} in Denver, CO`);
    const url = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${query}&key=${apiKey}`;
    
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    
    // Limit results to MAX_CONTRACTORS
    const limitedResults = data.results.slice(0, MAX_CONTRACTORS);
    
    // Sort results by rating (highest first) and then by review count
    const sortedResults = limitedResults.sort((a, b) => {
      if (b.rating !== a.rating) {
        return b.rating - a.rating;
      }
      return (b.user_ratings_total || 0) - (a.user_ratings_total || 0);
    });

    return {
      trade,
      lastUpdated: new Date().toISOString(),
      results: sortedResults
    };
  } catch (error) {
    console.error(`Error fetching data for ${trade}:`, error);
    throw error;
  }
}

async function saveDataToFile(data: ContractorData) {
  const dataDir = path.join(process.cwd(), 'src/data/contractors');
  const filePath = path.join(dataDir, `${data.trade}.json`);

  try {
    // Ensure the directory exists
    await fs.mkdir(dataDir, { recursive: true });

    // Save the data
    await fs.writeFile(
      filePath,
      JSON.stringify(data, null, 2),
      'utf-8'
    );
    console.log(`Data saved for ${data.trade} (${data.results.length} contractors)`);
  } catch (error) {
    console.error(`Error saving data for ${data.trade}:`, error);
    throw error;
  }
}

async function updateContractorData() {
  console.log('Starting contractor data update...');
  console.log(`Will fetch up to ${MAX_CONTRACTORS} contractors per category`);
  
  for (const trade of TRADES) {
    try {
      const data = await fetchTradeData(trade);
      await saveDataToFile(data);
      // Add a delay between requests to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 2000));
    } catch (error) {
      console.error(`Failed to update data for ${trade}:`, error);
      // Continue with next trade even if one fails
      continue;
    }
  }

  console.log('Contractor data update completed!');
}

// Only run if called directly (not imported)
if (require.main === module) {
  updateContractorData()
    .then(() => {
      console.log('Update completed successfully!');
      process.exit(0);
    })
    .catch((error) => {
      console.error('Update failed:', error);
      process.exit(1);
    });
}

export { updateContractorData };
