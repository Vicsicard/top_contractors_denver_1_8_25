const fs = require('fs');
const path = require('path');
const { getPosts } = require('../src/utils/ghost');

const SITE_URL = 'https://www.topcontractorsdenver.com';

interface GhostPost {
    id: string;
    slug: string;
    title: string;
    html: string;
    feature_image?: string;
    excerpt?: string;
    published_at: string;
    reading_time?: number;
    tags?: Array<{ slug: string }>;
}

interface SitemapURL {
    loc: string;
    changefreq: 'daily' | 'weekly' | 'monthly';
    priority: number;
}

async function generateSitemap() {
    const urls: SitemapURL[] = [];

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
    posts.forEach((post: GhostPost) => {
        urls.push({
            loc: `${SITE_URL}/blog/${post.slug}`,
            changefreq: 'monthly',
            priority: 0.6
        });
    });

    // Add blog tag pages
    const uniqueTags = new Set<string>();
    posts.forEach((post: GhostPost) => {
        post.tags?.forEach((tag: { slug: string }) => {
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
