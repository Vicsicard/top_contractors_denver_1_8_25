import { Suspense, ReactElement } from 'react';
import type { Metadata } from 'next';
import ClientResultsList from '@/app/components/ClientResultsList';

export const metadata: Metadata = {
  title: 'Search Results - Denver Contractors',
  description: 'Find the best contractors in Denver for your project',
};

interface PageProps {
  searchParams?: { [key: string]: string | string[] | undefined };
}

export default function ResultsPage({ searchParams }: PageProps): ReactElement {
  const keyword = searchParams?.keyword as string || '';
  const location = searchParams?.location as string || '';

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <h1 className="text-3xl font-bold mb-6">
        {keyword ? `Results for ${keyword} in ${location}` : 'Search Results'}
      </h1>
      <Suspense fallback={<div>Loading...</div>}>
        <ClientResultsList keyword={keyword} location={location} />
      </Suspense>
    </div>
  );
}
