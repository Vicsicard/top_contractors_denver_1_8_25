import { waitForToken } from './rateLimiter';
import { PlacesApiResponse, PlaceResult } from '@/types/places';

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

interface PlacesApiResponse {
  results: PlaceResult[];
  status: string;
  next_page_token?: string;
}

const locationMap: Record<string, string> = {
  'denver': 'Denver, Colorado',
  'denver, co': 'Denver, Colorado',
  'denver colorado': 'Denver, Colorado',
  'denver, colorado': 'Denver, Colorado',
  'downtown denver': 'Downtown Denver, Colorado',
  'aurora': 'Aurora, Colorado',
  'lakewood': 'Lakewood, Colorado',
  'littleton': 'Littleton, Colorado',
  'arvada': 'Arvada, Colorado',
  'westminster': 'Westminster, Colorado',
  'centennial': 'Centennial, Colorado',
  'thornton': 'Thornton, Colorado'
};

// Popular trades search terms mapping
const tradeSearchTerms: Record<string, string> = {
  // Licensed trades (require certification)
  'plumber': 'plumbing contractor plumber',
  'electrician': 'electrical contractor electrician',
  'hvac': 'hvac contractor heating cooling',
  'roofer': 'roofing contractor roofer',
  
  // Professional trades
  'carpenter': 'carpentry contractor carpenter',
  'painter': 'painting contractor painter',
  'landscaper': 'landscaping contractor landscaper',
  'home remodeler': 'home remodeling contractor',
  'bathroom remodeler': 'bathroom remodeling contractor',
  'kitchen remodeler': 'kitchen remodeling contractor',
  'siding installer': 'siding contractor installer',
  'mason': 'masonry contractor mason',
  'deck builder': 'deck building contractor',
  'flooring installer': 'flooring contractor installer',
  'window installer': 'window installation contractor',
  'fence installer': 'fence installation contractor',
  'epoxy garage coater': 'epoxy garage floor contractor'
};

async function makeRequest(url: string, options: RequestInit = {}): Promise<Response> {
  await waitForToken();
  const response = await fetch(url, options);
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  return response;
}

export async function searchPlaces(keyword: string, location: string): Promise<PlacesApiResponse> {
  const apiKey = process.env.GOOGLE_PLACES_API_KEY;
  if (!apiKey) {
    throw new Error('Google Places API key not found');
  }

  console.log('Searching places with:', { keyword, location });

  // Clean and normalize the location
  const cleanLocation = location.toLowerCase().trim();
  const normalizedLocation = locationMap[cleanLocation] || `${location}, Colorado`;
  
  // Normalize the keyword and get appropriate search terms
  const keywordLower = keyword.toLowerCase().trim();
  
  // First try exact match
  let searchTerms = tradeSearchTerms[keywordLower];
  
  if (!searchTerms) {
    // Try singular/plural variations
    const singularForm = keywordLower.replace(/s$/, '');
    const pluralForm = keywordLower.endsWith('s') ? keywordLower : `${keywordLower}s`;
    searchTerms = tradeSearchTerms[singularForm] || tradeSearchTerms[pluralForm];
  }
  
  if (!searchTerms) {
    // Try partial matches
    const matchingTerm = Object.entries(tradeSearchTerms).find(
      ([key]) => keywordLower.includes(key) || key.includes(keywordLower)
    );
    if (matchingTerm) {
      searchTerms = matchingTerm[1];
    }
  }

  // If no specific trade term found, use generic contractor format
  if (!searchTerms) {
    searchTerms = keywordLower.includes('contractor') ? 
      keyword : 
      `professional ${keyword} contractor`;
  }

  // Build the final search query
  const finalQuery = `${searchTerms} in ${normalizedLocation}`;
  console.log('Using search query:', finalQuery);
  
  const url = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${encodeURIComponent(finalQuery)}&key=${apiKey}`;

  try {
    console.log('Making request to:', url.replace(apiKey, 'REDACTED'));
    const response = await makeRequest(url);
    const data = await response.json();
    
    console.log('Places API response:', {
      status: data.status,
      resultsCount: data.results?.length,
      nextPageToken: !!data.next_page_token
    });

    // Filter results to ensure they are relevant contractors
    if (data.results && Array.isArray(data.results)) {
      data.results = data.results.filter(result => {
        const name = result.name.toLowerCase();
        const types = result.types?.map(t => t.toLowerCase()) || [];
        
        // Check if it's a relevant contractor based on the trade
        const isContractor = 
          name.includes('contractor') ||
          name.includes('construction') ||
          name.includes('service') ||
          name.includes('repair') ||
          types.some(t => 
            t.includes('contractor') || 
            t.includes('service') || 
            t.includes('repair') ||
            t.includes('construction')
          );

        // Check for trade-specific keywords
        const isRelevantTrade = 
          // Licensed trades
          (keywordLower.includes('plumb') && (
            name.includes('plumb') || 
            types.includes('plumber') || 
            types.includes('plumbing_contractor') ||
            name.includes('rooter')
          )) ||
          (keywordLower.includes('electric') && (name.includes('electric') || types.includes('electrician'))) ||
          (keywordLower.includes('hvac') && (name.includes('hvac') || name.includes('heat') || name.includes('air'))) ||
          (keywordLower.includes('roof') && (name.includes('roof') || types.includes('roofing'))) ||
          // Professional trades
          (keywordLower.includes('carpent') && name.includes('carpent')) ||
          (keywordLower.includes('paint') && name.includes('paint')) ||
          (keywordLower.includes('landscap') && name.includes('landscap')) ||
          (keywordLower.includes('remodel') && name.includes('remodel')) ||
          (keywordLower.includes('siding') && (name.includes('siding') || name.includes('gutter'))) ||
          (keywordLower.includes('mason') && name.includes('mason')) ||
          (keywordLower.includes('deck') && name.includes('deck')) ||
          (keywordLower.includes('floor') && name.includes('floor')) ||
          (keywordLower.includes('window') && name.includes('window')) ||
          (keywordLower.includes('fenc') && name.includes('fenc')) ||
          (keywordLower.includes('epoxy') && (name.includes('epoxy') || name.includes('garage')));

        return isContractor && isRelevantTrade;
      });

      console.log('Filtered results:', {
        original: data.results.length,
        filtered: data.results.length,
        trade: keyword
      });
    }

    return data as PlacesApiResponse;
  } catch (error) {
    console.error('Error searching places:', error);
    throw error;
  }
}