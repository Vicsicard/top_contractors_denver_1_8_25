import React from 'react';
import Link from 'next/link';
import SearchBox from '@/components/SearchBox';
import InquiryForm from '@/components/InquiryForm';
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
  FaGripLines,
  FaWarehouse,
  FaPhone
} from 'react-icons/fa';

const PopularTrades = [
  { name: 'Plumber', Icon: FaWrench, route: 'plumbers' },
  { name: 'Electrician', Icon: FaBolt, route: 'electricians' },
  { name: 'HVAC', Icon: FaFan, route: 'hvac' },
  { name: 'Roofer', Icon: FaHome, route: 'roofers' },
  { name: 'Carpenter', Icon: FaHammer, route: 'carpenters' },
  { name: 'Painter', Icon: FaPaintRoller, route: 'painters' },
  { name: 'Landscaper', Icon: FaTree, route: 'landscapers' },
  { name: 'Home Remodeling', Icon: FaTools, route: 'home-remodeling' },
  { name: 'Bathroom Remodeling', Icon: FaBath, route: 'bathroom-remodeling' },
  { name: 'Kitchen Remodeling', Icon: FaUtensils, route: 'kitchen-remodeling' },
  { name: 'Siding & Gutters', Icon: FaHome, route: 'siding-and-gutters' },
  { name: 'Masonry', Icon: FaLayerGroup, route: 'masonry' },
  { name: 'Decks', Icon: FaSquare, route: 'decks' },
  { name: 'Flooring', Icon: FaBorderAll, route: 'flooring' },
  { name: 'Windows', Icon: FaWindowMaximize, route: 'windows' },
  { name: 'Fencing', Icon: FaGripLines, route: 'fencing' },
  { name: 'Epoxy Garage', Icon: FaWarehouse, route: 'epoxy-garage' }
];

const LocationCategories = {
  'Central Denver Neighborhoods': {
    'Downtown Area': ['Downtown Denver', 'Capitol Hill', 'Union Station', 'Five Points'],
    'Central Parks': ['City Park', 'City Park West', 'Cheesman Park', 'Congress Park'],
    'Central Shopping': ['Cherry Creek', 'Lincoln Park', 'North Capitol Hill']
  },
  'East Denver Neighborhoods': {
    'Park Hill Area': ['Park Hill', 'North Park Hill', 'Northeast Park Hill', 'South Park Hill'],
    'Northeast Area': ['Stapleton (Central Park)', 'Montbello', 'Green Valley Ranch', 'Gateway – Green Valley Ranch'],
    'East Colfax Area': ['East Colfax', 'Skyland']
  },
  'Denver Suburbs': {
    'Northwest Suburbs': ['Westminster', 'Arvada', 'Wheat Ridge', 'Edgewater', 'Golden'],
    'Northeast Suburbs': ['Thornton', 'Northglenn', 'Brighton', 'Commerce City'],
    'Southeast Suburbs': ['Centennial', 'Highlands Ranch', 'Parker', 'Lone Tree', 'Greenwood Village'],
    'Southwest Suburbs': ['Littleton', 'Englewood']
  },
  'Boulder & Surrounding Areas': {
    'Boulder Area': ['Boulder', 'Lafayette', 'Louisville', 'Superior']
  },
  'Outer Surrounding Cities': {
    'Extended Service Area': ['Aurora', 'Castle Rock', 'Loveland']
  }
};

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
          <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
            {PopularTrades.map((trade, index) => {
              const IconComponent = trade.Icon;
              return (
                <Link 
                  href={`/${trade.route}`}
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
          {Object.entries(LocationCategories).map(([regionName, neighborhoods]) => (
            <div key={regionName} className="mb-24 last:mb-0">
              <h2 className="text-4xl font-bold mb-12 text-gray-800 border-b pb-4">{regionName}</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                {Object.entries(neighborhoods).map(([areaName, locations]) => (
                  <div key={areaName} className="bg-white rounded-xl shadow-md p-6 border border-gray-100 hover:shadow-lg transition-shadow duration-300">
                    <h3 className="text-xl font-semibold mb-4 text-gray-800 pb-2 border-b">{areaName}</h3>
                    <ul className="space-y-2">
                      {locations.map((location) => (
                        <li key={location}>
                          <Link
                            href={`/location/${encodeURIComponent(location.toLowerCase().replace(/[^a-zA-Z0-9]+/g, '-'))}`}
                            className="text-blue-600 hover:text-blue-800 hover:underline block py-1"
                          >
                            {location}
                          </Link>
                        </li>
                      ))}
                    </ul>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="py-20 bg-white">
        {/* 
          ⚠️ IMPORTANT - DO NOT MODIFY ⚠️
          Popular Trades Section is finalized and locked.
          This section has been optimized for:
          - UI/UX consistency
          - Google Places API integration
          - Performance and SEO
          - User conversion
          DO NOT change the format, layout, or styling of this section.
          Any modifications must be approved by the project owner.
        */}
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12 text-blue-900">Why Choose Our Platform?</h2>
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
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Fast Response</h3>
              <p className="text-blue-100">Get quick responses from available contractors in your area</p>
            </div>

            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 8h2a2 2 0 012 2v6a2 2 0 01-2 2h-2v4l-4-4H9a1.994 1.994 0 01-1.414-.586m0 0L11 14h4a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2v4l.586-.586z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Free Consultation</h3>
              <p className="text-blue-100">Get expert advice and estimates at no cost to you</p>
            </div>
          </div>
        </div>
      </section>

      <section id="contact-form" className="py-20 bg-white">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-4 text-center text-gray-900">Get a Free Estimate</h2>
          <div className="text-center mb-12">
            <p className="text-lg text-gray-600 mb-4">Fill out the form below or call us directly:</p>
            <a 
              href="tel:+17205555555" 
              className="inline-flex items-center text-2xl font-semibold text-green-600 hover:text-green-800 transition-colors"
            >
              <FaPhone className="h-6 w-6 mr-2" />
              (720) 555-5555
            </a>
          </div>
          <div className="max-w-3xl mx-auto">
            <InquiryForm />
          </div>
        </div>
      </section>
    </main>
  );
}
