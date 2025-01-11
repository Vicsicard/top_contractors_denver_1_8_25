'use server';

import Link from 'next/link';

export function Navigation() {
  return (
    <header className="fixed top-0 left-0 right-0 z-50 bg-gradient-to-b from-gray-900/75 to-transparent backdrop-blur-sm">
      <nav className="container mx-auto px-4 py-4">
        <div className="flex justify-between items-center">
          <Link 
            href="/" 
            className="text-2xl font-bold text-white hover:text-accent-warm transition-colors"
          >
            <span className="md:inline hidden">Top Contractors Denver</span>
            <span className="md:hidden">TCD</span>
          </Link>
          
          {/* Mobile menu button - handled by client component */}
          <button
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
              <path d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>

          {/* Desktop menu */}
          <div className="hidden md:flex gap-6">
            <Link 
              href="/" 
              className="text-white hover:text-accent-warm transition-colors font-medium"
            >
              Home
            </Link>
            <Link 
              href="/blog" 
              className="text-white hover:text-accent-warm transition-colors font-medium"
            >
              Blog
            </Link>
            <Link 
              href="/services" 
              className="text-white hover:text-accent-warm transition-colors font-medium"
            >
              Services
            </Link>
          </div>

          {/* Mobile menu - handled by client component */}
          <div className="md:hidden absolute top-full left-0 right-0 bg-gray-900/95 backdrop-blur-sm transition-all duration-300 opacity-0 invisible">
            <div className="container mx-auto px-4 py-4 flex flex-col gap-4">
              <Link 
                href="/" 
                className="text-white hover:text-accent-warm transition-colors font-medium"
              >
                Home
              </Link>
              <Link 
                href="/blog" 
                className="text-white hover:text-accent-warm transition-colors font-medium"
              >
                Blog
              </Link>
              <Link 
                href="/services" 
                className="text-white hover:text-accent-warm transition-colors font-medium"
              >
                Services
              </Link>
            </div>
          </div>
        </div>
      </nav>
    </header>
  );
}
