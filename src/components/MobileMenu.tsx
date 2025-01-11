'use client';

import { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';

export function MobileMenu() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const pathname = usePathname();

  return (
    <div className="md:hidden">
      <button
        onClick={() => setIsMenuOpen(!isMenuOpen)}
        className="text-white hover:text-accent-warm focus:outline-none"
        aria-label="Toggle menu"
      >
        <svg
          className="h-6 w-6"
          fill="none"
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth="2"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          {isMenuOpen ? (
            <path d="M6 18L18 6M6 6l12 12" />
          ) : (
            <path d="M4 6h16M4 12h16M4 18h16" />
          )}
        </svg>
      </button>

      <div 
        className={`absolute top-full left-0 right-0 bg-gray-900/95 backdrop-blur-sm transition-all duration-300 ${
          isMenuOpen ? 'opacity-100 visible' : 'opacity-0 invisible'
        }`}
      >
        <div className="container mx-auto px-4 py-4 flex flex-col gap-4">
          <Link 
            href="/" 
            className={`text-white hover:text-accent-warm transition-colors font-medium ${
              pathname === '/' ? 'text-accent-warm' : ''
            }`}
            onClick={() => setIsMenuOpen(false)}
          >
            Home
          </Link>
          <Link 
            href="/blog" 
            className={`text-white hover:text-accent-warm transition-colors font-medium ${
              pathname?.startsWith('/blog') ? 'text-accent-warm' : ''
            }`}
            onClick={() => setIsMenuOpen(false)}
          >
            Blog
          </Link>
          <Link 
            href="/services" 
            className={`text-white hover:text-accent-warm transition-colors font-medium ${
              pathname?.startsWith('/services') ? 'text-accent-warm' : ''
            }`}
            onClick={() => setIsMenuOpen(false)}
          >
            Services
          </Link>
        </div>
      </div>
    </div>
  );
}
