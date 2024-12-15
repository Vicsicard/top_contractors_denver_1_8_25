'use client';

import Link from 'next/link';
import React from 'react';

const Header: React.FC = () => {
  return (
    <header className="bg-white shadow-sm">
      <nav className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          <div className="flex items-center space-x-8">
            {/* Logo */}
            <Link href="/" className="text-2xl font-bold text-emerald-600">
              Denver Contractors
            </Link>

            {/* Navigation Links */}
            <div className="hidden sm:flex sm:space-x-8">
              <Link 
                href="/trade/plumber" 
                className="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
              >
                Plumbers
              </Link>
              <Link 
                href="/trade/electrician" 
                className="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
              >
                Electricians
              </Link>
              <Link 
                href="/trade/hvac" 
                className="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
              >
                HVAC
              </Link>
            </div>
          </div>

          {/* Location Links */}
          <div className="hidden sm:flex sm:space-x-8 items-center">
            <Link 
              href="/location/downtown-denver" 
              className="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
            >
              Downtown
            </Link>
            <Link 
              href="/location/aurora" 
              className="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
            >
              Aurora
            </Link>
            <Link 
              href="/location/lakewood" 
              className="text-gray-700 hover:text-gray-900 px-3 py-2 rounded-md text-sm font-medium"
            >
              Lakewood
            </Link>
          </div>
        </div>
      </nav>
    </header>
  );
};

export default Header;
