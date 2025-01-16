'use client';

import React from 'react';
import Link from 'next/link';

const _locationCategories = {
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

const categories = [
  {
    title: 'Plumber',
    href: '/plumber',
    description: 'Find licensed plumbers for repairs, installations, and emergencies',
  },
  {
    title: 'Electrician',
    href: '/electrician',
    description: 'Connect with certified electricians for all electrical needs',
  },
  {
    title: 'HVAC',
    href: '/hvac',
    description: 'Expert heating, ventilation, and air conditioning services',
  },
  {
    title: 'Roofer',
    href: '/roofer',
    description: 'Professional roofing installation, repair, and maintenance',
  },
  {
    title: 'Carpenter',
    href: '/carpenter',
    description: 'Skilled carpenters for woodwork and custom projects',
  },
  {
    title: 'Painter',
    href: '/painter',
    description: 'Professional painters for interior and exterior painting',
  },
  {
    title: 'Landscaper',
    href: '/landscaper',
    description: 'Transform your outdoor space with expert landscaping services',
  },
  {
    title: 'Home Remodeler',
    href: '/home-remodeler',
    description: 'Complete home renovation and remodeling services',
  },
  {
    title: 'Bathroom Remodeler',
    href: '/bathroom-remodeler',
    description: 'Specialized bathroom renovation and upgrades',
  },
  {
    title: 'Kitchen Remodeler',
    href: '/kitchen-remodeler',
    description: 'Expert kitchen renovation and modernization',
  },
  {
    title: 'Sider',
    href: '/sider',
    description: 'Professional siding installation services',
  },
  {
    title: 'Mason',
    href: '/mason',
    description: 'Expert masonry work for walls, patios, and structures',
  },
  {
    title: 'Deck Builder',
    href: '/deck-builder',
    description: 'Custom deck design, building, and repair services',
  },
  {
    title: 'Flooring Installer',
    href: '/flooring-installer',
    description: 'Professional installation of all flooring types',
  },
  {
    title: 'Window Installer',
    href: '/window-installer',
    description: 'Window installation, replacement, and repair services',
  },
  {
    title: 'Fence Installer',
    href: '/fence-installer',
    description: 'Professional fence installation and repair services',
  },
  {
    title: 'Epoxy Garage Coater',
    href: '/epoxy-garage-coater',
    description: 'Professional garage floor epoxy coating services',
  },
];

export default function LocationCategoriesSection() {
  return (
    <section className="py-12 bg-white">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-center mb-8">Popular Trades in Denver</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {categories.map((category) => (
            <Link
              key={category.href}
              href={category.href}
              className="block p-6 bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition-shadow duration-200"
            >
              <h3 className="text-xl font-semibold mb-2">{category.title}</h3>
              <p className="text-gray-600">{category.description}</p>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
}
