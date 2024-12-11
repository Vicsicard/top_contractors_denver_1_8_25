import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { PageProps } from '@/types/routes';
import { loadContractors } from '@/utils/searchData';
import Breadcrumbs from '@/components/Breadcrumbs';
import CategoryList from '@/components/CategoryList';
import JsonLd from '@/components/JsonLd';
import React from 'react';

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const resolvedParams = await params;
  const { keyword, location } = resolvedParams;
  if (!location) {
    notFound();
  }
  const parsedKeyword = decodeURIComponent(keyword);
  const parsedLocation = decodeURIComponent(location);

  return {
    title: `${parsedKeyword} in ${parsedLocation} | Denver Contractors`,
    description: `Find the best ${parsedKeyword} in ${parsedLocation}. Browse reviews, ratings, and contact information.`,
  };
}

export default async function Page({ params }: PageProps): Promise<React.ReactElement> {
  const resolvedParams = await params;
  const { keyword, location } = resolvedParams;
  if (!location) {
    notFound();
  }
  const parsedKeyword = decodeURIComponent(keyword);
  const parsedLocation = decodeURIComponent(location);

  const contractors = await loadContractors(parsedKeyword, parsedLocation);
  if (!contractors || contractors.length === 0) {
    notFound();
  }

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Service',
    name: `${parsedKeyword} in ${parsedLocation}`,
    areaServed: {
      '@type': 'City',
      name: parsedLocation,
      containedIn: {
        '@type': 'State',
        name: 'Colorado'
      }
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={parsedKeyword} location={parsedLocation} />
      <JsonLd type="Service" data={jsonLd} />
      <h1 className="text-3xl font-bold mb-4">
        {parsedKeyword} in {parsedLocation}
      </h1>
      <p className="text-lg mb-8">
        Browse our list of trusted {parsedKeyword} in {parsedLocation}:
      </p>
      <CategoryList 
        contractors={contractors} 
        keyword={parsedKeyword}
        location={parsedLocation}
      />
    </div>
  );
}