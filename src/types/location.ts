export interface Review {
  rating: number;
  text: string;
  author: string;
  date: string;
}

export interface Location {
  location: string;
  name: string;
  rating?: number;
  reviews?: Review[];
  services?: string[];
  phone?: string;
}
