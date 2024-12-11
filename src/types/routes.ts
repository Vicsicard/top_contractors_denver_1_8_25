export interface PageParams {
  keyword: string;
  location?: string;
}

export interface SearchParams {
  [key: string]: string | string[] | undefined;
}

export interface PageProps {
  params: Promise<PageParams>;
  searchParams?: Promise<SearchParams>;
}

export interface Contractor {
  id: string;
  name: string;
  rating: number;
  reviewCount: number;
  address: string;
  phone?: string;
  website?: string;
  services: string[];
}

export interface MetadataParams {
  keyword: string;
  location: string;
}

export interface Location {
  location: string;
  county: string;
}
