import GhostContentAPI from '@tryghost/content-api';

const GHOST_URL = process.env.GHOST_URL || 'https://top-contractors-denver-1.ghost.io';
const GHOST_KEY = process.env['GHOST.ORG_CONTENT_API_KEY'] || '950228587820493fa1f65f9b17';

// Helper function to fetch posts using native fetch API
async function fetchPostsWithFetch(options = { limit: 10 }) {
    try {
        const response = await fetch(
            `${GHOST_URL}/ghost/api/content/posts/?key=${GHOST_KEY}&limit=${options.limit}`,
            { next: { revalidate: 3600 } } // Cache for 1 hour
        );
        const data = await response.json();
        return data.posts;
    } catch (error) {
        console.error('Error fetching posts with fetch:', error);
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
        return await fetchPostsWithFetch(options);
    } catch (error) {
        console.error('Error fetching posts:', error);
        return [];
    }
}

export async function getPostBySlug(slug: string): Promise<GhostPost | null> {
    try {
        const response = await fetch(
            `${GHOST_URL}/ghost/api/content/posts/slug/${slug}/?key=${GHOST_KEY}`,
            { next: { revalidate: 3600 } }
        );
        const data = await response.json();
        return data.posts[0] || null;
    } catch (error) {
        console.error('Error fetching post by slug:', error);
        return null;
    }
}

export async function getPostsByTag(tag: string, options = { limit: 10 }): Promise<GhostPost[]> {
    try {
        const response = await fetch(
            `${GHOST_URL}/ghost/api/content/posts/?key=${GHOST_KEY}&limit=${options.limit}&filter=tag:${tag}`,
            { next: { revalidate: 3600 } }
        );
        const data = await response.json();
        return data.posts;
    } catch (error) {
        console.error('Error fetching posts by tag:', error);
        return [];
    }
}
