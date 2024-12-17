import { MetadataRoute } from 'next';
import { NextResponse } from 'next/server';
import { PrismaClient } from '@prisma/client';
import { generateSlug } from '@/utils/seoUtils';

const prisma = new PrismaClient();

async function generateSitemapXml() {
  // Always use the custom domain
  const baseUrl = 'https://topcontractorsdenver.com';

  // Get all contractors
  const contractors = await prisma.business.findMany();

  // Create XML content
  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>${baseUrl}</loc>
    <lastmod>${new Date().toISOString()}</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>${baseUrl}/search</loc>
    <lastmod>${new Date().toISOString()}</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.8</priority>
  </url>
  ${contractors.map(contractor => `
  <url>
    <loc>${baseUrl}/contractor/${generateSlug(contractor)}</loc>
    <lastmod>${contractor.updatedAt.toISOString()}</lastmod>
    <changefreq>daily</changefreq>
    <priority>0.9</priority>
  </url>
  `).join('')}
</urlset>`;

  return xml;
}

export async function GET() {
  try {
    const xml = await generateSitemapXml();
    
    return new NextResponse(xml, {
      headers: {
        'Content-Type': 'application/xml',
        'Cache-Control': 'public, max-age=3600, s-maxage=3600',
      },
    });
  } catch (error) {
    console.error('Error generating sitemap:', error);
    return new NextResponse('Error generating sitemap', { status: 500 });
  }
}
