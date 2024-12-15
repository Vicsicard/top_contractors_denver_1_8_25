import React from 'react';
import Link from 'next/link';
import { notFound } from 'next/navigation';
import { FaMapMarkerAlt } from 'react-icons/fa';
import { Metadata } from 'next';

const FeaturedLocations = [
  {
    name: "Denver",
    areas: ["Downtown", "Capitol Hill", "Cherry Creek"],
    description: "Colorado's vibrant capital city"
  },
  {
    name: "Aurora",
    areas: ["Central Aurora", "Southlands", "Mission Viejo"],
    description: "A diverse and growing suburban hub"
  },
  {
    name: "Lakewood",
    areas: ["Belmar", "Green Mountain", "Union Square"],
    description: "Gateway to the Rocky Mountains"
  },
  {
    name: "Arvada",
    areas: ["Olde Town", "West Arvada", "Candelas"],
    description: "Historic charm meets modern living"
  },
  {
    name: "Westminster",
    areas: ["The Orchard", "Legacy Ridge", "Westminster Station"],
    description: "Family-friendly community with mountain views"
  },
  {
    name: "Thornton",
    areas: ["Original Thornton", "Eastlake", "North Creek"],
    description: "Growing community with modern amenities"
  }
];

const validTrades = [
  "Plumber",
  "Painter",
  "Electrician",
  "Landscaper",
  "General Contractor",
  "Roofer",
  "HVAC",
  "Handyman"
];

type Props = {
  params: Promise<{ trade: string }>;
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
};

export async function generateMetadata(props: Props): Promise<Metadata> {
  const trade = decodeURIComponent((await props.params).trade);
  return {
    title: `Find ${trade}s Near You - Denver Contractors`,
    description: `Browse and connect with the best ${trade.toLowerCase()}s in the Denver area. Get quotes and reviews from local professionals.`,
  };
}

export default async function TradePage(props: Props): Promise<React.ReactNode> {
  const trade = decodeURIComponent((await props.params).trade);
  
  if (!validTrades.includes(trade)) {
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
          Find {trade}s Near You
        </h1>
        
        <p className="text-xl text-gray-600 mb-12">
          Choose your location to find qualified {trade.toLowerCase()}s in your area:
        </p>

        <div className="grid md:grid-cols-3 gap-8">
          {FeaturedLocations.map((location, index) => (
            <Link 
              href={`/search/results?keyword=${encodeURIComponent(trade)}&location=${encodeURIComponent(location.name)}`}
              key={index}
              className="bg-white p-6 rounded-lg shadow-sm hover:shadow-md transition-shadow group"
            >
              <div className="flex items-start space-x-4">
                <div className="text-emerald-500 mt-1">
                  <FaMapMarkerAlt className="w-6 h-6" />
                </div>
                <div>
                  <h3 className="text-2xl font-bold mb-2 group-hover:text-emerald-600 transition-colors">
                    {location.name}
                  </h3>
                  <p className="text-gray-600 mb-4">{location.description}</p>
                  <div className="text-sm text-gray-500">
                    Service areas include: {location.areas.join(', ')}
                  </div>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </main>
  );
}
