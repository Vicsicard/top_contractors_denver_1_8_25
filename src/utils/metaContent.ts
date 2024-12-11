import { Metadata } from 'next';
import { Location, MetadataParams } from '@/types/routes';

export interface StructuredData {
  '@context': string;
  '@type': string;
  name: string;
  description: string;
  itemListElement: Array<{
    '@type': string;
    position: number;
    item: {
      '@type': string;
      name: string;
      address: {
        '@type': string;
        streetAddress: string;
      };
      telephone?: string;
      url?: string;
      aggregateRating?: {
        '@type': string;
        ratingValue: number;
        reviewCount: number;
      };
    };
  }>;
  numberOfItems?: number;
  itemListOrder?: string;
  areaServed?: {
    '@type': string;
    name: string;
    containedIn: {
      '@type': string;
      name: string;
    };
  };
}

export function generateMetaContent({ keyword, location }: MetadataParams): Metadata {
  const title = `${keyword} in ${location} | Denver Contractors`;
  const description = `Find trusted ${keyword.toLowerCase()} contractors in ${location}. Get connected with qualified professionals for your project needs.`;

  return {
    title,
    description,
    openGraph: {
      title,
      description,
      siteName: 'Denver Contractors',
      locale: 'en_US',
      type: 'website',
    },
    twitter: {
      card: 'summary_large_image',
      title,
      description,
    },
    robots: {
      index: true,
      follow: true,
    },
    alternates: {
      canonical: `https://denvercontractors.com/${keyword.toLowerCase()}/${location.toLowerCase()}`,
    },
  };
}

export function generateStructuredData(
  keyword: string,
  location: Location,
  count: number = 10
): StructuredData {
  return {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `${keyword} Contractors in ${location.location}`,
    description: `List of ${keyword.toLowerCase()} contractors serving ${location.location}`,
    numberOfItems: count,
    itemListOrder: 'https://schema.org/ItemListOrderDescending',
    itemListElement: [], // This will be populated with actual data
    areaServed: {
      '@type': 'City',
      name: location.location,
      containedIn: {
        '@type': 'AdministrativeArea',
        name: location.county
      }
    }
  };
}
