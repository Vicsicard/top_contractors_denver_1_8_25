import GhostContentAPI from '@tryghost/content-api';

const ghostUrl = process.env.GHOST_URL;
const ghostKey = process.env.GHOST_ORG_CONTENT_API_KEY;

if (!ghostUrl || !ghostKey) {
  console.error('Ghost configuration missing:', {
    hasUrl: !!ghostUrl,
    hasKey: !!ghostKey
  });
}

// Create API instance with site credentials
const api = new GhostContentAPI({
    url: ghostUrl || '',
    key: ghostKey || '',
    version: 'v5.0'
});

export interface GhostPost {
    id: string;
    title: string;
    slug: string;
    html: string;
    feature_image: string | null;
    meta_title: string | null;
    meta_description: string | null;
    og_image: string | null;
    og_title: string | null;
    og_description: string | null;
    published_at: string;
    tags: Array<{ name: string }>;
}

export async function fetchBlogPosts() {
    try {
        const posts = await api.posts
            .browse({
                limit: 'all',
                include: ['tags'],
                fields: [
                    'id',
                    'title',
                    'slug',
                    'html',
                    'feature_image',
                    'meta_title',
                    'meta_description',
                    'og_image',
                    'og_title',
                    'og_description',
                    'published_at'
                ]
            });

        return {
            items: posts.map(post => ({
                ...post,
                categories: post.tags?.map(tag => tag.name) || []
            })),
            title: 'Denver Contractors Blog',
            description: 'Expert insights and tips from Denver\'s top contractors',
            link: process.env.GHOST_URL
        };
    } catch (error) {
        console.error('Error fetching Ghost posts:', error);
        throw new Error('Failed to fetch blog posts');
    }
}
