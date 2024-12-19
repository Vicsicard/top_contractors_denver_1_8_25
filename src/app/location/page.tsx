import React from 'react';
import { Metadata } from 'next';
import { LocationCategories } from '@/app/components/LocationCategories';

export const metadata: Metadata = {
  title: 'Greater Denver Area Locations | Find Local Contractors',
  description: 'Browse contractors by location in the Greater Denver area. Find trusted local contractors in your neighborhood for your home improvement projects.',
};

export default function LocationsPage() {
  return (
    <div>
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-20">
          <h1 className="text-5xl md:text-6xl font-bold mb-6 text-center">
            Greater Denver Area Locations
          </h1>
          <p className="text-xl mb-8 text-center text-blue-100 max-w-3xl mx-auto">
            Find trusted contractors in your neighborhood. Browse by area to discover local professionals ready to help with your home improvement projects.
          </p>
        </div>
      </div>
      
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <LocationCategories />
      </div>
    </div>
  );
}
