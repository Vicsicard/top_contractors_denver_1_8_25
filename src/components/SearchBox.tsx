'use client';

import { useState, useRef, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { parseUrlSegment } from '@/utils/urlHelpers';
import type { SearchData } from '@/utils/searchData';

export default function SearchBox(): JSX.Element {
  const [keyword, setKeyword] = useState('');
  const [location, setLocation] = useState('');
  const [showKeywordSuggestions, setShowKeywordSuggestions] = useState(false);
  const [showLocationSuggestions, setShowLocationSuggestions] = useState(false);
  const [keywordSuggestions, setKeywordSuggestions] = useState<string[]>([]);
  const [locationSuggestions, setLocationSuggestions] = useState<string[]>([]);
  const [searchData, setSearchData] = useState<SearchData | null>(null);
  const [error, setError] = useState<string | null>(null);
  const keywordRef = useRef<HTMLDivElement>(null);
  const locationRef = useRef<HTMLDivElement>(null);
  const router = useRouter();

  useEffect((): void => {
    const fetchData = async (): Promise<void> => {
      try {
        const response = await fetch('/api/search');
        if (!response.ok) {
          throw new Error('Failed to fetch search data');
        }
        const data = await response.json();
        setSearchData(data);
      } catch (error) {
        console.error('Error fetching search data:', error);
        setError('Failed to load search data. Please try again later.');
      }
    };
    void fetchData();
  }, []);

  useEffect((): (() => void) => {
    const handleOutsideClick = (event: MouseEvent): void => {
      if (keywordRef.current && !keywordRef.current.contains(event.target as Node)) {
        setShowKeywordSuggestions(false);
      }
      if (locationRef.current && !locationRef.current.contains(event.target as Node)) {
        setShowLocationSuggestions(false);
      }
    };

    document.addEventListener('mousedown', handleOutsideClick);
    return () => document.removeEventListener('mousedown', handleOutsideClick);
  }, []);

  const handleKeywordChange = (value: string): void => {
    setKeyword(value);
    if (searchData) {
      const suggestions = searchData.keywords.filter(k => 
        k.toLowerCase().includes(value.toLowerCase())
      );
      setKeywordSuggestions(suggestions);
      setShowKeywordSuggestions(true);
    }
  };

  const handleLocationChange = (value: string): void => {
    setLocation(value);
    if (searchData) {
      const suggestions = searchData.locations
        .map(l => l.location)
        .filter(l => l.toLowerCase().includes(value.toLowerCase()));
      setLocationSuggestions(suggestions);
      setShowLocationSuggestions(true);
    }
  };

  const handleSubmit = (e: React.FormEvent): void => {
    e.preventDefault();
    if (keyword && location) {
      const urlKeyword = parseUrlSegment(keyword);
      const urlLocation = parseUrlSegment(location);
      router.push(`/${urlKeyword}/${urlLocation}`);
    }
  };

  if (!searchData && !error) {
    return (
      <div className="space-y-4">
        <div className="w-full h-10 bg-gray-200 animate-pulse rounded"></div>
        <div className="w-full h-10 bg-gray-200 animate-pulse rounded"></div>
        <div className="w-full h-10 bg-gray-200 animate-pulse rounded"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="space-y-4">
        <p className="text-red-500">{error}</p>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="relative" ref={keywordRef}>
        <input
          type="text"
          value={keyword}
          onChange={(e) => handleKeywordChange(e.target.value)}
          placeholder="What service do you need?"
          className="w-full p-2 border rounded"
        />
        {showKeywordSuggestions && keywordSuggestions.length > 0 && (
          <ul className="absolute z-10 w-full bg-white border rounded mt-1">
            {keywordSuggestions.map((suggestion) => (
              <li
                key={suggestion}
                onClick={() => {
                  setKeyword(suggestion);
                  setShowKeywordSuggestions(false);
                }}
                className="p-2 hover:bg-gray-100 cursor-pointer"
              >
                {suggestion}
              </li>
            ))}
          </ul>
        )}
      </div>

      <div className="relative" ref={locationRef}>
        <input
          type="text"
          value={location}
          onChange={(e) => handleLocationChange(e.target.value)}
          placeholder="Enter location"
          className="w-full p-2 border rounded"
        />
        {showLocationSuggestions && locationSuggestions.length > 0 && (
          <ul className="absolute z-10 w-full bg-white border rounded mt-1">
            {locationSuggestions.map((suggestion) => (
              <li
                key={suggestion}
                onClick={() => {
                  setLocation(suggestion);
                  setShowLocationSuggestions(false);
                }}
                className="p-2 hover:bg-gray-100 cursor-pointer"
              >
                {suggestion}
              </li>
            ))}
          </ul>
        )}
      </div>

      <button
        type="submit"
        disabled={!keyword || !location}
        className="w-full bg-blue-500 text-white p-2 rounded disabled:bg-gray-300"
      >
        Search
      </button>
    </form>
  );
}
