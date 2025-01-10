import { Metadata } from 'next';
import Link from 'next/link';
import Image from 'next/image';
import { getPostsByTag, GhostPost } from '@/utils/ghost';

interface Props {
    params: {
        tag: string;
    };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
    const tag = decodeURIComponent(params.tag).replace(/-/g, ' ');
    
    return {
        title: `${tag} Blog Posts | Contractor Blog`,
        description: `Read our latest blog posts about ${tag}. Find expert advice and tips from local contractors in Denver and surrounding areas.`,
        keywords: `${tag}, Denver contractors, home improvement, local contractors, contractor blog`,
    };
}

export default async function TagPage({ params }: Props) {
    const posts = await getPostsByTag(params.tag);
    const tag = decodeURIComponent(params.tag).replace(/-/g, ' ');

    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <header className="mb-12">
                <h1 className="text-4xl font-bold text-gray-900 mb-4">
                    Posts tagged &ldquo;{tag}&rdquo;
                </h1>
                <Link href="/blog" className="text-blue-600 hover:text-blue-800">
                    ← Back to all posts
                </Link>
            </header>
            
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
                        </div>
                    </article>
                ))}
            </div>
            
            {posts.length === 0 && (
                <p className="text-gray-600 text-center py-12">
                    No posts found with this tag.
                </p>
            )}
        </div>
    );
}
