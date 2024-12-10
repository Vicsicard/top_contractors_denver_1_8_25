import { Metadata } from 'next';
import { searchPlaces } from '@/utils/googlePlaces';
import Breadcrumbs from '@/components/Breadcrumbs';
import Header from '@/components/Header';
import Footer from '@/components/Footer';

interface PageProps {
  params: {
    keyword: string;
    location: string;
  };
  searchParams: {
    page?: string;
  };
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const keyword = decodeURIComponent(params.keyword);
  const location = decodeURIComponent(params.location);
  
  return {
    title: `The 10 Best ${keyword} in ${location}`,
    description: `Discover the top-rated ${keyword} in ${location}, including contact details and reviews.`,
  };
}

export default async function LocationPage({ params, searchParams }: PageProps) {
  const keyword = decodeURIComponent(params.keyword);
  const location = decodeURIComponent(params.location);
  const currentPage = Number(searchParams.page) || 1;
  const resultsPerPage = 10;

  try {
    const places = await searchPlaces(keyword, location);
    const totalPages = Math.ceil(places.length / resultsPerPage);
    const startIndex = (currentPage - 1) * resultsPerPage;
    const paginatedPlaces = places.slice(startIndex, startIndex + resultsPerPage);

    return (
      <>
        <Header />
        <main className="container mx-auto px-4 py-8">
          <Breadcrumbs keyword={keyword} location={location} />
          
          <h1 className="text-3xl font-bold mb-6">
            The Best {keyword} in {location}
          </h1>
          
          <div className="space-y-6">
            {paginatedPlaces.map((place, index) => (
              <div key={place.place_id} className="border rounded-lg p-6 shadow-sm">
                <h2 className="text-xl font-semibold mb-2">
                  {index + 1}. {place.name}
                </h2>
                <p className="text-gray-600 mb-2">{place.formatted_address}</p>
                {place.rating && (
                  <div className="flex items-center text-sm text-gray-500">
                    <span className="mr-2">Rating: {place.rating}</span>
                    <span>({place.user_ratings_total} reviews)</span>
                  </div>
                )}
              </div>
            ))}
          </div>

          {totalPages > 1 && (
            <div className="flex justify-center space-x-2 mt-8">
              {Array.from({ length: totalPages }, (_, i) => i + 1).map((pageNum) => (
                <a
                  key={pageNum}
                  href={`/${params.keyword}/${params.location}?page=${pageNum}`}
                  className={`px-4 py-2 rounded ${
                    currentPage === pageNum
                      ? 'bg-blue-500 text-white'
                      : 'bg-gray-200 hover:bg-gray-300'
                  }`}
                >
                  {pageNum}
                </a>
              ))}
            </div>
          )}
        </main>
        <Footer />
      </>
    );
  } catch (error) {
    console.error('Error fetching places:', error);
    return (
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-6">Error</h1>
        <p>Sorry, we couldn't load the results. Please try again later.</p>
      </div>
    );
  }
}