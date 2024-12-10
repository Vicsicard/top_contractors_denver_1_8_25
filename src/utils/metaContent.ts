import { Metadata } from 'next';
import { Location } from './searchData';

export function generateMetaContent(
  keyword: string,
  location: Location,
  count: number = 10
): Metadata {
  const title = `The ${count} Best ${keyword} in ${location.location}, ${location.county}`;
  const description = `Compare the top ${count} ${keyword.toLowerCase()} in ${
    location.location
  }, ${location.county}. View detailed profiles, customer reviews, and contact information.`;

  return {
    title,
    description,
    openGraph: {
      title,
      description,
      type: 'website',
      locale: 'en_US',
    },
    twitter: {
      card: 'summary_large_image',
      title,
      description,
    },
    alternates: {
      canonical: `/${encodeURIComponent(keyword)}/${encodeURIComponent(location.location)}`,
    },
  };
}

export function generateStructuredData(
  keyword: string,
  location: Location,
  count: number = 10
) {
  return {
    '@context': 'https://schema.org',
    '@type': 'ItemList',
    name: `Top ${keyword} in ${location.location}, ${location.county}`,
    description: `List of the best ${count} ${keyword.toLowerCase()} in ${location.location}, ${location.county}`,
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
