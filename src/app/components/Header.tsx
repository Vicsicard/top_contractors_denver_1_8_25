'use client';

import Link from 'next/link';
import React from 'react';

const Header: React.FC = () => {
  return (
    <header className="bg-white shadow-sm">
      <nav className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-center h-16">
          <div className="flex items-center">
            <Link href="/" className="text-2xl font-bold text-[#003366]">
              Denver Contractors
            </Link>
          </div>
        </div>
      </nav>
    </header>
  );
};

export default Header;
