import GhostContentAPI from '@tryghost/content-api';

const GHOST_URL = 'https://top-contractors-denver-1.ghost.io';
const GHOST_KEY = '950228587820493fa1f65f9b17';

async function testGhostAPI() {
    try {
        console.log('Testing Ghost API connection...');
        console.log('URL:', GHOST_URL);
        console.log('Key:', GHOST_KEY);

        const api = new GhostContentAPI({
            url: GHOST_URL,
            key: GHOST_KEY,
            version: 'v5.0'
        });

        const posts = await api.posts.browse({
            limit: 5,
            include: ['tags']
        });

        console.log('Successfully fetched posts:', posts.length);
        console.log('First post:', JSON.stringify(posts[0], null, 2));
    } catch (error) {
        console.error('Error testing Ghost API:', error);
    }
}

testGhostAPI();
