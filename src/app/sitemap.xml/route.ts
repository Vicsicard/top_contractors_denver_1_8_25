import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  const baseUrl = 'https://www.topcontractorsdenver.com';
  const currentDate = new Date().toISOString();

  const pages: Array<{
    loc: string;
    lastmod: string;
    changefreq: string;
    priority: string;
  }> = [
    // Core pages
    {
      loc: baseUrl,
      lastmod: currentDate,
      changefreq: 'daily',
      priority: '1.0'
    },
    {
      loc: `${baseUrl}/search`,
      lastmod: currentDate,
      changefreq: 'daily',
      priority: '0.8'
    }
  ];

  try {
    // Add contractor pages
    console.log('Fetching contractors...');
    const contractors = await prisma.contractor.findMany({
      select: {
        slug: true,
        updatedAt: true,
      }
    });
    console.log(`Found ${contractors.length} contractors`);

    // Add contractor pages first
    contractors.forEach(contractor => {
      const contractorUrl = `${baseUrl}/contractor/${contractor.slug}`;
      console.log('Adding contractor URL:', contractorUrl);
      pages.push({
        loc: contractorUrl,
        lastmod: contractor.updatedAt.toISOString(),
        changefreq: 'weekly',
        priority: '0.7'
      });
    });
  } catch (error) {
    console.error('Error fetching contractors:', error);
  }

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
    pages.push({
      loc: `${baseUrl}/search/${category}`,
      lastmod: currentDate,
      changefreq: 'weekly',
      priority: '0.7'
    });
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
    pages.push({
      loc: `${baseUrl}/search/${location}`,
      lastmod: currentDate,
      changefreq: 'weekly',
      priority: '0.7'
    });
  });

  // Log the first few URLs for debugging
  console.log('First 5 URLs in sitemap:');
  pages.slice(0, 5).forEach(page => console.log(page.loc));

  // Generate XML
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${pages.map(page => `
  <url>
    <loc>${page.loc}</loc>
    <lastmod>${page.lastmod}</lastmod>
    <changefreq>${page.changefreq}</changefreq>
    <priority>${page.priority}</priority>
  </url>`).join('')}
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
