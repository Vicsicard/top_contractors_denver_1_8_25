import React from 'react';
import SearchBox from '@/components/SearchBox';
import Link from 'next/link';
import { FaWrench, FaPaintRoller, FaBolt, FaTree, FaHome, FaTint, FaSnowflake, FaTools } from 'react-icons/fa';

const PopularTrades = [
  { icon: <FaWrench className="w-8 h-8" />, name: "Plumber" },
  { icon: <FaPaintRoller className="w-8 h-8" />, name: "Painter" },
  { icon: <FaBolt className="w-8 h-8" />, name: "Electrician" },
  { icon: <FaTree className="w-8 h-8" />, name: "Landscaper" },
  { icon: <FaHome className="w-8 h-8" />, name: "General Contractor" },
  { icon: <FaTint className="w-8 h-8" />, name: "Roofer" },
  { icon: <FaSnowflake className="w-8 h-8" />, name: "HVAC" },
  { icon: <FaTools className="w-8 h-8" />, name: "Handyman" }
];

const FeaturedLocations = [
  {
    name: "Denver",
    areas: ["Downtown", "Capitol Hill", "Cherry Creek"]
  },
  {
    name: "Aurora",
    areas: ["Central Aurora", "Southlands", "Mission Viejo"]
  },
  {
    name: "Lakewood",
    areas: ["Belmar", "Green Mountain", "Union Square"]
  },
  {
    name: "Arvada",
    areas: ["Olde Town", "West Arvada", "Candelas"]
  },
  {
    name: "Westminster",
    areas: ["The Orchard", "Legacy Ridge", "Westminster Station"]
  },
  {
    name: "Thornton",
    areas: ["Original Thornton", "Eastlake", "North Creek"]
  }
];

export default function Home(): React.ReactElement {
  return (
    <main className="min-h-screen bg-white">
      {/* Hero Section */}
      <section className="bg-gradient-to-b from-emerald-50 to-white py-20">
        <div className="container mx-auto px-4">
          <h1 className="text-5xl md:text-6xl font-bold text-center mb-6">
            Find Skilled Contractors in Denver
          </h1>
          <p className="text-xl text-gray-600 text-center mb-12">
            Connect with reliable local contractors for all your home improvement
            and repair needs.
          </p>
          <div className="max-w-2xl mx-auto">
            <SearchBox />
          </div>
        </div>
      </section>

      {/* Popular Trades Section */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12">Popular Trades</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {PopularTrades.map((trade, index) => (
              <Link 
                href={`/search/results?keyword=${trade.name}&location=Denver`} 
                key={index}
                className="bg-emerald-50 hover:bg-emerald-100 p-6 rounded-lg text-center transition-colors duration-200"
              >
                <div className="flex flex-col items-center space-y-4">
                  <span className="text-emerald-600">{trade.icon}</span>
                  <span className="text-lg font-medium">{trade.name}</span>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Featured Locations Section */}
      <section className="py-16 bg-gray-50">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12">Featured Locations</h2>
          <div className="grid md:grid-cols-3 gap-8">
            {FeaturedLocations.map((location, index) => (
              <div key={index} className="bg-white p-6 rounded-lg shadow-sm">
                <h3 className="text-2xl font-bold mb-4">{location.name}</h3>
                <ul className="space-y-2">
                  {location.areas.map((area, areaIndex) => (
                    <li key={areaIndex} className="flex items-center space-x-2">
                      <svg className="w-5 h-5 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                      </svg>
                      <span className="text-gray-600">{area}</span>
                    </li>
                  ))}
                </ul>
                <Link 
                  href={`/search/results?location=${location.name},CO`}
                  className="text-emerald-600 hover:text-emerald-700 mt-4 inline-block"
                >
                  View all in {location.name}
                </Link>
              </div>
            ))}
          </div>
        </div>
      </section>
    </main>
  );
}
