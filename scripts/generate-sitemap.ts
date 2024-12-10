import fs from 'fs';
import path from 'path';
import { generateSitemap } from '../src/utils/generateSitemap';

async function main() {
  try {
    const domain = 'https://www.topcontractorsdenver.com';
    const sitemap = await generateSitemap(domain);
    
    // Write sitemap.xml to the public directory
    const publicDir = path.join(process.cwd(), 'public');
    fs.writeFileSync(path.join(publicDir, 'sitemap.xml'), sitemap);
    
    console.log('Sitemap generated successfully!');
  } catch (error) {
    console.error('Error generating sitemap:', error);
    process.exit(1);
  }
}

main();
