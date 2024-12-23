import { PrismaClient, Business } from '@prisma/client';
import { waitForToken } from './rateLimiter';

// Initialize Prisma client
const prisma = new PrismaClient();

// Type for Google Places API response
interface GooglePlacesResponse {
  name: string;
  rating?: number;
  user_ratings_total?: number;
  formatted_address?: string;
  geometry?: {
    location: {
      lat: number;
      lng: number;
    };
  };
  types?: string[];
  formatted_phone_number?: string;
  website?: string;
  business_status?: string;
}

export const REFRESH_THRESHOLD_HOURS = 24; // Refresh data older than 24 hours

export async function shouldRefreshData(business: Business): Promise<boolean> {
  if (!business.updatedAt) return true;
  
  const now = new Date();
  const lastUpdate = new Date(business.updatedAt);
  const hoursSinceUpdate = (now.getTime() - lastUpdate.getTime()) / (1000 * 60 * 60);
  
  return hoursSinceUpdate >= REFRESH_THRESHOLD_HOURS;
}

export async function refreshBusinessData(placeId: string): Promise<Business | null> {
  try {
    // First check if we have this business in our database
    const existingBusiness = await prisma.business.findFirst({
      where: { id: placeId }
    });

    // If we have the business and it's recent enough, return it
    if (existingBusiness && !await shouldRefreshData(existingBusiness)) {
      return existingBusiness;
    }

    // Rate-limited Google Places API call
    await waitForToken();
    const placeDetails = await fetchGooglePlaceDetails(placeId);

    if (!placeDetails) return null;

    // Update or create business in database
    const updatedBusiness = await prisma.business.upsert({
      where: { id: placeId },
      update: {
        name: placeDetails.name,
        rating: placeDetails.rating || 0,
        reviewCount: placeDetails.user_ratings_total || 0,
        address: placeDetails.formatted_address || '',
        location: {
          lat: placeDetails.geometry?.location.lat || 0,
          lng: placeDetails.geometry?.location.lng || 0,
        },
        categories: placeDetails.types || [],
        phone: placeDetails.formatted_phone_number,
        website: placeDetails.website,
        businessStatus: placeDetails.business_status,
        updatedAt: new Date(),
      },
      create: {
        id: placeId,
        name: placeDetails.name,
        rating: placeDetails.rating || 0,
        reviewCount: placeDetails.user_ratings_total || 0,
        address: placeDetails.formatted_address || '',
        location: {
          lat: placeDetails.geometry?.location.lat || 0,
          lng: placeDetails.geometry?.location.lng || 0,
        },
        categories: placeDetails.types || [],
        phone: placeDetails.formatted_phone_number,
        website: placeDetails.website,
        businessStatus: placeDetails.business_status,
      },
    });

    return updatedBusiness;
  } catch (error) {
    console.error('Error refreshing business data:', error);
    return null;
  }
}

async function fetchGooglePlaceDetails(placeId: string): Promise<GooglePlacesResponse | null> {
  const apiKey = process.env.GOOGLE_PLACES_API_KEY;
  if (!apiKey) {
    console.error('Google Places API key not found');
    return null;
  }

  try {
    await waitForToken();
    const response = await fetch(
      `https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=${apiKey}&fields=name,rating,user_ratings_total,formatted_address,geometry,types,formatted_phone_number,website,business_status`
    );

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    return data.result as GooglePlacesResponse;
  } catch (error) {
    console.error('Error fetching place details:', error);
    return null;
  }
}
