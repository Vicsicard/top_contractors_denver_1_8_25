import React from 'react';
import { Contractor } from '@/types/routes';

interface CategoryListProps {
  contractors: Contractor[];
  keyword: string;
  location: string;
}

export default function CategoryList({ contractors }: CategoryListProps): React.ReactElement {
  return (
    <div className="space-y-6">
      {contractors.map((contractor) => (
        <div key={contractor.id} className="bg-white p-6 rounded-lg shadow-md">
          <h2 className="text-xl font-semibold mb-2">{contractor.name}</h2>
          <div className="flex items-center mb-2">
            <span className="text-yellow-500">★</span>
            <span className="ml-1">{contractor.rating} ({contractor.reviewCount} reviews)</span>
          </div>
          <p className="text-gray-600 mb-2">{contractor.address}</p>
          {contractor.phone && (
            <p className="text-gray-600 mb-2">
              <strong>Phone:</strong> {contractor.phone}
            </p>
          )}
          {contractor.website && (
            <a
              href={contractor.website}
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:underline mb-2 block"
            >
              Visit Website
            </a>
          )}
          <div className="mt-4">
            <strong>Services:</strong>
            <div className="flex flex-wrap gap-2 mt-2">
              {contractor.services.map((service) => (
                <span
                  key={service}
                  className="bg-gray-100 px-3 py-1 rounded-full text-sm text-gray-700"
                >
                  {service}
                </span>
              ))}
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
