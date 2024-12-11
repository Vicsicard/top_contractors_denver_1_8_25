import React from 'react';
import type { Metadata } from 'next';
import SearchBox from '@/components/SearchBox';

export const metadata: Metadata = {
  title: 'Denver Contractors - Find Local Contractors in Denver',
  description: 'Find trusted local contractors in Denver and surrounding areas. Get connected with skilled professionals for your home improvement and construction needs.',
};

export default function Home(): React.ReactElement {
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
          </div>
        </div>
      </section>
    </main>
  );
}
