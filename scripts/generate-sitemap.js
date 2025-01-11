const fs = require('fs').promises;
const path = require('path');

const GHOST_URL = process.env.GHOST_URL || 'https://top-contractors-denver-1.ghost.io';
const GHOST_KEY = process.env['GHOST.ORG_CONTENT_API_KEY'] || '950228587820493fa1f65f9b17';
const SITE_URL = 'https://www.topcontractorsdenver.com';

async function fetchAllPosts() {
    try {
        const response = await fetch(
            `${GHOST_URL}/ghost/api/content/posts/?key=${GHOST_KEY}&limit=all&include=tags`,
            { next: { revalidate: 3600 } }
        );
        const data = await response.json();
        return data.posts || [];
    } catch (error) {
        console.error('Error fetching posts:', error);
        return [];
    }
}

async function generateSitemap() {
    const posts = await fetchAllPosts();
    
    // Start XML content
    let sitemap = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <!-- Main pages -->
  <url>
    <loc>${SITE_URL}/</loc>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>${SITE_URL}/services</loc>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>${SITE_URL}/blog</loc>
    <changefreq>daily</changefreq>
    <priority>0.9</priority>
  </url>

  <!-- Trade Service Pages -->
  <url><loc>${SITE_URL}/services/plumbers</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>
  <url><loc>${SITE_URL}/services/electricians</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>
  <url><loc>${SITE_URL}/services/hvac</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>
  <url><loc>${SITE_URL}/services/roofers</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>
  <url><loc>${SITE_URL}/services/painters</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>
  <url><loc>${SITE_URL}/services/landscapers</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>
  <url><loc>${SITE_URL}/services/home-remodelers</loc><changefreq>weekly</changefreq><priority>0.8</priority></url>

  <!-- Location-based Service Pages -->
  <!-- Plumbers -->
  <url><loc>${SITE_URL}/services/plumbers/downtown-denver</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/aurora</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/lakewood</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/arvada</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/westminster</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/thornton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/centennial</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/plumbers/littleton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>

  <!-- Electricians -->
  <url><loc>${SITE_URL}/services/electricians/downtown-denver</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/aurora</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/lakewood</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/arvada</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/westminster</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/thornton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/centennial</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/electricians/littleton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>

  <!-- HVAC -->
  <url><loc>${SITE_URL}/services/hvac/downtown-denver</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/aurora</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/lakewood</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/arvada</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/westminster</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/thornton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/centennial</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/hvac/littleton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>

  <!-- Roofers -->
  <url><loc>${SITE_URL}/services/roofers/downtown-denver</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/aurora</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/lakewood</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/arvada</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/westminster</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/thornton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/centennial</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>
  <url><loc>${SITE_URL}/services/roofers/littleton</loc><changefreq>weekly</changefreq><priority>0.7</priority></url>

  <!-- Blog Posts -->`;

    // Add blog posts
    for (const post of posts) {
        sitemap += `
  <url>
    <loc>${SITE_URL}/blog/${post.slug}</loc>
    <lastmod>${new Date(post.published_at).toISOString()}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.6</priority>
  </url>`;
    }

    // Add blog tag pages
    const tags = [...new Set(posts.flatMap(post => post.tags?.map(tag => tag.slug) || []))];
    for (const tag of tags) {
        sitemap += `
  <url>
    <loc>${SITE_URL}/blog/tag/${tag}</loc>
    <changefreq>weekly</changefreq>
    <priority>0.5</priority>
  </url>`;
    }

    // Close sitemap
    sitemap += '\n</urlset>';

    // Write to both sitemap files
    await fs.writeFile(path.join(process.cwd(), 'public', 'sitemap.xml'), sitemap);
    await fs.writeFile(path.join(process.cwd(), 'public', 'sitemap_new.xml'), sitemap);
    
    console.log('Sitemaps generated successfully!');
}

generateSitemap().catch(console.error);
