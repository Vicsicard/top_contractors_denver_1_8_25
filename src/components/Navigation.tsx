import Link from 'next/link';

export function Navigation() {
  return (
    <header className="absolute top-0 left-0 right-0 z-50">
      <nav className="container mx-auto px-4 py-4">
        <div className="flex justify-between items-center">
          <Link href="/" className="text-2xl font-bold text-white hover:text-accent-warm transition-colors">
            Top Contractors Denver
          </Link>
          
          <div className="flex gap-6">
            <Link href="/" className="text-white hover:text-accent-warm transition-colors font-medium">
              Home
            </Link>
            <Link href="/blog" className="text-white hover:text-accent-warm transition-colors font-medium">
              Blog
            </Link>
          </div>
        </div>
      </nav>
    </header>
  );
}
