import { Suspense } from 'react';
import Link from 'next/link';

interface SearchParams {
  keyword?: string;
  location?: string;
}

interface Props {
  searchParams: SearchParams;
}

interface Place {
  place_id: string;
  name: string;
  formatted_address: string;
  rating?: number;
  user_ratings_total?: number;
  opening_hours?: { open_now: boolean };
}

async function getResults(keyword: string, location: string): Promise<Place[]> {
  const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000';
  const url = `${baseUrl}/api/places/search?keyword=${encodeURIComponent(keyword)}&location=${encodeURIComponent(location)}`;
  console.log(`Fetching results from: ${url}`);
  const res = await fetch(url, { cache: 'no-store' });
  if (!res.ok) throw new Error('Failed to fetch results');
  return res.json();
}

export default async function ResultsPage({ searchParams }: Props): Promise<JSX.Element> {
  const { keyword, location } = searchParams;

  if (!keyword || !location) {
    return (
      <div className="min-h-screen bg-gray-100 py-12">
        <div className="max-w-7xl mx-auto px-4">
          <h1 className="text-2xl font-bold text-red-600 mb-4">Error</h1>
          <p className="text-gray-600">Missing search parameters</p>
          <Link href="/" className="text-blue-600 hover:underline">
            Return to Search
          </Link>
        </div>
      </div>
    );
  }

  return (
    <Suspense fallback={<div>Loading...</div>}>
      <ResultsList keyword={keyword} location={location} />
    </Suspense>
  );
}

async function ResultsList({ keyword, location }: { keyword: string; location: string }): Promise<JSX.Element> {
  const { keyword: k, location: l } = { keyword, location };

  if (!k || !l) {
    return <div>Error: Missing search parameters.</div>;
  }

  const results = await getResults(k, l);

  return (
    <div className="min-h-screen bg-gray-100 py-12">
      <div className="max-w-7xl mx-auto px-4">
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">
            Results for &quot;{k}&quot; in {l}
          </h1>
          <Link href="/" className="text-blue-600 hover:underline">
            New Search
          </Link>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {results.map((place: Place) => (
            <div
              key={place.place_id}
              className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow"
            >
              <h2 className="text-xl font-semibold mb-2">{place.name}</h2>
              <p className="text-gray-600 mb-4">{place.formatted_address}</p>
              {place.rating && (
                <div className="flex items-center mb-2">
                  <span className="text-yellow-400">★</span>
                  <span className="ml-1">
                    {place.rating} ({place.user_ratings_total} reviews)
                  </span>
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
