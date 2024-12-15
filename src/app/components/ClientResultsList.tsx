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
        <h2 className="text-2xl font-semibold text-gray-900">Loading...</h2>
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
          {places.map((place) => (
            <div
              key={place.place_id}
              className="group relative flex flex-col overflow-hidden rounded-lg border border-gray-200 bg-white"
            >
              <div className="flex flex-1 flex-col space-y-2 p-4">
                <h3 className="text-sm font-medium text-gray-900">
                  <span className="absolute inset-0" />
                  {place.name}
                </h3>
                <p className="text-sm text-gray-500">{place.formatted_address}</p>
                {place.rating && (
                  <p className="text-sm text-gray-500">
                    Rating: {place.rating} ({place.user_ratings_total} reviews)
                  </p>
                )}
                {place.phone_number && (
                  <p className="text-sm text-gray-500">
                    <Link
                      href={`tel:${place.phone_number}`}
                      className="text-emerald-600 hover:text-emerald-500"
                    >
                      {place.phone_number}
                    </Link>
                  </p>
                )}
                {place.website && (
                  <p className="text-sm text-gray-500">
                    <Link
                      href={place.website}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-emerald-600 hover:text-emerald-500"
                    >
                      Visit Website
                    </Link>
                  </p>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
