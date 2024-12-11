import { Location } from './routes';

export interface SchemaOrgService extends Record<string, unknown> {
  "@context": "https://schema.org";
  "@type": "Service";
  name: string;
  description: string;
  areaServed: {
    "@type": "City";
    name: string;
    containedIn?: string;
  };
  provider?: {
    "@type": "LocalBusiness";
    name: string;
  };
}

export interface SearchData {
  keywords: string[];
  locations: Location[];
}
