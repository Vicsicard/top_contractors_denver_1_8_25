import React from 'react';
import Link from 'next/link';
import SearchBox from '@/components/SearchBox';
import { 
  FaWrench,
  FaBolt,
  FaHammer,
  FaPaintRoller,
  FaTools,
  FaFan,
  FaHome,
  FaBath,
  FaUtensils,
  FaLayerGroup,
  FaSquare,
  FaBorderAll,
  FaWindowMaximize,
  FaTree,
  FaGripLines
} from 'react-icons/fa';

const PopularTrades = [
  { name: 'Plumber', Icon: FaWrench },
  { name: 'Electrician', Icon: FaBolt },
  { name: 'HVAC', Icon: FaFan },
  { name: 'Roofer', Icon: FaHome },
  { name: 'Carpenter', Icon: FaHammer },
  { name: 'Painter', Icon: FaPaintRoller },
  { name: 'Landscaper', Icon: FaTree },
  { name: 'Home Remodeling', Icon: FaTools },
  { name: 'Bathroom Remodeling', Icon: FaBath },
  { name: 'Kitchen Remodeling', Icon: FaUtensils },
  { name: 'Siding & Gutters', Icon: FaHome },
  { name: 'Masonry', Icon: FaLayerGroup },
  { name: 'Decks', Icon: FaSquare },
  { name: 'Flooring', Icon: FaBorderAll },
  { name: 'Windows', Icon: FaWindowMaximize },
  { name: 'Fencing', Icon: FaGripLines }
];

const FeaturedLocations = [
  'Denver',
  'Aurora',
  'Lakewood',
  'Arvada',
  'Westminster',
  'Thornton',
  'Centennial'
];

export default function Home() {
  return (
    <main className="min-h-screen bg-white">
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-24">
          <h1 className="text-5xl md:text-6xl font-bold mb-8 text-center">
            Find Trusted Local Contractors in Denver
          </h1>
          <p className="text-xl mb-12 text-center text-blue-100">
            Connect with verified contractors for your home improvement needs
          </p>
          <div className="max-w-2xl mx-auto">
            <SearchBox />
          </div>
        </div>
      </div>

      <section className="py-20">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12 text-blue-900">Popular Trades</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {PopularTrades.map((trade, index) => {
              const IconComponent = trade.Icon;
              return (
                <Link 
                  href={`/trade/${encodeURIComponent(trade.name)}`}
                  key={index}
                  className="flex items-center p-6 bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 hover:scale-[1.02] border border-gray-100"
                >
                  <div className="bg-blue-100 p-3 rounded-lg mr-4">
                    <IconComponent className="w-8 h-8 text-blue-600" />
                  </div>
                  <span className="text-lg font-medium text-gray-800">{trade.name}</span>
                </Link>
              );
            })}
          </div>
        </div>
      </section>

      <section className="bg-gradient-to-br from-gray-50 to-blue-50 py-20">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12 text-blue-900">Featured Locations</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {FeaturedLocations.map((location, index) => (
              <Link
                href={`/location/${encodeURIComponent(location)}`}
                key={index}
                className="text-center p-6 bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 hover:scale-[1.02] border border-gray-100"
              >
                <span className="text-lg font-medium text-gray-800">{location}</span>
              </Link>
            ))}
          </div>
        </div>
      </section>

      <section className="py-20 bg-gradient-to-br from-blue-900 via-blue-800 to-blue-900 text-white">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12 text-center">Why Choose Our Platform?</h2>
          <div className="grid md:grid-cols-3 gap-12">
            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Verified Contractors</h3>
              <p className="text-blue-100">All contractors are thoroughly vetted and verified for your peace of mind</p>
            </div>
            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Free to Use</h3>
              <p className="text-blue-100">No fees or charges to find and contact quality contractors</p>
            </div>
            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Local Experts</h3>
              <p className="text-blue-100">Connect with experienced contractors right in your neighborhood</p>
            </div>
          </div>
        </div>
      </section>
    </main>
  );
}
