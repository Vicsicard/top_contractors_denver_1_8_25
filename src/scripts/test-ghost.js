const GhostContentAPI = require('@tryghost/content-api');

const OLD_GHOST_URL = 'https://top-contractors-denver-1.ghost.io';
const OLD_GHOST_KEY = '130d98b20875066982b1a8314f';

const NEW_GHOST_URL = 'https://top-contractors-denver-2.ghost.io';
const NEW_GHOST_KEY = '6229b20c390c831641ea577093';

async function testGhostAPI(url, key, name) {
    try {
        console.log(`\nTesting ${name} Ghost API connection...`);
        console.log('URL:', url);
        console.log('Key:', key);

        const api = new GhostContentAPI({
            url,
            key,
            version: 'v5.0'
        });

        const posts = await api.posts.browse({
            limit: 5,
            include: ['tags']
        });

        console.log(`Successfully fetched posts from ${name}:`, posts.length);
        if (posts.length > 0) {
            console.log('Latest post:', {
                title: posts[0].title,
                published: posts[0].published_at,
                tags: posts[0].tags?.map(t => t.name)
            });
        }
    } catch (error) {
        console.error(`Error testing ${name} Ghost API:`, error);
    }
}

async function runTests() {
    console.log('Starting Ghost API tests...\n');
    
    await testGhostAPI(OLD_GHOST_URL, OLD_GHOST_KEY, 'Old');
    await testGhostAPI(NEW_GHOST_URL, NEW_GHOST_KEY, 'New');
    
    console.log('\nGhost API tests completed.');
}

runTests();
