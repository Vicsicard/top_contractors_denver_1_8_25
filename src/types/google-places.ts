export interface PlaceResult {
  place_id: string;
  name: string;
  formatted_address: string;
  geometry?: {
    location: {
      lat: number;
      lng: number;
    };
  };
  rating?: number;
  user_ratings_total?: number;
  phone_number?: string;
  website?: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
  business_status?: string;
  types?: string[];
}

export interface PlacesApiResponse {
  results: PlaceResult[];
  status: string;
  error?: {
    message: string;
    code: string;
    details?: string;
  };
}
