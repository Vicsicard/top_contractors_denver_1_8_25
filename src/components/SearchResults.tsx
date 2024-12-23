'use client';

import React from 'react';
import Pagination from './Pagination';
import { PaginatedResponse } from '@/types/pagination';
import { Business } from '@/types/business';

interface SearchResultsProps {
  results: PaginatedResponse<Business>;
  isLoading?: boolean;
  error?: string;
  onPageChange?: (page: number) => void;
}

export default function SearchResults({ 
  results, 
  isLoading = false, 
  error,
  onPageChange 
}: SearchResultsProps): React.ReactElement {
  if (isLoading) {
    return (
      <div className="w-full p-8 text-center">
        <div className="animate-pulse space-y-4">
          {[...Array(5)].map((_, i) => (
            <div key={i} className="bg-gray-200 h-32 rounded-lg"></div>
          ))}
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="w-full p-8 text-center text-red-600">
        <p>{error}</p>
      </div>
    );
  }

  if (!results.data.length) {
    return (
      <div className="w-full p-8 text-center">
        <p>No results found.</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {results.data.map((business) => (
          <div key={business.id} className="bg-white rounded-lg shadow-md p-6">
            <h2 className="text-xl font-semibold mb-2">{business.name}</h2>
            <p className="text-gray-600 mb-2">{business.address}</p>
            <div className="flex items-center mb-2">
              <span className="text-yellow-400 mr-1">★</span>
              <span>{business.rating.toFixed(1)}</span>
              <span className="text-gray-500 ml-2">({business.reviewCount} reviews)</span>
            </div>
            {business.categories && business.categories.length > 0 && (
              <div className="flex flex-wrap gap-2 mb-2">
                {business.categories.map((category, index) => (
                  <span key={index} className="bg-gray-100 text-gray-600 px-2 py-1 rounded text-sm">
                    {category}
                  </span>
                ))}
              </div>
            )}
            {business.phone && (
              <p className="text-gray-600">
                <span className="font-medium">Phone:</span> {business.phone}
              </p>
            )}
            {business.website && (
              <a 
                href={business.website}
                target="_blank"
                rel="noopener noreferrer"
                className="text-blue-600 hover:underline block mt-2"
              >
                Visit Website
              </a>
            )}
          </div>
        ))}
      </div>
      {results.pagination && onPageChange && (
        <Pagination 
          currentPage={results.pagination.currentPage}
          totalPages={results.pagination.totalPages}
          onPageChange={onPageChange}
        />
      )}
    </div>
  );
}
