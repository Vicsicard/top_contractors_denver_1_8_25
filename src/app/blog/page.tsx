import { Metadata } from 'next';
import Link from 'next/link';
import Image from 'next/image';
import { getPosts, GhostPost } from '@/utils/ghost';

export const metadata: Metadata = {
    title: 'Contractor Blog - Home Improvement Tips & Guides',
    description: 'Expert advice, tips, and guides for home improvement projects. Find local contractors in Denver, Aurora, Broomfield, and surrounding areas.',
    keywords: 'home improvement blog, contractor tips, Denver contractors, Aurora plumbers, Broomfield remodelers, home renovation guides',
};

export const revalidate = 3600; // Revalidate every hour

export default async function BlogPage() {
    console.log('Fetching blog posts...');
    const posts = await getPosts({ limit: 12 });
    console.log('Fetched posts:', posts);

    if (!posts || posts.length === 0) {
        return (
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                <h1 className="text-4xl font-bold text-gray-900 mb-8">Contractor Blog</h1>
                <p className="text-gray-600">No blog posts found.</p>
            </div>
        );
    }

    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <h1 className="text-4xl font-bold text-gray-900 mb-8">Contractor Blog</h1>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {posts.map((post: GhostPost) => (
                    <article key={post.id} className="bg-white rounded-lg shadow-md overflow-hidden">
                        {post.feature_image && (
                            <div className="relative h-48">
                                <Image
                                    src={post.feature_image}
                                    alt={post.title}
                                    fill
                                    className="object-cover"
                                />
                            </div>
                        )}
                        <div className="p-6">
                            <h2 className="text-xl font-semibold text-gray-900 mb-2">
                                <Link href={`/blog/${post.slug}`} className="hover:text-blue-600">
                                    {post.title}
                                </Link>
                            </h2>
                            <p className="text-gray-600 mb-4 line-clamp-3">{post.excerpt}</p>
                            <div className="flex items-center justify-between text-sm text-gray-500">
                                <span>{new Date(post.published_at).toLocaleDateString()}</span>
                                <span>{post.reading_time} min read</span>
                            </div>
                            {post.tags && post.tags.length > 0 && (
                                <div className="mt-4 flex flex-wrap gap-2">
                                    {post.tags.map(tag => (
                                        <Link
                                            key={tag.slug}
                                            href={`/blog/tag/${tag.slug}`}
                                            className="text-xs bg-gray-100 text-gray-600 px-2 py-1 rounded-full hover:bg-gray-200"
                                        >
                                            {tag.name}
                                        </Link>
                                    ))}
                                </div>
                            )}
                        </div>
                    </article>
                ))}
            </div>
        </div>
    );
}
