'use client';

import Link from 'next/link';
import { notFound } from 'next/navigation';

interface Props {
  trade: string;
  data: {
    category: {
      id: string;
      category_name: string;
      slug: string;
    };
    regions: Array<{
      id: string;
      region_name: string;
      slug: string;
    }>;
  };
}

export function TradePage({ data }: Props) {
  if (!data || !data.regions) {
    notFound();
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">
        {data.category.category_name} Contractors
      </h1>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {data.regions.map(region => (
          <Link 
            key={region.id} 
            href={`/${data.category.slug}/${region.slug}`}
            className="block p-6 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow"
          >
            <h2 className="text-xl font-semibold mb-2">
              {region.region_name}
            </h2>
          </Link>
        ))}
      </div>
    </div>
  );
}
