import React from 'react';

interface JsonLdData {
  '@context': string;
  '@type': string;
  name?: string;
  description?: string;
  url?: string;
  telephone?: string;
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
  [key: string]: unknown;
}

interface JsonLdProps {
  type: string;
  data: JsonLdData;
}

export function JsonLd({ type, data }: JsonLdProps): React.ReactElement {
  return (
    <script
      type={type}
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default JsonLd;
