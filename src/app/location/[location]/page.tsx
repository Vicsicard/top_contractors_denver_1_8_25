import React from 'react';
import { Suspense } from 'react';
import type { Metadata } from 'next';
import { ClientResultsList } from '@/app/components/ClientResultsList';

const validLocations = [
  "Downtown Denver",
  "Aurora",
  "Lakewood",
  "Littleton",
  "Arvada",
  "Westminster",
  "Centennial",
  "Thornton"
];

export async function generateMetadata({ params }: { params: { location: string } }): Promise<Metadata> {
  const locationName = params.location
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');

  return {
    title: `Contractors in ${locationName} | Find Local Services`,
    description: `Find trusted contractors in ${locationName}. Get quotes, read reviews, and hire the best local contractors for your project.`
  };
}

export default async function LocationPage({
  params,
}: {
  params: { location: string };
}): Promise<React.ReactNode> {
  const location = decodeURIComponent(params.location);
  
  if (!validLocations.includes(location)) {
    return (
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">Invalid Location</h1>
        <p className="text-gray-600">The requested location does not exist.</p>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <Suspense fallback={<div>Loading...</div>}>
        <ClientResultsList keyword="contractor" location={location} />
      </Suspense>
    </div>
  );
}
