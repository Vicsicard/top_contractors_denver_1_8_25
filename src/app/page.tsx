import React from 'react';
import SearchBox from '@/components/SearchBox';
import { loadLocations } from '@/utils/searchData';

export default async function Home(): Promise<React.ReactElement> {
  // Test the search functionality
  const testResults = await loadLocations('plumbers');
  console.log('Test search results:', testResults);

  return (
    <main>
      <section className="bg-gradient-to-b from-blue-50 to-white">
        <div className="container mx-auto px-4 py-12">
          <div className="max-w-4xl mx-auto text-center">
            <h1 className="text-4xl md:text-5xl font-bold mb-6 text-gray-900">
              Find Local Contractors in Denver
            </h1>
            <p className="text-xl text-gray-600 mb-8">
              Connect with trusted professionals for your home improvement needs
            </p>
            <div className="bg-white rounded-2xl shadow-soft p-6 transform transition-transform hover:scale-[1.02]">
              <SearchBox />
            </div>
            {testResults.locations.length > 0 && (
              <div className="mt-8 text-left bg-white p-6 rounded-lg shadow">
                <h2 className="text-2xl font-semibold mb-4">Sample Results:</h2>
                <pre className="bg-gray-50 p-4 rounded overflow-auto max-h-96">
                  {JSON.stringify(testResults, null, 2)}
                </pre>
              </div>
            )}
          </div>
        </div>
      </section>
    </main>
  );
}
