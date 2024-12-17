import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const url = request.nextUrl.clone();
  const hostname = request.headers.get('host') || '';
  const wwwHostname = 'www.topcontractorsdenver.com';

  // Always redirect sitemap.xml to www version
  if (url.pathname === '/sitemap.xml' && !hostname.startsWith('www.')) {
    return NextResponse.redirect(`https://www.topcontractorsdenver.com/sitemap.xml`, 301);
  }

  // If we're not on the www subdomain and not on localhost, redirect
  if (!hostname.startsWith('www.') && !hostname.includes('localhost')) {
    url.host = wwwHostname;
    return NextResponse.redirect(url);
  }

  // Rewrite URLs in the response
  const response = NextResponse.next();
  
  // Add security headers
  response.headers.set('X-Robots-Tag', 'all');
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('Referrer-Policy', 'strict-origin-when-cross-origin');

  return response;
}

export const config = {
  matcher: [
    // Match all paths
    '/:path*',
  ],
};
