export interface Contractor {
  id: string;
  name: string;
  description: string;
  address: string;
  phone: string;
  website: string;
  rating: number;
  reviewCount: number;
  categories: string[];
  region: string;
  area: string;
  neighborhood: string;
  businessHours?: string;
  emergencyService: boolean;
  yearsInBusiness: number;
}
