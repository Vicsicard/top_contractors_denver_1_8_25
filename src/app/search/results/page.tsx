import { searchPlaces } from '@/utils/googlePlaces';
import SearchBox from '@/components/SearchBox';
import { Suspense } from 'react';

function LoadingState() {
  return (
    <div className="animate-pulse space-y-4">
      <div className="h-4 bg-gray-200 rounded w-3/4"></div>
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {[1, 2, 3].map((i) => (
          <div key={i} className="p-6 bg-gray-100 rounded-lg">
            <div className="h-4 bg-gray-200 rounded w-3/4 mb-4"></div>
            <div className="h-4 bg-gray-200 rounded w-1/2"></div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default async function ResultsPage({
  searchParams
}: {
  searchParams?: { [key: string]: string | string[] | undefined };
}) {
  const keyword = searchParams?.keyword as string;
  const location = searchParams?.location as string;

  if (!keyword || !location) {
    return (
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-2xl font-bold mb-4">Search Results</h1>
        <p>Please provide both keyword and location parameters.</p>
      </div>
    );
  }

  const results = await searchPlaces(keyword, location);

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <SearchBox />
      </div>

      <Suspense fallback={<LoadingState />}>
        <div className="space-y-6">
          <h1 className="text-2xl font-bold">
            Search Results for {keyword} in {location}
          </h1>

          {results.length === 0 ? (
            <p>No results found. Try a different search.</p>
          ) : (
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {results.map((place) => (
                <div
                  key={place.place_id}
                  className="p-6 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow"
                >
                  <h2 className="text-xl font-semibold mb-2">{place.name}</h2>
                  <p className="text-gray-600 mb-4">{place.formatted_address}</p>
                  {place.rating && (
                    <div className="flex items-center mb-2">
                      <span className="text-yellow-400 mr-1">★</span>
                      <span>{place.rating}</span>
                      {place.user_ratings_total && (
                        <span className="text-gray-500 text-sm ml-1">
                          ({place.user_ratings_total} reviews)
                        </span>
                      )}
                    </div>
                  )}
                  {place.opening_hours && (
                    <p className="text-sm text-gray-600">
                      {place.opening_hours.open_now ? 'Open now' : 'Closed'}
                    </p>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </Suspense>
    </div>
  );
}
