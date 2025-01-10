import GhostContentAPI from '@tryghost/content-api';
import axios from 'axios';

const GHOST_URL = process.env.GHOST_URL || 'https://top-contractors-denver-1.ghost.io';
const GHOST_KEY = process.env['GHOST.ORG_CONTENT_API_KEY'] || '950228587820493fa1f65f9b17';

// Initialize Ghost Content API
const _api = new GhostContentAPI({
    url: GHOST_URL,
    key: GHOST_KEY,
    version: 'v5.0'
});

// Helper function to fetch posts using axios directly if Ghost API fails
async function fetchPostsWithAxios(options = { limit: 10 }) {
    try {
        const response = await axios.get(`${GHOST_URL}/ghost/api/content/posts/?key=${GHOST_KEY}&limit=${options.limit}`);
        return response.data.posts;
    } catch (error) {
        console.error('Error fetching posts with axios:', error);
        return [];
    }
}

export interface GhostPost {
    id: string;
    slug: string;
    title: string;
    html: string;
    feature_image?: string;
    excerpt?: string;
    published_at: string;
    reading_time?: number;
    tags?: any[];
}

export async function getPosts(options = { limit: 10 }): Promise<GhostPost[]> {
    try {
        const posts = await _api.posts
            .browse({
                limit: options.limit,
                include: ['tags'],
                fields: ['id', 'slug', 'title', 'html', 'feature_image', 'excerpt', 'published_at', 'reading_time']
            });
        
        return posts as GhostPost[];
    } catch (error) {
        console.error('Error fetching posts from Ghost:', error);
        // Fallback to axios
        return fetchPostsWithAxios(options);
    }
}

export async function getPostBySlug(slug: string): Promise<GhostPost | null> {
    try {
        const post = await _api.posts
            .read({
                slug
            }, { include: ['tags'] });
        return post as GhostPost;
    } catch (error) {
        console.error(`Error fetching post with slug ${slug}:`, error);
        return null;
    }
}

export async function getPostsByTag(tag: string, options = { limit: 10 }): Promise<GhostPost[]> {
    try {
        const posts = await _api.posts
            .browse({
                limit: options.limit,
                filter: `tag:${tag}`,
                include: ['tags']
            });
        return posts as GhostPost[];
    } catch (error) {
        console.error(`Error fetching posts with tag ${tag}:`, error);
        return [];
    }
}
