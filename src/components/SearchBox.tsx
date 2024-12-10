'use client';

import { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { Location } from '@/utils/searchData';
import { getPlacesData } from '@/utils/placesApi';

interface SearchBoxProps {
  initialKeywords: string[];
  initialLocations: Location[];
}

export default function SearchBox({ initialKeywords, initialLocations }: SearchBoxProps) {
  const router = useRouter();
  const [keywordQuery, setKeywordQuery] = useState('');
  const [locationQuery, setLocationQuery] = useState('');
  const [showKeywordSuggestions, setShowKeywordSuggestions] = useState(false);
  const [showLocationSuggestions, setShowLocationSuggestions] = useState(false);
  const [selectedKeyword, setSelectedKeyword] = useState('');
  const [selectedLocation, setSelectedLocation] = useState('');

  const keywordRef = useRef<HTMLDivElement>(null);
  const locationRef = useRef<HTMLDivElement>(null);

  // Filter suggestions based on input
  const keywordSuggestions = initialKeywords.filter(keyword =>
    keyword.toLowerCase().includes(keywordQuery.toLowerCase())
  );

  const locationSuggestions = initialLocations.filter(location =>
    location.location.toLowerCase().includes(locationQuery.toLowerCase()) ||
    location.county.toLowerCase().includes(locationQuery.toLowerCase())
  );

  // Handle clicks outside suggestion boxes
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (keywordRef.current && !keywordRef.current.contains(event.target as Node)) {
        setShowKeywordSuggestions(false);
      }
      if (locationRef.current && !locationRef.current.contains(event.target as Node)) {
        setShowLocationSuggestions(false);
      }
    }

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // Handle search submission
  const handleSearch = () => {
    if (selectedKeyword && selectedLocation) {
      const keywordSlug = selectedKeyword.toLowerCase().replace(/\s+/g, '-');
      const locationSlug = selectedLocation.toLowerCase().replace(/\s+/g, '-');
      router.push(`/${keywordSlug}/${locationSlug}`);
    }
  };

  return (
    <div className="w-full max-w-2xl mx-auto">
      <div className="flex flex-col md:flex-row gap-4">
        {/* Keyword Search */}
        <div className="relative flex-1" ref={keywordRef}>
          <label htmlFor="keyword-search" className="block text-sm font-medium text-gray-700 mb-1">
            Service Type
          </label>
          <input
            id="keyword-search"
            type="text"
            value={keywordQuery}
            onChange={(e) => {
              setKeywordQuery(e.target.value);
              setShowKeywordSuggestions(true);
              setSelectedKeyword('');
            }}
            placeholder="e.g., Plumbers"
            className="w-full px-4 py-2 border rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            aria-label="Search for service type"
          />
          {showKeywordSuggestions && keywordSuggestions.length > 0 && (
            <ul className="absolute z-10 w-full mt-1 bg-white border rounded-md shadow-lg max-h-60 overflow-auto">
              {keywordSuggestions.map((keyword) => (
                <li
                  key={keyword}
                  className="px-4 py-2 hover:bg-gray-100 cursor-pointer"
                  onClick={() => {
                    setKeywordQuery(keyword);
                    setSelectedKeyword(keyword);
                    setShowKeywordSuggestions(false);
                  }}
                >
                  {keyword}
                </li>
              ))}
            </ul>
          )}
        </div>

        {/* Location Search */}
        <div className="relative flex-1" ref={locationRef}>
          <label htmlFor="location-search" className="block text-sm font-medium text-gray-700 mb-1">
            Location
          </label>
          <input
            id="location-search"
            type="text"
            value={locationQuery}
            onChange={(e) => {
              setLocationQuery(e.target.value);
              setShowLocationSuggestions(true);
              setSelectedLocation('');
            }}
            placeholder="e.g., Denver"
            className="w-full px-4 py-2 border rounded-md focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            aria-label="Search for location"
          />
          {showLocationSuggestions && locationSuggestions.length > 0 && (
            <ul className="absolute z-10 w-full mt-1 bg-white border rounded-md shadow-lg max-h-60 overflow-auto">
              {locationSuggestions.map((location) => (
                <li
                  key={location.location}
                  className="px-4 py-2 hover:bg-gray-100 cursor-pointer"
                  onClick={() => {
                    setLocationQuery(location.location);
                    setSelectedLocation(location.location);
                    setShowLocationSuggestions(false);
                  }}
                >
                  <span>{location.location}</span>
                  <span className="text-sm text-gray-500 ml-2">({location.county})</span>
                </li>
              ))}
            </ul>
          )}
        </div>

        {/* Search Button */}
        <button
          onClick={handleSearch}
          disabled={!selectedKeyword || !selectedLocation}
          className="px-6 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:bg-gray-400 disabled:cursor-not-allowed md:self-end"
          aria-label="Search for contractors"
        >
          Search
        </button>
      </div>
    </div>
  );
}
