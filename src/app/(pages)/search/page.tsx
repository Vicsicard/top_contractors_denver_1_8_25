import SearchBox from '@/components/SearchBox';
import { FC } from 'react';

const SearchPage: FC = () => {
  return (
    <main className="min-h-screen bg-gray-100 py-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h1 className="text-4xl font-bold text-gray-900 mb-8">
            Find Top Contractors in Denver
          </h1>
          <SearchBox />
        </div>
      </div>
    </main>
  );
}

export default SearchPage;
