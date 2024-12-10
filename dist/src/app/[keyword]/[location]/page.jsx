import { searchPlaces } from '@/utils/googlePlaces';
import { parseUrlSegment } from '@/utils/urlHelpers';
import { loadSearchData } from '@/utils/searchData';
import { generateMetaContent, generateStructuredData } from '@/utils/metaContent';
import Breadcrumbs from '@/components/Breadcrumbs';
import { JsonLd } from '@/components/JsonLd';
import CategoryList from '@/components/CategoryList';
export async function generateMetadata({ params }) {
    const keyword = parseUrlSegment(params.keyword);
    const searchData = loadSearchData();
    const locationData = searchData.locations.find(loc => parseUrlSegment(loc.location) === parseUrlSegment(params.location));
    if (!locationData) {
        return {
            title: 'Location Not Found',
            description: 'The requested location was not found.'
        };
    }
    return generateMetaContent(keyword, locationData);
}
export default async function LocationPage({ params, searchParams }) {
    const keyword = parseUrlSegment(params.keyword);
    const searchData = loadSearchData();
    const locationData = searchData.locations.find(loc => parseUrlSegment(loc.location) === parseUrlSegment(params.location));
    if (!locationData) {
        return (<div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold text-red-600">Location Not Found</h1>
        <p className="mt-4">The requested location was not found.</p>
      </div>);
    }
    try {
        const places = await searchPlaces(keyword, `${locationData.location}, ${locationData.county}`);
        const topPlaces = places.slice(0, 10); // Get top 10 results
        // Transform places data for CategoryList component
        const contractors = topPlaces.map(place => ({
            id: place.place_id,
            name: place.name,
            rating: place.rating || 0,
            reviewCount: place.user_ratings_total || 0,
            address: place.formatted_address,
            phone: place.formatted_phone_number,
            website: place.website,
            services: [keyword], // Base service + any additional services from place data
        }));
        // Generate structured data
        const structuredData = generateStructuredData(keyword, locationData);
        structuredData.itemListElement = contractors.map((contractor, index) => ({
            '@type': 'ListItem',
            position: index + 1,
            item: {
                '@type': 'LocalBusiness',
                name: contractor.name,
                address: {
                    '@type': 'PostalAddress',
                    streetAddress: contractor.address
                },
                telephone: contractor.phone,
                url: contractor.website,
                aggregateRating: contractor.rating ? {
                    '@type': 'AggregateRating',
                    ratingValue: contractor.rating,
                    reviewCount: contractor.reviewCount
                } : undefined
            }
        }));
        return (<div className="min-h-screen bg-gray-50">
        <JsonLd data={structuredData}/>
        
        <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Breadcrumbs keyword={keyword} location={locationData.location}/>
          
          <div className="bg-white rounded-lg shadow-sm p-6 mb-8">
            <h1 className="text-3xl font-bold text-gray-900 mb-4">
              The 10 Best {keyword} in {locationData.location}, {locationData.county}
            </h1>
            
            <p className="text-lg text-gray-600 mb-6">
              Compare the top-rated {keyword.toLowerCase()} in {locationData.location}. 
              View detailed profiles, customer reviews, and contact information to find 
              the right professional for your needs.
            </p>

            {/* Quick Stats */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4 p-4 bg-gray-50 rounded-lg mb-8">
              <div className="text-center">
                <div className="text-2xl font-bold text-blue-600">{contractors.length}</div>
                <div className="text-sm text-gray-600">Listed Businesses</div>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-blue-600">
                  {(contractors.reduce((acc, c) => acc + c.rating, 0) / contractors.length).toFixed(1)}
                </div>
                <div className="text-sm text-gray-600">Average Rating</div>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-blue-600">
                  {contractors.reduce((acc, c) => acc + c.reviewCount, 0)}
                </div>
                <div className="text-sm text-gray-600">Total Reviews</div>
              </div>
              <div className="text-center">
                <div className="text-2xl font-bold text-blue-600">{locationData.county}</div>
                <div className="text-sm text-gray-600">Service Area</div>
              </div>
            </div>
          </div>

          {/* Category List */}
          <CategoryList keyword={keyword} location={locationData} contractors={contractors}/>
        </main>
      </div>);
    }
    catch (error) {
        console.error('Error fetching places:', error);
        return (<div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold text-red-600">Error</h1>
        <p className="mt-4">Unable to load contractors. Please try again later.</p>
      </div>);
    }
}
