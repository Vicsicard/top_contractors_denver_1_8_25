import { loadSearchData } from '@/utils/searchData';
import SearchBox from '@/components/SearchBox';
export default function Home() {
    const searchData = loadSearchData();
    return (<main className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="text-center mb-12">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">
            Find Trusted Contractors in Denver
          </h1>
          <p className="text-xl text-gray-600">
            Connect with qualified professionals for your home improvement needs
          </p>
        </div>

        <div className="bg-white p-6 rounded-lg shadow-sm">
          <SearchBox initialKeywords={searchData.keywords} initialLocations={searchData.locations}/>
        </div>

        {/* Popular Services Section */}
        <div className="mt-16">
          <h2 className="text-2xl font-semibold text-gray-900 mb-6">
            Popular Services
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
            {searchData.keywords.slice(0, 8).map((keyword) => (<div key={keyword} className="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow">
                <h3 className="font-medium text-gray-900">{keyword}</h3>
              </div>))}
          </div>
        </div>

        {/* Service Areas Section */}
        <div className="mt-16">
          <h2 className="text-2xl font-semibold text-gray-900 mb-6">
            Service Areas
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
            {searchData.locations.slice(0, 8).map((location) => (<div key={location.location} className="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow">
                <h3 className="font-medium text-gray-900">{location.location}</h3>
                <p className="text-sm text-gray-500">{location.county}</p>
              </div>))}
          </div>
        </div>
      </div>
    </main>);
}
