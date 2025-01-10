import { getAllTrades, getAllSubregions } from './database';

interface SitemapUrl {
  loc: string;
  lastmod: string;
  changefreq: 'always' | 'hourly' | 'daily' | 'weekly' | 'monthly' | 'yearly' | 'never';
  priority: number;
}

export async function generateSitemapUrls(): Promise<SitemapUrl[]> {
  const baseUrl = 'https://topcontractorsdenver.com';
  const currentDate = new Date().toISOString();
  const urls: SitemapUrl[] = [];

  // Add homepage
  urls.push({
    loc: baseUrl,
    lastmod: currentDate,
    changefreq: 'daily',
    priority: 1.0,
  });

  // Add trades pages
  const trades = await getAllTrades();
  for (const trade of trades) {
    urls.push({
      loc: `${baseUrl}/trades/${trade.slug}`,
      lastmod: currentDate,
      changefreq: 'daily',
      priority: 0.9,
    });

    // Add trade-subregion combination pages
    const subregions = await getAllSubregions();
    for (const subregion of subregions) {
      urls.push({
        loc: `${baseUrl}/trades/${trade.slug}/${subregion.slug}`,
        lastmod: currentDate,
        changefreq: 'daily',
        priority: 0.8,
      });
    }
  }

  // Add about page
  urls.push({
    loc: `${baseUrl}/about`,
    lastmod: currentDate,
    changefreq: 'monthly',
    priority: 0.5,
  });

  // Add contact page
  urls.push({
    loc: `${baseUrl}/contact`,
    lastmod: currentDate,
    changefreq: 'monthly',
    priority: 0.5,
  });

  return urls;
}

export function generateSitemapXml(urls: SitemapUrl[]): string {
  const xmlUrls = urls
    .map(
      (url) => `
  <url>
    <loc>${url.loc}</loc>
    <lastmod>${url.lastmod}</lastmod>
    <changefreq>${url.changefreq}</changefreq>
    <priority>${url.priority}</priority>
  </url>`
    )
    .join('');

  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${xmlUrls}
</urlset>`;
}
