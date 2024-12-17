import Head from 'next/head';
import { FC } from 'react';
import { generateLocalBusinessSchema, generateServiceSchema, generateBreadcrumbSchema } from '../utils/schema';

interface SchemaData {
  '@context': string;
  '@type': string;
  name?: string;
  description?: string;
  url?: string;
  telephone?: string;
  priceRange?: string;
  address?: {
    '@type': string;
    streetAddress?: string;
    addressLocality?: string;
    addressRegion?: string;
    postalCode?: string;
    addressCountry?: string;
  };
  geo?: {
    '@type': string;
    latitude?: number;
    longitude?: number;
  };
  itemListElement?: Array<{
    '@type': string;
    position: number;
    item: {
      '@id': string;
      name: string;
    };
  }>;
}

interface SchemaMarkupProps {
  type: 'local' | 'breadcrumb';
  data: SchemaData;
}

const SchemaMarkup: FC<SchemaMarkupProps> = ({ type, data }) => {
  return (
    <Head>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          __html: JSON.stringify(data),
        }}
        key={`schema-${type}`}
      />
    </Head>
  );
};

export default SchemaMarkup;
