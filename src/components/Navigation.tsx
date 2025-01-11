import Link from 'next/link';

function Navigation() {
  return (
    <nav className="flex-1">
      <div className="flex justify-between items-center">
        <Link 
          href="/" 
          className="text-2xl font-bold text-white hover:text-accent-warm transition-colors"
        >
          <span className="md:inline hidden">Top Contractors Denver</span>
          <span className="md:hidden">TCD</span>
        </Link>
        
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
      </div>
    </nav>
  );
}

export default Navigation;
