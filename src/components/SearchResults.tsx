import React from 'react';

interface Business {
  name: string;
  rating: number;
  reviewCount: number;
  address: string;
  categories: string[];
  phone?: string;
}

interface SearchResultsProps {
  results: Business[];
  isLoading: boolean;
  error?: string;
}

export default function SearchResults({ results, isLoading, error }: SearchResultsProps): React.ReactElement {
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

  if (results.length === 0) {
    return (
      <div className="w-full p-8 text-center text-neutral-600">
        <p>No results found. Try adjusting your search criteria.</p>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {results.map((business, index) => (
        <div
          key={`${business.name}-${index}`}
          className="bg-white p-6 rounded-xl shadow-soft hover:shadow-lg transition-shadow duration-300"
        >
          <div className="flex justify-between items-start">
            <div>
              <h3 className="text-lg font-semibold text-neutral-900 mb-2">
                {business.name}
              </h3>
              <div className="flex items-center space-x-2 mb-2">
                <div className="flex items-center">
                  <span className="text-primary-600 font-medium">
                    {business.rating.toFixed(1)}
                  </span>
                  <span className="text-neutral-500 text-sm ml-1">
                    ({business.reviewCount} reviews)
                  </span>
                </div>
              </div>
              <p className="text-neutral-600 text-sm mb-2">{business.address}</p>
              {business.phone && (
                <p className="text-neutral-600 text-sm">{business.phone}</p>
              )}
            </div>
            <div className="text-right">
              <div className="flex flex-wrap gap-2 justify-end">
                {business.categories.slice(0, 3).map((category, idx) => (
                  <span
                    key={idx}
                    className="px-3 py-1 bg-primary-50 text-primary-700 text-sm rounded-full"
                  >
                    {category}
                  </span>
                ))}
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
