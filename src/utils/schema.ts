interface LocalBusiness {
  "@type": "LocalBusiness";
  "@id": string;
  name: string;
  image?: string;
  address: {
    "@type": "PostalAddress";
    streetAddress: string;
    addressLocality: string;
    addressRegion: string;
    postalCode: string;
    addressCountry: string;
  };
  geo: {
    "@type": "GeoCoordinates";
    latitude: number;
    longitude: number;
  };
  url: string;
  telephone?: string;
  priceRange?: string;
  openingHoursSpecification?: Array<{
    "@type": "OpeningHoursSpecification";
    dayOfWeek: string[];
    opens: string;
    closes: string;
  }>;
  aggregateRating?: {
    "@type": "AggregateRating";
    ratingValue: string;
    reviewCount: string;
  };
}

interface Service {
  "@type": "Service";
  name: string;
  description: string;
  provider: {
    "@type": "LocalBusiness";
    name: string;
    image?: string;
    address: {
      "@type": "PostalAddress";
      addressLocality: string;
      addressRegion: string;
    };
  };
  areaServed: {
    "@type": "City";
    name: string;
  };
  serviceType: string;
}

interface BreadcrumbItem {
  "@type": "ListItem";
  position: number;
  item: {
    "@id": string;
    name: string;
  };
}

interface BreadcrumbList {
  "@context": "https://schema.org";
  "@type": "BreadcrumbList";
  itemListElement: BreadcrumbItem[];
}

export const generateLocalBusinessSchema = (business: Partial<LocalBusiness>): string => {
  const schema = {
    "@context": "https://schema.org",
    ...business,
  };
  return JSON.stringify(schema);
};

export const generateServiceSchema = (service: Partial<Service>): string => {
  const schema = {
    "@context": "https://schema.org",
    ...service,
  };
  return JSON.stringify(schema);
};

export const generateBreadcrumbSchema = (items: BreadcrumbItem[]): string => {
  const breadcrumbList: BreadcrumbList = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items
  };
  return JSON.stringify(breadcrumbList);
};
