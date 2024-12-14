import { searchPlaces } from '@/utils/googlePlaces';
import SearchBox from '@/components/SearchBox';
import { Suspense } from 'react';
import { PageProps } from '@/types/routes';

export const dynamic = 'force-dynamic';

interface Place {
  place_id: string;
  name: string;
  formatted_address: string;
  rating?: number;
  user_ratings_total?: number;
  categories?: string[];
  phone?: string;
  website?: string;
}

async function getResults(keyword: string, location: string): Promise<Place[]> {
  const response = await searchPlaces(keyword, location);
  return response.results;
}

function LoadingState(): JSX.Element {
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

export default async function SearchPage({ params }: PageProps): Promise<JSX.Element> {
  const { keyword, location } = await params;
  console.log('Search page params:', { keyword, location });
  
  const decodedKeyword = decodeURIComponent(keyword);
  const decodedLocation = decodeURIComponent(location);
  console.log('Decoded params:', { decodedKeyword, decodedLocation });

  try {
    const results = await getResults(decodedKeyword, decodedLocation);
    console.log('Search results:', { count: results.length });

    return (
      <main className="container mx-auto px-4 py-8">
        <SearchBox />
        
        <Suspense fallback={<LoadingState />}>
          <div className="mt-8">
            <h1 className="text-2xl font-bold mb-4">
              Results for {decodedKeyword} in {decodedLocation}
            </h1>
            
            {results.length === 0 ? (
              <p className="text-gray-600">
                No results found. Please try a different search.
              </p>
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
                      <div className="mb-2">
                        <span className="text-yellow-500">★</span>
                        <span className="ml-1">{place.rating}</span>
                        {place.user_ratings_total && (
                          <span className="text-gray-500 text-sm ml-1">
                            ({place.user_ratings_total} reviews)
                          </span>
                        )}
                      </div>
                    )}
                    
                    {place.categories && place.categories.length > 0 && (
                      <div className="mb-4">
                        {place.categories.map((category) => (
                          <span
                            key={category}
                            className="inline-block bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded mr-2 mb-2"
                          >
                            {category}
                          </span>
                        ))}
                      </div>
                    )}
                    
                    <div className="space-y-2">
                      {place.phone && (
                        <p className="text-gray-600">
                          <span className="font-medium">Phone:</span>{' '}
                          <a href={`tel:${place.phone}`} className="text-blue-600 hover:underline">
                            {place.phone}
                          </a>
                        </p>
                      )}
                      
                      {place.website && (
                        <p className="text-gray-600">
                          <span className="font-medium">Website:</span>{' '}
                          <a
                            href={place.website}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-blue-600 hover:underline"
                          >
                            Visit Website
                          </a>
                        </p>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </Suspense>
      </main>
    );
  } catch (error) {
    console.error('Search error:', error);
    return (
      <main className="container mx-auto px-4 py-8">
        <SearchBox />
        <div className="mt-8">
          <div className="p-4 bg-red-50 text-red-600 rounded-lg">
            An error occurred while searching. Please try again.
          </div>
        </div>
      </main>
    );
  }
}
