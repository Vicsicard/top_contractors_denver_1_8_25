'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';

interface Place {
  name: string;
  formatted_address: string;
  rating?: number;
  user_ratings_total?: number;
  phone_number?: string;
  website?: string;
  place_id: string;
  opening_hours?: {
    open_now?: boolean;
    weekday_text?: string[];
  };
}

interface ResultsListProps {
  keyword: string;
  location: string;
}

async function searchPlaces(keyword: string, location: string): Promise<Place[]> {
  console.log('searchPlaces called with:', { keyword, location });
  
  try {
    // Clean up location parameter
    const cleanLocation = location.replace(/,\s*denver,\s*co/i, '').trim();
    const finalLocation = cleanLocation || 'Denver, CO';

    const url = `/api/places/search?query=${encodeURIComponent(
      keyword
    )}&location=${encodeURIComponent(finalLocation)}`;
    
    console.log('Fetching from URL:', url);
    const response = await fetch(url, { 
      cache: 'no-store',
      headers: {
        'Accept': 'application/json'
      }
    });

    console.log('Response received:', {
      status: response.status,
      ok: response.ok,
      statusText: response.statusText
    });

    let data;
    try {
      data = await response.json();
    } catch (parseError) {
      console.error('Error parsing response:', parseError);
      throw new Error('Invalid response from server');
    }

    if (!response.ok) {
      console.error('API Error:', data);
      throw new Error(data.message || 'Failed to fetch places');
    }

    console.log('Data received:', {
      status: data.status,
      resultsCount: data.results?.length
    });

    return data.results || [];
  } catch (error) {
    console.error('Error in searchPlaces:', error);
    throw error;
  }
}

const ClientResultsList: React.FC<ResultsListProps> = ({ keyword, location }) => {
  const [results, setResults] = useState<Place[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    console.log('useEffect triggered');
    if (!keyword) {
      setLoading(false);
      return;
    }

    const fetchResults = async () => {
      try {
        setLoading(true);
        setError(null);
        const places = await searchPlaces(keyword, location);
        setResults(places);
      } catch (err) {
        console.error('Error fetching results:', err);
        setError(err instanceof Error ? err.message : 'Failed to load results');
      } finally {
        setLoading(false);
      }
    };

    fetchResults();
  }, [keyword, location]);

  if (loading) {
    return (
      <div className="flex justify-center items-center py-12">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-gray-900"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="text-center py-12">
        <h2 className="text-xl font-semibold text-red-600">Error</h2>
        <p className="mt-2 text-gray-600">{error}</p>
      </div>
    );
  }

  if (!results || results.length === 0) {
    return (
      <div className="text-center py-12">
        <h2 className="text-2xl font-semibold text-gray-900">No results found</h2>
        <p className="mt-2 text-gray-600">Try adjusting your search criteria</p>
      </div>
    );
  }

  return (
    <div className="bg-white">
      <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <h2 className="text-2xl font-bold tracking-tight text-gray-900">
          Results for {keyword} in {location}
        </h2>
        <div className="mt-6 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {results.map((place, index) => (
            <div
              key={`${place.place_id}-${index}`}
              className="group relative flex flex-col overflow-hidden rounded-lg border border-gray-200 bg-white shadow-sm hover:shadow-md transition-shadow duration-200"
            >
              <div className="p-4">
                <h3 className="text-lg font-semibold text-gray-900">{place.name}</h3>
                <p className="mt-1 text-sm text-gray-500">{place.formatted_address}</p>
                {place.rating && (
                  <div className="mt-2">
                    <span className="text-yellow-400">★</span>
                    <span className="ml-1 text-sm text-gray-600">
                      {place.rating.toFixed(1)} ({place.user_ratings_total} reviews)
                    </span>
                  </div>
                )}
                {place.phone_number && (
                  <p className="mt-2 text-sm text-gray-600">{place.phone_number}</p>
                )}
                {place.website && (
                  <Link
                    href={place.website}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="mt-2 inline-block text-sm text-blue-600 hover:text-blue-800"
                  >
                    Visit Website
                  </Link>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default ClientResultsList;
