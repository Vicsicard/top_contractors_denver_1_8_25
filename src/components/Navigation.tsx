'use client';

import { usePathname } from 'next/navigation';
import { useState } from 'react';

export function Navigation() {
  const pathname = usePathname();
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <header className="fixed top-0 left-0 right-0 z-50 bg-gradient-to-b from-gray-900/75 to-transparent backdrop-blur-sm">
      <nav className="container mx-auto px-4 py-4">
        <div className="flex justify-between items-center">
          <a href="/" className="text-2xl font-bold text-white hover:text-accent-warm transition-colors">
            <span className="md:inline hidden">Top Contractors Denver</span>
            <span className="md:hidden">TCD</span>
          </a>
          
          {/* Mobile menu button */}
          <button
            onClick={() => setIsMenuOpen(!isMenuOpen)}
            className="md:hidden text-white hover:text-accent-warm focus:outline-none"
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

          {/* Desktop menu */}
          <div className="hidden md:flex gap-6">
            <a 
              href="/" 
              className={`text-white hover:text-accent-warm transition-colors font-medium ${pathname === '/' ? 'text-accent-warm' : ''}`}
            >
              Home
            </a>
            <a 
              href="/blog" 
              className={`text-white hover:text-accent-warm transition-colors font-medium ${pathname === '/blog' ? 'text-accent-warm' : ''}`}
            >
              Blog
            </a>
          </div>
        </div>

        {/* Mobile menu */}
        {isMenuOpen && (
          <div className="md:hidden mt-4 bg-gray-900/95 rounded-lg p-4 backdrop-blur-sm">
            <div className="flex flex-col gap-4">
              <a 
                href="/" 
                onClick={() => setIsMenuOpen(false)}
                className={`text-white hover:text-accent-warm transition-colors font-medium ${pathname === '/' ? 'text-accent-warm' : ''}`}
              >
                Home
              </a>
              <a 
                href="/blog" 
                onClick={() => setIsMenuOpen(false)}
                className={`text-white hover:text-accent-warm transition-colors font-medium ${pathname === '/blog' ? 'text-accent-warm' : ''}`}
              >
                Blog
              </a>
            </div>
          </div>
        )}
      </nav>
    </header>
  );
}
