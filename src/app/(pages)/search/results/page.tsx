import { Suspense, ReactElement } from 'react';
import Link from 'next/link';
import type { Metadata } from 'next';

interface Place {
  place_id: string;
  name: string;
  formatted_address: string;
  rating?: number;
  user_ratings_total?: number;
  opening_hours?: { open_now: boolean };
}

async function getResults(keyword: string, location: string): Promise<Place[]> {
  try {
    const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3004';
    const url = `${baseUrl}/api/search/places?keyword=${encodeURIComponent(keyword)}&location=${encodeURIComponent(location)}`;
    console.log(`Fetching results from: ${url}`);
    const res = await fetch(url, { cache: 'no-store' });
    
    if (!res.ok) {
      const errorData = await res.json();
      throw new Error(errorData.error || 'Failed to fetch results');
    }
    
    const data = await res.json();
    return data.results || [];
  } catch (error) {
    console.error('Search error:', error);
    return [];
  }
}

export const metadata: Metadata = {
  title: 'Search Results - Denver Contractors',
  description: 'Find the best contractors in Denver for your project',
};

interface PageProps {
  params: Promise<Record<string, never>>;
  searchParams: Promise<{
    keyword?: string;
    location?: string;
    [key: string]: string | undefined;
  }>;
}

export default async function ResultsPage({ searchParams }: PageProps): Promise<ReactElement> {
  const params = await searchParams;
  const keyword = typeof params.keyword === 'string' ? params.keyword : '';
  const location = typeof params.location === 'string' ? params.location : '';

  if (!keyword || !location) {
    return (
      <div className="min-h-screen bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="text-center">
            <h1 className="text-3xl font-extrabold text-gray-900 sm:text-4xl">
              Search Parameters Required
            </h1>
            <p className="mt-3 text-xl text-gray-500 sm:mt-4">
              Please provide both a keyword and location to search for contractors.
            </p>
            <div className="mt-5">
              <Link
                href="/"
                className="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700"
              >
                Back to Search
              </Link>
            </div>
          </div>
        </div>
      </div>
    );
  }

  try {
    const results = await getResults(keyword, location);

    return (
      <div className="min-h-screen bg-gray-100">
        <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <h1 className="text-3xl font-extrabold text-gray-900 sm:text-4xl">
              Search Results
            </h1>
            <p className="mt-3 text-xl text-gray-500">
              Showing results for &quot;{keyword}&quot; in {location}
            </p>
            <Link
              href="/"
              className="mt-4 inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-indigo-700 bg-indigo-100 hover:bg-indigo-200"
            >
              New Search
            </Link>
          </div>

          <Suspense
            fallback={
              <div className="text-center">
                <div className="inline-block h-8 w-8 animate-spin rounded-full border-4 border-solid border-current border-r-transparent align-[-0.125em] motion-reduce:animate-[spin_1.5s_linear_infinite]">
                  <span className="!absolute !-m-px !h-px !w-px !overflow-hidden !whitespace-nowrap !border-0 !p-0 ![clip:rect(0,0,0,0)]">
                    Loading...
                  </span>
                </div>
              </div>
            }
          >
            <ResultsList keyword={keyword} location={location} results={results} />
          </Suspense>
        </div>
      </div>
    );
  } catch (error) {
    console.error(error);
    return (
      <div className="min-h-screen bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          <div className="text-center">
            <h1 className="text-3xl font-extrabold text-gray-900 sm:text-4xl">
              Error
            </h1>
            <p className="mt-3 text-xl text-gray-500 sm:mt-4">
              An error occurred while fetching search results.
            </p>
            <div className="mt-5">
              <Link
                href="/"
                className="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700"
              >
                Back to Search
              </Link>
            </div>
          </div>
        </div>
      </div>
    );
  }
};

interface ResultsListProps {
  keyword: string;
  location: string;
  results: Place[];
}

async function ResultsList(props: ResultsListProps): Promise<ReactElement> {
  if (!props.results || props.results.length === 0) {
    return (
      <div className="text-center">
        <h2 className="text-lg font-medium text-gray-900">No Results Found</h2>
        <p className="mt-1 text-sm text-gray-500">
          Try adjusting your search criteria or location
        </p>
      </div>
    );
  }

  return (
    <div>
      <div className="mb-6">
        <h2 className="text-lg font-medium text-gray-900">
          Found {props.results.length} contractors
        </h2>
      </div>

      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {props.results.map((place: Place) => (
          <div
            key={place.place_id}
            className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow"
          >
            <h3 className="text-lg font-medium text-gray-900">{place.name}</h3>
            <p className="mt-1 text-sm text-gray-500">
              {place.formatted_address}
            </p>
            {place.rating && (
              <div className="mt-2">
                <span className="text-sm font-medium text-gray-900">
                  Rating: {place.rating}
                </span>
                {place.user_ratings_total && (
                  <span className="ml-1 text-sm text-gray-500">
                    ({place.user_ratings_total} reviews)
                  </span>
                )}
              </div>
            )}
            {place.opening_hours && (
              <p className="mt-2 text-sm text-gray-500">
                {place.opening_hours.open_now ? 'Open now' : 'Closed'}
              </p>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
