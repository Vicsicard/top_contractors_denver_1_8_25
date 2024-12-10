import { loadSearchData } from './searchData';
import { formatKeywordForUrl, formatLocationForUrl } from './urlHelpers';

export async function generateSitemap(domain: string) {
  const searchData = loadSearchData();
  const currentDate = new Date().toISOString();

  // Start the XML string
  let xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <!-- Static Pages -->
  <url>
    <loc>${domain}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>${domain}/categories</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>${domain}/cities</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>

  <!-- Dynamic Service Pages -->`;

  // Add service category pages
  searchData.keywords.forEach((keyword) => {
    xml += `
  <url>
    <loc>${domain}/categories/${formatKeywordForUrl(keyword)}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>`;
  });

  // Add location pages
  searchData.locations.forEach((location) => {
    xml += `
  <url>
    <loc>${domain}/cities/${formatLocationForUrl(location.location)}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.7</priority>
  </url>`;
  });

  // Add service+location combination pages
  searchData.keywords.forEach((keyword) => {
    searchData.locations.forEach((location) => {
      xml += `
  <url>
    <loc>${domain}/${formatKeywordForUrl(keyword)}/${formatLocationForUrl(location.location)}</loc>
    <lastmod>${currentDate}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.6</priority>
  </url>`;
    });
  });

  // Close the XML
  xml += '\n</urlset>';

  return xml;
}
