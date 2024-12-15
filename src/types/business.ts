export interface Business {
  id: string;
  name: string;
  rating: number;
  reviewCount: number;
  address: string;
  location: {
    lat: number;
    lng: number;
  };
  categories?: string[];
  phone?: string;
  website?: string;
  businessStatus?: string;
}
