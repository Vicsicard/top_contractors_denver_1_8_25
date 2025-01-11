import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { getPosts } from '../src/utils/ghost.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const SITE_URL = 'https://www.topcontractorsdenver.com';

/**
 * @typedef {Object} SitemapURL
 * @property {string} loc
 * @property {'daily' | 'weekly' | 'monthly'} changefreq
 * @property {number} priority
 */

async function generateSitemap() {
    /** @type {SitemapURL[]} */
    const urls = [];

    // Add main pages
    urls.push(
        {
            loc: SITE_URL,
            changefreq: 'daily',
            priority: 1.0
        },
        {
            loc: `${SITE_URL}/services`,
            changefreq: 'weekly',
            priority: 0.9
        }
    );

    // Add service pages
    const services = [
        'plumbers', 'electricians', 'hvac', 'roofers', 'painters', 'landscapers',
        'home-remodelers', 'bathroom-remodelers', 'kitchen-remodelers',
        'siding-and-gutters', 'masonry', 'decks', 'flooring', 'windows',
        'fencing', 'epoxy-garage'
    ];

    // Add main service pages
    services.forEach(service => {
        urls.push({
            loc: `${SITE_URL}/services/${service}`,
            changefreq: 'weekly',
            priority: 0.8
        });
    });

    // Add location-specific service pages
    const locations = [
        'downtown-denver', 'aurora', 'lakewood', 'arvada', 'westminster',
        'thornton', 'centennial', 'littleton', 'parker', 'brighton',
        'northglenn', 'broomfield', 'denver-tech-center', 'cherry-creek',
        'park-hill'
    ];

    services.forEach(service => {
        locations.forEach(location => {
            urls.push({
                loc: `${SITE_URL}/services/${service}/${location}`,
                changefreq: 'weekly',
                priority: 0.7
            });
        });
    });

    // Add blog pages
    const { posts, totalPages } = await getPosts(1, 100); // Get first 100 posts
    posts.forEach(post => {
        urls.push({
            loc: `${SITE_URL}/blog/${post.slug}`,
            changefreq: 'monthly',
            priority: 0.6
        });
    });

    // Add blog tag pages
    const uniqueTags = new Set();
    posts.forEach(post => {
        post.tags?.forEach(tag => {
            if (tag.slug) {
                uniqueTags.add(tag.slug);
            }
        });
    });

    uniqueTags.forEach(tag => {
        urls.push({
            loc: `${SITE_URL}/blog/tag/${encodeURIComponent(tag)}`,
            changefreq: 'weekly',
            priority: 0.5
        });
    });

    // Generate sitemap XML
    const sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(url => `  <url>
    <loc>${url.loc}</loc>
    <changefreq>${url.changefreq}</changefreq>
    <priority>${url.priority}</priority>
  </url>`).join('\n')}
</urlset>`;

    // Write sitemap to file
    fs.writeFileSync(
        path.join(process.cwd(), 'public', 'sitemap.xml'),
        sitemap
    );

    console.log(`Generated sitemap with ${urls.length} URLs`);
}

generateSitemap().catch(console.error);
