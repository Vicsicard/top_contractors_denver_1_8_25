const GhostContentAPI = require('@tryghost/content-api');

const OLD_GHOST_URL = 'https://top-contractors-denver-1.ghost.io';
const OLD_GHOST_KEY = '130d98b20875066982b1a8314f';

const NEW_GHOST_URL = 'https://top-contractors-denver-2.ghost.io';
const NEW_GHOST_KEY = '6229b20c390c831641ea577093';

async function testBlogFeatures(url, key, name) {
    try {
        console.log(`\nTesting ${name} Ghost Blog Features...`);
        
        const api = new GhostContentAPI({
            url,
            key,
            version: 'v5.0'
        });

        // 1. Test single post retrieval
        const posts = await api.posts.browse({
            limit: 1,
            include: ['tags', 'authors']
        });
        
        if (posts.length > 0) {
            const post = posts[0];
            console.log('\nLatest Post Details:');
            console.log('- Title:', post.title);
            console.log('- Slug:', post.slug);
            console.log('- Has Feature Image:', !!post.feature_image);
            console.log('- Has Meta Description:', !!post.meta_description);
            console.log('- Has Excerpt:', !!post.excerpt);
            console.log('- Reading Time:', post.reading_time, 'minutes');
            
            // 2. Test tag functionality
            if (post.tags && post.tags.length > 0) {
                console.log('\nTags for Latest Post:');
                post.tags.forEach(tag => {
                    console.log(`- ${tag.name} (${tag.slug})`);
                });

                // 3. Test posts by tag
                const tagSlug = post.tags[0].slug;
                const taggedPosts = await api.posts.browse({
                    limit: 3,
                    filter: `tag:${tagSlug}`
                });
                
                console.log(`\nFound ${taggedPosts.length} other posts with tag '${post.tags[0].name}'`);
            } else {
                console.log('\nNo tags found for the latest post');
            }

            // 4. Test SEO fields
            console.log('\nSEO Check:');
            console.log('- Has Open Graph Title:', !!post.og_title);
            console.log('- Has Open Graph Description:', !!post.og_description);
            console.log('- Has Twitter Card:', !!post.twitter_title);
            console.log('- Has Meta Title:', !!post.meta_title);
        }

    } catch (error) {
        console.error(`Error testing ${name} Ghost blog features:`, error);
    }
}

async function runTests() {
    console.log('Starting Blog Feature Tests...\n');
    
    await testBlogFeatures(OLD_GHOST_URL, OLD_GHOST_KEY, 'Old');
    await testBlogFeatures(NEW_GHOST_URL, NEW_GHOST_KEY, 'New');
    
    console.log('\nBlog Feature Tests completed.');
}

runTests();
