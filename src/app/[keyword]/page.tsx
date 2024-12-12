import { Metadata } from 'next';
import { loadLocations } from '@/utils/searchData';
import SearchResults from '@/components/SearchResults';
import Breadcrumbs from '@/components/Breadcrumbs';
import JsonLd from '@/components/JsonLd';
import React from 'react';

interface PageProps {
  params: Promise<{
    keyword: string;
  }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const resolvedParams = await params;
  const { keyword } = resolvedParams;
  const decodedKeyword = decodeURIComponent(keyword);

  return {
    title: `${decodedKeyword} Contractors in Denver | Find Local Professionals`,
    description: `Find the best ${decodedKeyword.toLowerCase()} contractors in Denver. Browse reviews, compare prices, and get quotes from local professionals.`,
  };
}

export default async function KeywordPage({ params }: PageProps): Promise<React.ReactElement> {
  const resolvedParams = await params;
  const { keyword } = resolvedParams;
  const decodedKeyword = decodeURIComponent(keyword);
  
  const searchResult = await loadLocations(decodedKeyword);
  const hasResults = searchResult.locations.length > 0;

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Service',
    name: `${decodedKeyword} in Denver Area`,
    areaServed: {
      '@type': 'City',
      name: 'Denver',
      '@id': 'https://www.wikidata.org/wiki/Q16554'
    }
  };

  return (
    <main className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={decodedKeyword} />
      <JsonLd type="Service" data={jsonLd} />
      
      <h1 className="text-4xl font-bold mb-8">
        {decodedKeyword} Contractors in Denver
      </h1>
      
      {hasResults ? (
        <div className="mb-8">
          <p className="text-lg text-neutral-600 mb-4">
            Browse our selection of {searchResult.total} trusted {decodedKeyword.toLowerCase()} contractors 
            serving the Denver area.
          </p>
          
          <SearchResults 
            results={{
              data: searchResult.locations,
              pagination: {
                currentPage: 1,
                totalPages: Math.ceil(searchResult.total / 10),
                totalItems: searchResult.total,
                itemsPerPage: 10,
                hasNextPage: searchResult.total > 10,
                hasPreviousPage: false
              }
            }}
            isLoading={false}
            onPageChange={() => {}}
          />
        </div>
      ) : (
        <p className="text-lg text-neutral-600">
          No contractors found for {decodedKeyword.toLowerCase()}. Try searching for a different service.
        </p>
      )}
    </main>
  );
}
