import React from 'react';
import Pagination from './Pagination';
import { PaginatedResponse } from '@/types/pagination';

interface Business {
  name: string;
  rating: number;
  reviewCount: number;
  address: string;
  categories: string[];
  phone?: string;
}

interface SearchResultsProps {
  results: PaginatedResponse<Business>;
  isLoading: boolean;
  error?: string;
  onPageChange: (page: number) => void;
}

export default function SearchResults({ 
  results, 
  isLoading, 
  error,
  onPageChange 
}: SearchResultsProps): React.ReactElement {
  if (isLoading) {
    return (
      <div className="w-full p-8 text-center">
        <div className="animate-pulse space-y-4">
          {[...Array(5)].map((_, i) => (
            <div key={i} className="bg-neutral-100 h-32 rounded-xl"/>
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

  if (!results.data || results.data.length === 0) {
    return (
      <div className="w-full p-8 text-center text-neutral-600">
        <p>No results found. Try adjusting your search criteria.</p>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="space-y-4">
        {results.data.map((business, index) => (
          <div
            key={`${business.name}-${index}`}
            className="p-4 rounded-xl border border-neutral-200 hover:border-blue-500 transition-colors"
          >
            <h3 className="text-lg font-semibold">{business.name}</h3>
            <div className="mt-2 text-sm text-neutral-600">
              <p>{business.address}</p>
              {business.phone && <p className="mt-1">{business.phone}</p>}
              <p className="mt-1">
                {business.rating} stars ({business.reviewCount} reviews)
              </p>
              <div className="mt-2 flex flex-wrap gap-2">
                {business.categories.map((category, i) => (
                  <span
                    key={i}
                    className="px-2 py-1 bg-neutral-100 rounded-full text-xs"
                  >
                    {category}
                  </span>
                ))}
              </div>
            </div>
          </div>
        ))}
      </div>
      
      {results.pagination && (
        <Pagination
          currentPage={results.pagination.currentPage}
          totalPages={results.pagination.totalPages}
          itemsPerPage={results.pagination.itemsPerPage}
          totalItems={results.pagination.totalItems}
          onPageChange={onPageChange}
        />
      )}
    </div>
  );
}
