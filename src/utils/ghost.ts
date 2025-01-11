const GHOST_URL = process.env.GHOST_URL || 'https://top-contractors-denver-1.ghost.io';
const GHOST_KEY = process.env['GHOST.ORG_CONTENT_API_KEY'] || '950228587820493fa1f65f9b17';

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

export interface PaginatedPosts {
    posts: GhostPost[];
    totalPages: number;
    currentPage: number;
    hasNextPage: boolean;
    hasPrevPage: boolean;
}

export async function getPosts(page = 1, limit = 10): Promise<PaginatedPosts> {
    try {
        const response = await fetch(
            `${GHOST_URL}/ghost/api/content/posts/?key=${GHOST_KEY}&limit=${limit}&page=${page}&include=tags`,
            { next: { revalidate: 3600 } }
        );
        const data = await response.json();
        
        return {
            posts: data.posts || [],
            totalPages: Math.ceil(data.meta.pagination.total / limit),
            currentPage: page,
            hasNextPage: data.meta.pagination.next !== null,
            hasPrevPage: data.meta.pagination.prev !== null
        };
    } catch (error) {
        console.error('Error fetching posts:', error);
        return {
            posts: [],
            totalPages: 0,
            currentPage: 1,
            hasNextPage: false,
            hasPrevPage: false
        };
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

export async function getPostsByTag(tag: string, page = 1, limit = 10): Promise<PaginatedPosts> {
    try {
        const response = await fetch(
            `${GHOST_URL}/ghost/api/content/posts/?key=${GHOST_KEY}&limit=${limit}&page=${page}&filter=tag:${tag}`,
            { next: { revalidate: 3600 } }
        );
        const data = await response.json();
        
        return {
            posts: data.posts || [],
            totalPages: Math.ceil(data.meta.pagination.total / limit),
            currentPage: page,
            hasNextPage: data.meta.pagination.next !== null,
            hasPrevPage: data.meta.pagination.prev !== null
        };
    } catch (error) {
        console.error('Error fetching posts by tag:', error);
        return {
            posts: [],
            totalPages: 0,
            currentPage: 1,
            hasNextPage: false,
            hasPrevPage: false
        };
    }
}
