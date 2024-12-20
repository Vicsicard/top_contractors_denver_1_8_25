import { PlaceCache } from '@/models/PlaceCache';
import { connectDB } from '@/utils/db';
import { rateLimiter } from './rateLimiter';

const apiKey = process.env.GOOGLE_PLACES_API_KEY;
const CACHE_DURATION_HOURS = 24;

if (!apiKey) {
  throw new Error('GOOGLE_PLACES_API_KEY is not defined in environment variables');
}

// Location mapping for better search results
const locationMap: { [key: string]: string } = {
  'denver': 'Denver, Colorado',
  'denver, co': 'Denver, Colorado',
  'denver colorado': 'Denver, Colorado'
};

// Search term mapping for better results
const searchTermMap: { [key: string]: string } = {
  'roofer': 'roofing contractor',
  'plumber': 'plumbing contractor',
  'electrician': 'electrical contractor',
  'hvac': 'HVAC contractor',
  'handyman': 'handyman services',
  'painter': 'painting contractor',
  'carpenter': 'carpentry contractor',
  'landscaper': 'landscaping contractor',
  'mason': 'masonry contractor',
  'siding': 'siding contractor',
  'gutter': 'gutter contractor',
  'window': 'window installation contractor',
  'deck': 'deck building contractor',
  'fence': 'fencing contractor',
  'flooring': 'flooring contractor',
  'bathroom remodeling': 'bathroom remodeling contractor',
  'kitchen remodeling': 'kitchen remodeling contractor',
  'home remodeling': 'home remodeling contractor',
  'epoxy garage': 'epoxy flooring contractor'
};

async function makeRequest(url: string, options = {}) {
  const response = await fetch(url, {
    ...options,
    next: { revalidate: CACHE_DURATION_HOURS * 3600 }
  });
  
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  
  return response;
}

export async function searchPlaces(keyword: string, location: string) {
  try {
    // Ensure DB connection
    await connectDB();

    // Check cache first
    const cacheKey = `${keyword.toLowerCase()}_${location.toLowerCase()}`;
    const cachedResult = await PlaceCache.findByQuery(cacheKey);
    
    if (cachedResult) {
      console.log('Cache hit for:', cacheKey);
      return { results: cachedResult.results };
    }

    console.log('Cache miss for:', cacheKey);

    // Apply rate limiting
    await rateLimiter.waitForToken();

    const enhancedKeyword = searchTermMap[keyword.toLowerCase()] || keyword;
    const query = `${enhancedKeyword} near ${locationMap[location.toLowerCase()] || `${location}, Colorado`}`;
    const searchUrl = `https://maps.googleapis.com/maps/api/place/textsearch/json?key=${apiKey}&query=${encodeURIComponent(query)}`;

    console.log('API Request:', {
      originalKeyword: keyword,
      enhancedKeyword,
      query,
      timestamp: new Date().toISOString()
    });

    const response = await makeRequest(searchUrl);
    const data = await response.json();

    // If no results found, try an alternative search
    if (data.results.length === 0) {
      console.log('No results found. Trying alternative search term...');
      const alternativeQuery = keyword.toLowerCase() === 'handyman' 
        ? `home repair ${location}`
        : `${keyword} repair service ${location}`;
      const alternativeUrl = `https://maps.googleapis.com/maps/api/place/textsearch/json?key=${apiKey}&query=${encodeURIComponent(alternativeQuery)}`;
      
      const alternativeResponse = await makeRequest(alternativeUrl);
      const alternativeData = await alternativeResponse.json();
      
      if (alternativeData.results.length > 0) {
        data.results = alternativeData.results;
      }
    }

    // Cache the results
    if (data.results.length > 0) {
      try {
        await PlaceCache.createOrUpdateCache(cacheKey, data.results, CACHE_DURATION_HOURS);
        console.log('Successfully cached results for:', cacheKey);
      } catch (error) {
        console.error('Error caching results:', error);
        // Continue even if caching fails
      }
    }

    return data;
  } catch (error) {
    console.error('Error in searchPlaces:', error);
    // Return empty results instead of throwing
    return { results: [] };
  }
}