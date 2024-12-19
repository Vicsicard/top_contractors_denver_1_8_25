import React from 'react';
import { Metadata } from 'next';
import { FaWarehouse } from 'react-icons/fa';
import SearchResults from '@/app/components/SearchResults';

export const metadata: Metadata = {
  title: 'Epoxy Garage Contractors in Denver | Professional Garage Floor Solutions',
  description: 'Find top-rated epoxy garage floor contractors in Denver. Get durable, attractive, and long-lasting garage flooring solutions from local professionals.',
};

export default function EpoxyGaragePage() {
  return (
    <div className="min-h-screen bg-white">
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-24">
          <div className="flex items-center justify-center mb-6">
            <FaWarehouse className="w-16 h-16 text-blue-100" />
          </div>
          <h1 className="text-5xl md:text-6xl font-bold mb-6 text-center">
            Epoxy Garage Contractors
          </h1>
          <p className="text-xl mb-8 text-center text-blue-100 max-w-3xl mx-auto">
            Transform your garage with professional epoxy flooring. Our verified contractors provide durable, 
            attractive, and long-lasting garage floor solutions.
          </p>
          <div className="max-w-2xl mx-auto bg-white/10 backdrop-blur-sm rounded-lg p-6">
            <div className="space-y-4 text-center text-blue-100">
              <h2 className="text-2xl font-semibold">Why Choose Professional Epoxy Flooring?</h2>
              <ul className="text-lg space-y-2">
                <li>✓ Durable and long-lasting finish</li>
                <li>✓ Chemical and stain resistant</li>
                <li>✓ Easy to clean and maintain</li>
                <li>✓ Enhances garage appearance</li>
                <li>✓ Increases property value</li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <div className="container mx-auto px-4 py-12">
        <SearchResults 
          searchQuery="epoxy garage contractors"
          location="Denver, CO"
          showSearchBox={true}
        />
      </div>
    </div>
  );
}
