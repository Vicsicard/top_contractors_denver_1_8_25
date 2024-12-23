'use client';

import React from 'react';
import SearchResults from './SearchResults';
import { PaginatedResponse } from '@/types/pagination';
import { Business } from '@/types/business';

interface SearchResultsWrapperProps {
  results: PaginatedResponse<Business>;
  isLoading?: boolean;
  error?: string;
}

export default function SearchResultsWrapper({ 
  results, 
  isLoading = false, 
  error 
}: SearchResultsWrapperProps): React.ReactElement {
  const handlePageChange = (page: number) => {
    // Handle page change logic here
    console.log('Page changed to:', page);
  };

  return (
    <SearchResults 
      results={results}
      isLoading={isLoading}
      error={error}
      onPageChange={handlePageChange}
    />
  );
}
