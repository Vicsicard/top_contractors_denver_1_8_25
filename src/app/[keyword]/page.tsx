import { Metadata } from 'next';
import SearchResultsWrapper from '@/components/SearchResultsWrapper';
import Breadcrumbs from '@/components/Breadcrumbs';
import JsonLd from '@/components/JsonLd';
import React from 'react';

interface PageProps {
  params: {
    keyword: string;
  };
}

// Map URL segments to search terms
const searchTermMap: { [key: string]: string } = {
  'plumber': 'plumber',
  'electrician': 'electrician',
  'hvac': 'hvac',
  'roofer': 'roofer',
  'carpenter': 'carpenter',
  'painter': 'painter',
  'landscaper': 'landscaper',
  'home-remodeler': 'home remodeler',
  'bathroom-remodeler': 'bathroom remodeler',
  'kitchen-remodeler': 'kitchen remodeler',
  'sider': 'siding installer',
  'mason': 'mason',
  'deck-builder': 'deck builder',
  'flooring-installer': 'flooring installer',
  'window-installer': 'window installer',
  'fence-installer': 'fence installer',
  'epoxy-garage-coater': 'epoxy garage coater'
};

// Map search terms to display names
const displayNameMap: { [key: string]: string } = {
  'plumber': 'Plumber',
  'electrician': 'Electrician',
  'hvac': 'HVAC',
  'roofer': 'Roofer',
  'carpenter': 'Carpenter',
  'painter': 'Painter',
  'landscaper': 'Landscaper',
  'home remodeler': 'Home Remodeler',
  'bathroom remodeler': 'Bathroom Remodeler',
  'kitchen remodeler': 'Kitchen Remodeler',
  'siding installer': 'Siding Installer',
  'mason': 'Mason',
  'deck builder': 'Deck Builder',
  'flooring installer': 'Flooring Installer',
  'window installer': 'Window Installer',
  'fence installer': 'Fence Installer',
  'epoxy garage coater': 'Epoxy Garage Coater'
};

function getSearchTerm(keyword: string): string {
  const decodedKeyword = decodeURIComponent(keyword).toLowerCase();
  return searchTermMap[decodedKeyword] || decodedKeyword.replace(/-/g, ' ');
}

function getDisplayName(searchTerm: string): string {
  return displayNameMap[searchTerm] || 
    searchTerm.split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
}

export const dynamic = 'force-static';
export const revalidate = 3600; // Revalidate every hour

// Generate static paths for all known categories
export async function generateStaticParams() {
  return [
    { keyword: 'plumber' },
    { keyword: 'electrician' },
    { keyword: 'hvac' },
    { keyword: 'roofer' },
    { keyword: 'carpenter' },
    { keyword: 'painter' },
    { keyword: 'landscaper' },
    { keyword: 'home-remodeler' },
    { keyword: 'bathroom-remodeler' },
    { keyword: 'kitchen-remodeler' },
    { keyword: 'sider' },
    { keyword: 'mason' },
    { keyword: 'deck-builder' },
    { keyword: 'flooring-installer' },
    { keyword: 'window-installer' },
    { keyword: 'fence-installer' },
    { keyword: 'epoxy-garage-coater' }
  ];
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { keyword } = params;
  const searchTerm = getSearchTerm(keyword);
  const displayName = getDisplayName(searchTerm);

  return {
    title: `${displayName} Contractors in Denver | Find Local Professionals`,
    description: `Find the best ${searchTerm.toLowerCase()} contractors in Denver. Browse reviews, compare prices, and get quotes from local professionals.`,
  };
}

export default function KeywordPage({ params }: PageProps): React.ReactElement {
  const { keyword } = params;
  const searchTerm = getSearchTerm(keyword);
  const displayName = getDisplayName(searchTerm);

  // During build time, return placeholder content
  const isBuildTime = process.env.NODE_ENV === 'production' && process.env.NEXT_PHASE === 'phase-production-build';
  const searchResult = isBuildTime ? { locations: [], total: 0 } : { locations: [], total: 0 };

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Service',
    name: `${displayName} in Denver Area`,
    areaServed: {
      '@type': 'City',
      name: 'Denver',
      '@id': 'https://www.wikidata.org/wiki/Q16554'
    }
  };

  return (
    <main className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={displayName} />
      <JsonLd type="Service" data={jsonLd} />
      
      <h1 className="text-4xl font-bold mb-8">
        {displayName} Contractors in Denver
      </h1>
      
      {!isBuildTime ? (
        <div className="mb-8">
          <p className="text-lg text-neutral-600 mb-4">
            Browse our selection of {searchResult.total} trusted {searchTerm.toLowerCase()} contractors 
            serving the Denver area.
          </p>
          
          <SearchResultsWrapper 
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
          />
        </div>
      ) : (
        <div className="mb-8">
          <p className="text-lg text-neutral-600">
            Loading {searchTerm.toLowerCase()} contractors in your area...
          </p>
        </div>
      )}
    </main>
  );
}
