import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  const baseUrl = 'https://www.topcontractorsdenver.com';
  const currentDate = new Date().toISOString();

  // Initialize pages array with correct types
  const pages: Array<{
    loc: string;
    lastmod: string;
    changefreq: string;
    priority: string;
  }> = [];

  try {
    // Log database connection info (without exposing sensitive data)
    console.log('Database connection attempt starting...');
    console.log('Database provider:', prisma._engineConfig?.activeProvider);
    console.log('Database connection URL exists:', !!process.env.MONGODB_URI);

    // Test database connection first
    console.log('Testing database connection...');
    await prisma.$connect();
    console.log('Database connection established successfully');

    const count = await prisma.contractor.count();
    console.log('Database connection successful. Contractor count:', count);

    // Add contractor pages first
    console.log('Fetching contractors from database...');
    const contractors = await prisma.contractor.findMany({
      select: {
        slug: true,
        updatedAt: true,
        name: true,
      }
    });

    console.log('Database query completed. Found contractors:', JSON.stringify(contractors, null, 2));

    if (contractors.length === 0) {
      console.warn('No contractors found in database. This might indicate a connection or data issue.');
    }

    // Add contractor pages first (higher priority)
    contractors.forEach(contractor => {
      const contractorUrl = `${baseUrl}/contractor/${contractor.slug}`;
      console.log('Adding contractor URL:', contractorUrl);
      pages.push({
        loc: contractorUrl,
        lastmod: contractor.updatedAt.toISOString(),
        changefreq: 'weekly',
        priority: '0.9'
      });
    });

    console.log(`Successfully added ${contractors.length} contractor URLs`);
  } catch (error) {
    console.error('Error in sitemap generation:');
    console.error('Message:', error instanceof Error ? error.message : 'Unknown error');
    console.error('Name:', error instanceof Error ? error.name : 'Unknown');
    console.error('Stack:', error instanceof Error ? error.stack : 'No stack trace');
    
    // Log environment info for debugging
    console.log('Environment:', process.env.NODE_ENV);
    console.log('MONGODB_URI exists:', !!process.env.MONGODB_URI);
    console.log('MONGODB_DB exists:', !!process.env.MONGODB_DB);
  } finally {
    // Always disconnect from the database
    try {
      await prisma.$disconnect();
      console.log('Database disconnected successfully');
    } catch (disconnectError) {
      console.error('Error disconnecting from database:', disconnectError);
    }
  }

  // Add core pages
  const addPage = (path: string, changefreq: string, priority: string) => {
    const url = path === '' ? baseUrl : `${baseUrl}${path}`;
    pages.push({
      loc: url,
      lastmod: currentDate,
      changefreq,
      priority
    });
  };

  // Add main pages
  addPage('', 'daily', '1.0');
  addPage('/search', 'daily', '0.8');

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
  ];

  // Add category pages
  categories.forEach(category => {
    addPage(`/search/${category}`, 'weekly', '0.7');
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
  ];

  // Add location pages
  locations.forEach(location => {
    addPage(`/search/${location}`, 'weekly', '0.7');
  });

  // Log final sitemap stats
  console.log('Sitemap generation complete');
  console.log('Total URLs:', pages.length);
  console.log('Sample URLs:', pages.slice(0, 5).map(p => p.loc));

  // Generate XML with proper indentation
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${pages.map(page => `  <url>
    <loc>${page.loc}</loc>
    <lastmod>${page.lastmod}</lastmod>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>
  </url>`).join('\n')}
</urlset>`;

  // Return with no-cache headers to help with debugging
  return new NextResponse(xml, {
    headers: {
      'Content-Type': 'application/xml',
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
      'Expires': '0'
    },
  });
}
