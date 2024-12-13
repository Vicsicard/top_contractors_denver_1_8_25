import Link from 'next/link';
import React from 'react';

const Header: React.FC = () => {
  return (
    <header className="bg-white shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
        <div className="flex items-center justify-between">
          {/* Logo and site name - SEO optimized with descriptive text */}
          <Link href="/" className="flex items-center space-x-3">
            <span className="text-xl font-bold text-gray-900">Denver Contractors</span>
            <span className="sr-only">Home</span>
          </Link>
          
          {/* Main navigation - SEO optimized with semantic markup */}
          <nav aria-label="Main navigation" className="flex space-x-8">
            <Link href="/services" className="text-gray-700 hover:text-gray-900">
              Services
            </Link>
            <Link href="/contractors" className="text-gray-700 hover:text-gray-900">
              Find Contractors
            </Link>
            <Link href="/about" className="text-gray-700 hover:text-gray-900">
              About
            </Link>
          </nav>
        </div>
      </div>
    </header>
  );
};

export default Header;
