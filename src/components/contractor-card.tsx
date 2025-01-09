import React from 'react';
import { StarIcon } from '@heroicons/react/20/solid';
import { Database } from '@/types/database';

type Contractor = Database['public']['Tables']['contractors']['Row'];

interface ContractorCardProps {
  contractor: Contractor;
}

export function ContractorCard({ contractor }: ContractorCardProps) {
  return (
    <div className="bg-white rounded-lg shadow-md p-6">
      <h3 className="text-xl font-semibold text-gray-900 mb-2">
        {contractor.contractor_name}
      </h3>
      
      <div className="space-y-2">
        <p className="text-gray-600">
          <span className="font-medium">Address:</span> {contractor.address}
        </p>
        
        <p className="text-gray-600">
          <span className="font-medium">Phone:</span> {contractor.phone}
        </p>
        
        {contractor.website && (
          <p className="text-gray-600">
            <span className="font-medium">Website:</span>{' '}
            <a
              href={contractor.website}
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:text-blue-800"
            >
              Visit Website
            </a>
          </p>
        )}
        
        <div className="flex items-center">
          <span className="font-medium mr-2">Reviews:</span>
          <div className="flex items-center">
            {[...Array(5)].map((_, i) => (
              <StarIcon
                key={i}
                className={`h-5 w-5 ${
                  i < Math.round(contractor.reviews_avg)
                    ? 'text-yellow-400'
                    : 'text-gray-300'
                }`}
              />
            ))}
          </div>
          <span className="ml-2 text-gray-600">
            ({contractor.reviews_count})
          </span>
        </div>
      </div>
    </div>
  );
}
