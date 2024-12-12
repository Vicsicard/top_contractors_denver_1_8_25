export interface Business {
  name: string;
  rating: number;
  reviewCount: number;
  address: string;
  categories: string[];
  phone?: string;
  website?: string;
  businessStatus?: string;
}
