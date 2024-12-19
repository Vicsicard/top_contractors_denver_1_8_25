const https = require('https');
const { IncomingMessage } = require('http');

function testRSSFeed() {
  https.get('https://top-contractors-denver.ghost.io/c36da403a913b9a47563b6235f0016/rss', (res) => {
    let data = '';

    res.on('data', (chunk) => {
      data += chunk;
    });

    res.on('end', () => {
      try {
        // Parse the XML data to see the available fields
        console.log('RSS Feed Content:', data);
        
        // Look for specific tags in the XML
        const hasTitle = data.includes('<title>');
        const hasContent = data.includes('<content:encoded>');
        const hasImage = data.includes('<media:content');
        const hasMetaDescription = data.includes('<description>');
        const hasKeywords = data.includes('<category>');
        const hasPubDate = data.includes('<pubDate>');
        const hasFeatureImage = data.includes('<feature_image>');
        const hasMetaTitle = data.includes('<meta_title>');
        const hasMetaDescription2 = data.includes('<meta_description>');
        const hasOgImage = data.includes('<og_image>');
        const hasOgTitle = data.includes('<og_title>');
        const hasOgDescription = data.includes('<og_description>');
        
        console.log('\nAvailable Fields:');
        console.log('- Title:', hasTitle);
        console.log('- Content:', hasContent);
        console.log('- Images:', hasImage);
        console.log('- Meta Description:', hasMetaDescription);
        console.log('- Keywords/Categories:', hasKeywords);
        console.log('- Publication Date:', hasPubDate);
        console.log('- Feature Image:', hasFeatureImage);
        console.log('- Meta Title:', hasMetaTitle);
        console.log('- Meta Description (Ghost):', hasMetaDescription2);
        console.log('- OG Image:', hasOgImage);
        console.log('- OG Title:', hasOgTitle);
        console.log('- OG Description:', hasOgDescription);

        // Show a sample post structure
        const postMatch = data.match(/<item>[\s\S]*?<\/item>/);
        if (postMatch) {
          console.log('\nSample Post Structure:');
          console.log(postMatch[0]);
        }
      } catch (error) {
        console.error('Error parsing RSS feed:', error);
      }
    });
  }).on('error', (err) => {
    console.error('Error fetching RSS feed:', err);
  });
}

testRSSFeed();
