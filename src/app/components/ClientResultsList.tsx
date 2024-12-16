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
  const response = await fetch(
    `/api/search/places?keyword=${encodeURIComponent(
      keyword
    )}&location=${encodeURIComponent(location)}`,
    { cache: 'no-store' }
  );

  if (!response.ok) {
    throw new Error('Failed to fetch places');
  }

  const data = await response.json();
  return data.results;
}

export function ClientResultsList({ keyword, location }: ResultsListProps): JSX.Element {
  const [places, setPlaces] = useState<Place[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchPlaces = async () => {
      try {
        setLoading(true);
        setError(null);
        const results = await searchPlaces(keyword, location);
        setPlaces(results);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch places');
      } finally {
        setLoading(false);
      }
    };

    fetchPlaces();
  }, [keyword, location]);

  if (loading) {
    return (
      <div className="text-center py-12">
        <div className="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-emerald-500 mx-auto"></div>
        <h2 className="text-2xl font-semibold text-gray-900 mt-4">Loading...</h2>
      </div>
    );
  }

  if (error) {
    return (
      <div className="text-center py-12">
        <h2 className="text-2xl font-semibold text-red-600">Error</h2>
        <p className="mt-2 text-gray-600">{error}</p>
      </div>
    );
  }

  if (!places || places.length === 0) {
    return (
      <div className="text-center py-12">
        <h2 className="text-2xl font-semibold text-gray-900">No results found</h2>
        <p className="mt-2 text-gray-600">Try adjusting your search criteria</p>
      </div>
    );
  }

  return (
    <div className="bg-white">
      <div className="mx-auto max-w-7xl">
        <h2 className="text-2xl font-bold tracking-tight text-gray-900">
          Results for {keyword} in {location}
        </h2>
        <div className="mt-6 grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {places.map((place, index) => (
            <div
              key={`${place.place_id}-${index}`}
              className="group relative flex flex-col overflow-hidden rounded-lg border border-gray-200 bg-white shadow-sm hover:shadow-md transition-shadow duration-200"
            >
              <div className="flex flex-1 flex-col p-6">
                {/* Contractor Name */}
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  {place.name}
                </h3>

                {/* Address */}
                <div className="flex items-start space-x-2 mb-3">
                  <svg className="w-5 h-5 text-gray-400 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                  </svg>
                  <p className="text-sm text-gray-600">{place.formatted_address}</p>
                </div>

                {/* Rating */}
                {place.rating && (
                  <div className="flex items-center space-x-2 mb-3">
                    <svg className="w-5 h-5 text-yellow-400 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                    <div>
                      <span className="text-sm font-medium text-gray-900">{place.rating}</span>
                      <span className="text-sm text-gray-500 ml-1">({place.user_ratings_total} reviews)</span>
                    </div>
                  </div>
                )}

                {/* Phone Number */}
                {place.phone_number && (
                  <div className="flex items-center space-x-2 mb-3">
                    <svg className="w-5 h-5 text-gray-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                    </svg>
                    <Link
                      href={`tel:${place.phone_number}`}
                      className="text-sm text-emerald-600 hover:text-emerald-500"
                    >
                      {place.phone_number}
                    </Link>
                  </div>
                )}

                {/* Website */}
                {place.website && (
                  <div className="flex items-center space-x-2">
                    <svg className="w-5 h-5 text-gray-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9" />
                    </svg>
                    <Link
                      href={place.website}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-sm text-emerald-600 hover:text-emerald-500"
                    >
                      Visit Website
                    </Link>
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
