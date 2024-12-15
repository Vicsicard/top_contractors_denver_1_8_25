import React from 'react';
import Link from 'next/link';
import { FaWrench, FaPaintRoller, FaBolt, FaTree, FaHome, FaTint, FaSnowflake, FaTools } from 'react-icons/fa';
import { notFound } from 'next/navigation';
import { Metadata } from 'next';

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

const validLocations = [
  "Denver",
  "Aurora",
  "Lakewood",
  "Arvada",
  "Westminster",
  "Thornton"
];

type Props = {
  params: Promise<{ location: string }>;
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
};

export async function generateMetadata(props: Props): Promise<Metadata> {
  const location = decodeURIComponent((await props.params).location);
  return {
    title: `Find Contractors in ${location} - Denver Contractors`,
    description: `Browse and connect with the best contractors in ${location}. Find plumbers, electricians, painters, and more.`,
  };
}

export default async function LocationPage(props: Props): Promise<React.ReactNode> {
  const location = decodeURIComponent((await props.params).location);
  
  if (!validLocations.includes(location)) {
    notFound();
  }

  return (
    <main className="min-h-screen bg-white py-12">
      <div className="container mx-auto px-4">
        <div className="mb-8">
          <Link href="/" className="text-emerald-600 hover:text-emerald-700">
            ← Back to Home
          </Link>
        </div>
        
        <h1 className="text-4xl md:text-5xl font-bold mb-8">
          Find Contractors in {location}
        </h1>
        
        <p className="text-xl text-gray-600 mb-12">
          Choose from our most popular contractor categories in {location}:
        </p>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          {PopularTrades.map((trade, index) => (
            <Link 
              href={`/search/results?keyword=${encodeURIComponent(trade.name)}&location=${encodeURIComponent(location)}`}
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
    </main>
  );
}
