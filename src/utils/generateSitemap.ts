import { loadSearchData } from './searchData';
import { formatKeywordForUrl, formatLocationForUrl } from './urlHelpers';

export async function generateSitemap(domain: string): Promise<string> {
  const searchData = loadSearchData();
  const currentDate = new Date().toISOString();

  let sitemap = '<?xml version="1.0" encoding="UTF-8"?>\n';
  sitemap += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n';

  // Add homepage
  sitemap += `  <url>
    <loc>${domain}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>\n`;

  // Add keyword pages
  for (const keyword of searchData.keywords) {
    const formattedKeyword = formatKeywordForUrl(keyword);
    sitemap += `  <url>
    <loc>${domain}/${formattedKeyword}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>\n`;

    // Add location pages for each keyword
    for (const location of searchData.locations) {
      const formattedLocation = formatLocationForUrl(location);
      sitemap += `  <url>
    <loc>${domain}/${formattedKeyword}/${formattedLocation}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.6</priority>
  </url>\n`;
    }
  }

  sitemap += '</urlset>';
  return sitemap;
}
