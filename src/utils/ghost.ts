const NEW_GHOST_URL = process.env.GHOST_URL || 'https://top-contractors-denver-2.ghost.io';
const NEW_GHOST_KEY = process.env.GHOST_ORG_CONTENT_API_KEY || '6229b20c390c831641ea577093';

const OLD_GHOST_URL = 'https://top-contractors-denver-1.ghost.io';
const OLD_GHOST_KEY = '130d98b20875066982b1a8314f';

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
    source?: string;
}

export interface PaginatedPosts {
    posts: GhostPost[];
    totalPages: number;
    currentPage: number;
    hasNextPage: boolean;
    hasPrevPage: boolean;
}

async function fetchAllPosts(url: string, key: string): Promise<GhostPost[]> {
    const allPosts: GhostPost[] = [];
    let currentPage = 1;
    const limit = 100; // Maximum allowed by Ghost API
    
    while (true) {
        try {
            const response = await fetch(
                `${url}/ghost/api/content/posts/?key=${key}&limit=${limit}&page=${currentPage}&include=tags`,
                { next: { revalidate: 3600 } }
            );
            
            if (!response.ok) {
                console.error(`Error fetching from ${url} page ${currentPage}:`, response.status);
                break;
            }
            
            const data = await response.json();
            if (!data.posts || data.posts.length === 0) {
                break;
            }
            
            allPosts.push(...data.posts);
            
            if (!data.meta.pagination.next) {
                break;
            }
            
            currentPage++;
        } catch (error) {
            console.error(`Error fetching from ${url} page ${currentPage}:`, error);
            break;
        }
    }
    
    return allPosts;
}

export async function getPosts(page = 1, limit = 10): Promise<PaginatedPosts> {
    try {
        // Fetch all posts from both Ghost instances
        const [newGhostPosts, oldGhostPosts] = await Promise.all([
            fetchAllPosts(NEW_GHOST_URL, NEW_GHOST_KEY),
            fetchAllPosts(OLD_GHOST_URL, OLD_GHOST_KEY)
        ]);

        // Combine and process posts
        const allPosts: GhostPost[] = [];
        
        if (newGhostPosts.length > 0) {
            allPosts.push(...newGhostPosts.map((post: GhostPost) => ({
                ...post,
                source: 'new'
            })));
        }
        
        if (oldGhostPosts.length > 0) {
            allPosts.push(...oldGhostPosts.map((post: GhostPost) => ({
                ...post,
                source: 'old'
            })));
        }

        // Sort posts by date
        allPosts.sort((a, b) => new Date(b.published_at).getTime() - new Date(a.published_at).getTime());

        // Calculate pagination
        const startIndex = (page - 1) * limit;
        const paginatedPosts = allPosts.slice(startIndex, startIndex + limit);
        const totalPages = Math.ceil(allPosts.length / limit);

        return {
            posts: paginatedPosts,
            totalPages,
            currentPage: page,
            hasNextPage: page < totalPages,
            hasPrevPage: page > 1
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
        // Try to fetch from new Ghost first
        const newResponse = await fetch(
            `${NEW_GHOST_URL}/ghost/api/content/posts/slug/${slug}/?key=${NEW_GHOST_KEY}&include=tags`,
            { next: { revalidate: 3600 } }
        );
        
        if (newResponse.ok) {
            const data = await newResponse.json();
            if (data.posts?.[0]) {
                return { ...data.posts[0], source: 'new' };
            }
        }

        // If not found in new Ghost, try old Ghost
        const oldResponse = await fetch(
            `${OLD_GHOST_URL}/ghost/api/content/posts/slug/${slug}/?key=${OLD_GHOST_KEY}&include=tags`,
            { next: { revalidate: 3600 } }
        );
        
        if (oldResponse.ok) {
            const data = await oldResponse.json();
            if (data.posts?.[0]) {
                return { ...data.posts[0], source: 'old' };
            }
        }

        return null;
    } catch (error) {
        console.error('Error fetching post by slug:', error);
        return null;
    }
}

export async function getPostsByTag(tag: string, page = 1, limit = 10): Promise<PaginatedPosts> {
    try {
        // Fetch all posts from both Ghost instances
        const [newGhostPosts, oldGhostPosts] = await Promise.all([
            fetchAllPosts(NEW_GHOST_URL, NEW_GHOST_KEY),
            fetchAllPosts(OLD_GHOST_URL, OLD_GHOST_KEY)
        ]);

        // Combine and process posts, filtering by tag
        const allPosts: GhostPost[] = [];
        
        if (newGhostPosts.length > 0) {
            const filteredPosts = newGhostPosts.filter(post => 
                post.tags?.some(t => t.slug === tag || t.name.toLowerCase() === tag.toLowerCase())
            );
            allPosts.push(...filteredPosts.map(post => ({
                ...post,
                source: 'new'
            })));
        }
        
        if (oldGhostPosts.length > 0) {
            const filteredPosts = oldGhostPosts.filter(post => 
                post.tags?.some(t => t.slug === tag || t.name.toLowerCase() === tag.toLowerCase())
            );
            allPosts.push(...filteredPosts.map(post => ({
                ...post,
                source: 'old'
            })));
        }

        // Sort posts by date
        allPosts.sort((a, b) => new Date(b.published_at).getTime() - new Date(a.published_at).getTime());

        // Calculate pagination
        const startIndex = (page - 1) * limit;
        const paginatedPosts = allPosts.slice(startIndex, startIndex + limit);
        const totalPages = Math.ceil(allPosts.length / limit);

        return {
            posts: paginatedPosts,
            totalPages,
            currentPage: page,
            hasNextPage: page < totalPages,
            hasPrevPage: page > 1
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
