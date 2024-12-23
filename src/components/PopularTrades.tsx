'use client';

import React from 'react';
import Link from 'next/link';
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
  FaWarehouse
} from 'react-icons/fa';

const PopularTrades = [
  { name: 'Plumber', Icon: FaWrench, route: 'plumber' },
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

export default function PopularTradesSection() {
  return (
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
  );
}
