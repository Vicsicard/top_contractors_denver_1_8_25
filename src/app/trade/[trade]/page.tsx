import React from 'react';
import { Suspense } from 'react';
import type { Metadata } from 'next';
import { ClientResultsList } from '@/app/components/ClientResultsList';

const validTrades = [
  "Plumber",
  "Electrician",
  "HVAC",
  "Roofer",
  "Carpenter",
  "Painter",
  "Landscaper",
  "Home Remodeling",
  "Bathroom Remodeling",
  "Kitchen Remodeling",
  "Siding & Gutters",
  "Masonry",
  "Decks",
  "Flooring",
  "Windows",
  "Fencing"
];

export async function generateMetadata({ params }: { params: { trade: string } }): Promise<Metadata> {
  const tradeName = (await params).trade
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');

  return {
    title: `${tradeName} Contractors in Denver | Find Local ${tradeName}s`,
    description: `Find trusted ${tradeName.toLowerCase()} contractors in Denver. Get quotes, read reviews, and hire the best ${tradeName.toLowerCase()} for your project.`
  };
}

export default async function TradePage({
  params,
}: {
  params: { trade: string };
}): Promise<React.ReactNode> {
  const trade = (await params).trade;
  const decodedTrade = decodeURIComponent(trade);
  
  if (!validTrades.includes(decodedTrade)) {
    return (
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">Invalid Trade</h1>
        <p className="text-gray-600">The requested trade category does not exist.</p>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <Suspense fallback={<div>Loading...</div>}>
        <ClientResultsList 
          keyword={decodedTrade} 
          location="Denver" 
          includeDetails={{
            businessName: true,
            address: true,
            reviews: true,
            telephoneNumber: true,
            website: true
          }} 
        />
      </Suspense>
    </div>
  );
}
