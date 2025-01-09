import { Client, PlaceType1 as PlaceType, Status } from "@googlemaps/google-maps-services-js";

const client = new Client({});

export interface SearchParams {
  query?: string;
  location: string;
  radius?: number;
  type?: PlaceType;
}

export interface ContractorData {
  name: string;
  address: string;
  phone?: string;
  website?: string;
  rating?: number;
  reviews_count?: number;
  place_id: string;
  latitude: number;
  longitude: number;
  photos?: string[];
}

export async function searchPlaces(params: SearchParams) {
  try {
    const response = await client.textSearch({
      params: {
        key: process.env.GOOGLE_PLACES_API_KEY!,
        query: params.query || '',
        location: params.location,
        radius: params.radius || 5000,
        type: params.type
      },
      timeout: 5000
    });

    if (response.data.status === Status.REQUEST_DENIED) {
      throw new Error(`Google Places API request denied: ${response.data.error_message}`);
    }

    return response.data.results;
  } catch (error) {
    console.error('Error searching places:', error);
    throw error;
  }
}

export async function getPlaceDetails(placeId: string) {
  try {
    const response = await client.placeDetails({
      params: {
        key: process.env.GOOGLE_PLACES_API_KEY!,
        place_id: placeId,
        fields: [
          'name',
          'formatted_address',
          'formatted_phone_number',
          'website',
          'rating',
          'user_ratings_total',
          'geometry',
          'photos'
        ]
      },
      timeout: 5000
    });

    if (response.data.status === Status.REQUEST_DENIED) {
      throw new Error(`Google Places API request denied: ${response.data.error_message}`);
    }

    return response.data.result;
  } catch (error) {
    console.error('Error getting place details:', error);
    throw error;
  }
}

export function transformToContractorData(placeDetails: any): ContractorData {
  return {
    name: placeDetails.name,
    address: placeDetails.formatted_address,
    phone: placeDetails.formatted_phone_number,
    website: placeDetails.website,
    rating: placeDetails.rating,
    reviews_count: placeDetails.user_ratings_total,
    place_id: placeDetails.place_id,
    latitude: placeDetails.geometry?.location?.lat,
    longitude: placeDetails.geometry?.location?.lng,
    photos: placeDetails.photos?.map((photo: any) => photo.photo_reference) || []
  };
}

// Rate limiting utility
export const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

// Error handling utility
export class PlacesAPIError extends Error {
  constructor(message: string, public originalError: any) {
    super(message);
    this.name = 'PlacesAPIError';
  }
}
