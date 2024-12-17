import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

interface Contractor {
  slug: string;
  updatedAt: Date;
}

export async function GET(request: Request): Promise<NextResponse> {
  console.log('Starting sitemap generation...');
  
  // Get domain from request
  const host = request.headers.get('host') || 'www.topcontractorsdenver.com';
  const protocol = process.env.NODE_ENV === 'production' ? 'https' : 'http';
  const domain = `${protocol}://${host.startsWith('www.') ? host : `www.${host}`}`;
  
  console.log('Using domain:', domain);

  const currentDate = new Date().toISOString();
  const contractors: Contractor[] = [];

  try {
    console.log('Fetching contractors...');
    const dbContractors = await prisma.contractor.findMany({
      select: {
        slug: true,
        updatedAt: true,
      }
    });
    console.log('Found contractors:', JSON.stringify(dbContractors, null, 2));
    contractors.push(...dbContractors);
  } catch (error) {
    console.error('Database error:', error instanceof Error ? error.message : String(error));
  }

  // Build XML parts
  const xmlParts: string[] = [];

  // XML declaration
  xmlParts.push('<?xml version="1.0" encoding="UTF-8"?>');
  xmlParts.push('<?xml-stylesheet type="text/xsl" href="/sitemap.xsl"?>');
  xmlParts.push('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">');

  // Add homepage
  xmlParts.push(`  <url>
    <loc>${domain}/</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>`);

  // Add search page
  xmlParts.push(`  <url>
    <loc>${domain}/search/</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.8</priority>
  </url>`);

  // Add contractor pages
  contractors.forEach(contractor => {
    xmlParts.push(`  <url>
    <loc>${domain}/contractor/${contractor.slug}/</loc>
    <lastmod>${contractor.updatedAt.toISOString()}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>`);
  });

  // Categories
  const categories = [
    'Home-Remodeling',
    'Kitchen-Remodeling',
    'Bathroom-Remodeling',
    'General-Contractor',
    'Custom-Homes',
    'Handyman',
    'Landscaping',
    'Roofing',
    'Painting',
    'Plumbing',
    'Electrical',
    'HVAC'
  ] as const;

  // Add category pages
  categories.forEach(category => {
    xmlParts.push(`  <url>
    <loc>${domain}/search/${category}/</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>`);
  });

  // Locations
  const locations = [
    'Denver',
    'Aurora',
    'Lakewood',
    'Arvada',
    'Westminster',
    'Thornton',
    'Centennial',
    'Highlands-Ranch',
    'Boulder',
    'Littleton'
  ] as const;

  // Add location pages
  locations.forEach(location => {
    xmlParts.push(`  <url>
    <loc>${domain}/search/${location}/</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>`);
  });

  // Close urlset tag
  xmlParts.push('</urlset>');

  // Join all parts with newlines
  const xml = xmlParts.join('\n');

  console.log('XML Length:', xml.length);
  console.log('First URL:', xml.match(/<loc>(.*?)<\/loc>/)?.[1]);

  // Return with proper headers
  const response = new NextResponse(xml, {
    headers: {
      'Content-Type': 'application/xml; charset=utf-8',
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'X-Robots-Tag': 'all',
    },
  });

  return response;
}
