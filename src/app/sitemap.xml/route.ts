import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

const BASE_URL = 'https://www.topcontractorsdenver.com';

export async function GET(request: Request) {
  console.log('Starting sitemap generation...');
  console.log('Request URL:', request.url);
  console.log('Request headers:', Object.fromEntries(request.headers));

  const currentDate = new Date().toISOString();
  let contractors = [];

  try {
    console.log('Connecting to database...');
    console.log('Database URL exists:', !!process.env.MONGODB_URI);
    console.log('Database name:', process.env.MONGODB_DB);

    console.log('Fetching contractors...');
    const dbContractors = await prisma.contractor.findMany({
      select: {
        slug: true,
        updatedAt: true,
      }
    });
    console.log('Found contractors:', JSON.stringify(dbContractors, null, 2));
    contractors = dbContractors;
  } catch (error) {
    console.error('Database error:', error);
    console.error('Error details:', {
      name: error instanceof Error ? error.name : 'Unknown',
      message: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined
    });
  }

  // Initialize pages array
  const pages: Array<{
    loc: string;
    lastmod: string;
    changefreq: string;
    priority: string;
  }> = [];

  // Add contractor pages first (higher priority)
  contractors.forEach(contractor => {
    const url = `${BASE_URL}/contractor/${contractor.slug}/`;
    console.log('Adding contractor URL:', url);
    pages.push({
      loc: url,
      lastmod: contractor.updatedAt.toISOString(),
      changefreq: 'weekly',
      priority: '0.9'
    });
  });

  // Add main pages
  const addPage = (path: string, changefreq: string, priority: string) => {
    const url = path === '' ? BASE_URL : `${BASE_URL}${path}/`;
    console.log('Adding URL:', url);
    pages.push({
      loc: url,
      lastmod: currentDate,
      changefreq,
      priority
    });
  };

  // Add core pages
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

  // Log final URLs for debugging
  console.log('Total pages:', pages.length);
  console.log('Sample URLs:', pages.slice(0, 5).map(p => p.loc));

  // Generate XML
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${pages.map(page => `  <url>
    <loc>${page.loc}</loc>
    <lastmod>${page.lastmod}</lastmod>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>
  </url>`).join('\n')}
</urlset>`;

  console.log('Generated XML length:', xml.length);
  console.log('First 500 characters of XML:', xml.substring(0, 500));

  // Return with proper headers
  const response = new NextResponse(xml, {
    headers: {
      'Content-Type': 'application/xml',
      'Cache-Control': 'no-cache, no-store, must-revalidate',
    },
  });

  console.log('Response headers:', Object.fromEntries(response.headers));
  return response;
}
