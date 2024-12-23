'use client';

import React, { useState, FormEvent } from 'react';
import { useRouter } from 'next/navigation';

const SearchBox = (): React.ReactElement => {
  const [keyword, setKeyword] = useState('');
  const [location, setLocation] = useState('Denver, CO');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  const handleSubmit = async (e: FormEvent<HTMLFormElement>): Promise<void> => {
    e.preventDefault();
    setIsLoading(true);
    setError('');

    try {
      const searchLocation = location || 'Denver, CO';
      router.push(`/search/results?keyword=${encodeURIComponent(keyword)}&location=${encodeURIComponent(searchLocation)}`);
    } catch (err) {
      setError('An error occurred while searching. Please try again.');
      console.error('Search error:', err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="w-full max-w-2xl mx-auto">
      <form onSubmit={handleSubmit} className="w-full">
        <div className="flex flex-col md:flex-row gap-4 p-4 bg-white bg-opacity-20 backdrop-blur-lg rounded-2xl shadow-xl">
          <input
            type="text"
            value={keyword}
            onChange={(e) => setKeyword(e.target.value)}
            placeholder="What service are you looking for?"
            className="flex-1 p-4 rounded-xl border-2 border-blue-100 bg-white bg-opacity-90 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-300"
            disabled={isLoading}
          />
          <input
            type="text"
            value={location}
            onChange={(e) => setLocation(e.target.value)}
            placeholder="Enter location (e.g., Denver, CO)"
            className="flex-1 p-4 rounded-xl border-2 border-blue-100 bg-white bg-opacity-90 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:border-transparent transition-all duration-300"
            disabled={isLoading}
          />
          <button
            type="submit"
            className={`px-8 py-4 bg-blue-500 text-white font-semibold rounded-xl hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-2 transform hover:scale-105 transition-all duration-300 shadow-lg ${
              isLoading ? 'opacity-50 cursor-not-allowed' : ''
            }`}
            disabled={isLoading}
          >
            {isLoading ? 'Searching...' : 'Search'}
          </button>
        </div>
        {error && (
          <div className="mt-4 p-4 bg-red-100 text-red-700 rounded-xl">
            {error}
          </div>
        )}
      </form>
    </div>
  );
};

export default SearchBox;
