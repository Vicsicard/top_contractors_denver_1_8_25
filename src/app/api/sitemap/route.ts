import { generateSitemapUrls, generateSitemapXml } from '@/utils/sitemap';

export async function GET() {
  try {
    const urls = await generateSitemapUrls();
    const xml = generateSitemapXml(urls);

    return new Response(xml, {
      headers: {
        'Content-Type': 'application/xml',
        'Cache-Control': 'public, max-age=3600, s-maxage=3600',
      },
    });
  } catch (error) {
    console.error('Error generating sitemap:', error);
    return new Response('Error generating sitemap', { status: 500 });
  }
}
