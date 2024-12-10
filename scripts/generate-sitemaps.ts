import fs from 'fs/promises';
import path from 'path';

interface SitemapEntry {
  loc: string;
  lastmod: string;
  changefreq: string;
  priority: string;
}

export async function generateSitemaps(
  baseUrl: string,
  categories: string[],
  locations: string[]
): Promise<void> {
  const entries: SitemapEntry[] = [];
  const today = new Date().toISOString().split('T')[0];

  // Add homepage
  entries.push({
    loc: baseUrl,
    lastmod: today,
    changefreq: 'daily',
    priority: '1.0'
  });

  // Add category-location pages
  for (const category of categories) {
    for (const location of locations) {
      entries.push({
        loc: `${baseUrl}/${category}/${location}`,
        lastmod: today,
        changefreq: 'weekly',
        priority: '0.8'
      });
    }
  }

  const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${entries
  .map(
    entry => `  <url>
    <loc>${entry.loc}</loc>
    <lastmod>${entry.lastmod}</lastmod>
    <changefreq>${entry.changefreq}</changefreq>
    <priority>${entry.priority}</priority>
  </url>`
  )
  .join('\n')}
</urlset>`;

  await fs.writeFile(path.join(process.cwd(), 'public', 'sitemap.xml'), sitemap);
}
