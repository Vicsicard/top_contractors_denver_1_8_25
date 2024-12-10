import { loadSearchData } from '@/utils/searchData';
import SearchBox from '@/components/SearchBox';

export default function Home() {
  const searchData = loadSearchData();

  return (
    <main className="min-h-screen bg-neutral-50">
      {/* Hero Section */}
      <section className="relative bg-primary-900 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="py-20 md:py-28 lg:py-32">
            <div className="max-w-3xl">
              <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold tracking-tight mb-6">
                Find Trusted Contractors in Denver
              </h1>
              <p className="text-xl md:text-2xl text-primary-100 mb-12">
                Connect with qualified professionals for your home improvement needs
              </p>
              
              {/* Search Box with elevated design */}
              <div className="bg-white rounded-2xl shadow-soft p-6 transform transition-transform hover:scale-[1.02]">
                <SearchBox
                  initialKeywords={searchData.keywords}
                  initialLocations={searchData.locations}
                />
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Content Sections */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 space-y-16">
        {/* Popular Services Section */}
        <section>
          <h2 className="text-2xl md:text-3xl font-semibold text-neutral-900 mb-8">
            Popular Services
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {searchData.keywords.slice(0, 8).map((keyword) => (
              <div
                key={keyword}
                className="p-6 bg-white rounded-xl shadow-soft hover:shadow-lg transition-shadow duration-300"
              >
                <h3 className="font-medium text-neutral-900">{keyword}</h3>
              </div>
            ))}
          </div>
        </section>

        {/* Service Areas Section */}
        <section>
          <h2 className="text-2xl md:text-3xl font-semibold text-neutral-900 mb-8">
            Service Areas
          </h2>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {searchData.locations.slice(0, 8).map((location) => (
              <div
                key={location.location}
                className="p-6 bg-white rounded-xl shadow-soft hover:shadow-lg transition-shadow duration-300"
              >
                <h3 className="font-medium text-neutral-900 mb-1">
                  {location.location}
                </h3>
                <p className="text-sm text-neutral-500">{location.county}</p>
              </div>
            ))}
          </div>
        </section>
      </div>
    </main>
  );
}
