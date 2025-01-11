import { Metadata } from 'next';
import Link from 'next/link';
import { getPosts, GhostPost } from '@/utils/ghost';
import Image from 'next/image';

export const metadata: Metadata = {
    title: 'Contractor Blog - Home Improvement Tips & Guides',
    description: 'Expert advice, tips, and guides for home improvement projects. Find local contractors in Denver, Aurora, Broomfield, and surrounding areas.',
    keywords: 'home improvement blog, contractor tips, Denver contractors, Aurora plumbers, Broomfield remodelers, home renovation guides',
};

export const revalidate = 3600; // Revalidate every hour

interface Props {
    searchParams: { page?: string };
}

export default async function BlogPage({ searchParams }: Props) {
    const currentPage = Number(searchParams.page) || 1;
    const { posts, totalPages, hasNextPage, hasPrevPage } = await getPosts(currentPage);

    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <h1 className="text-4xl font-bold text-gray-900 mb-8">Blog</h1>
            
            {posts.length === 0 ? (
                <p className="text-lg text-gray-600 mb-8">
                    No posts available at the moment. Check back soon for expert advice and tips!
                </p>
            ) : (
                <>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-12">
                        {posts.map((post: GhostPost) => (
                            <Link href={`/blog/${post.slug}`} key={post.id} className="group">
                                <article className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                                    {post.feature_image && (
                                        <div className="relative h-48 w-full">
                                            <Image
                                                src={post.feature_image}
                                                alt={post.title}
                                                fill
                                                className="object-cover"
                                            />
                                        </div>
                                    )}
                                    <div className="p-6">
                                        <h2 className="text-xl font-semibold text-gray-900 group-hover:text-blue-600 transition-colors mb-2">
                                            {post.title}
                                        </h2>
                                        {post.excerpt && (
                                            <p className="text-gray-600 line-clamp-2 mb-4">{post.excerpt}</p>
                                        )}
                                        <div className="flex items-center text-sm text-gray-500">
                                            <time dateTime={post.published_at}>
                                                {new Date(post.published_at).toLocaleDateString()}
                                            </time>
                                            <span className="mx-2">•</span>
                                            <span>{post.reading_time} min read</span>
                                        </div>
                                    </div>
                                </article>
                            </Link>
                        ))}
                    </div>

                    {/* Pagination */}
                    {totalPages > 1 && (
                        <div className="flex justify-center items-center gap-4">
                            {hasPrevPage && (
                                <Link
                                    href={`/blog?page=${currentPage - 1}`}
                                    className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50"
                                >
                                    Previous
                                </Link>
                            )}
                            
                            <div className="flex items-center gap-2">
                                {Array.from({ length: totalPages }, (_, i) => i + 1).map((pageNum) => (
                                    <Link
                                        key={pageNum}
                                        href={`/blog?page=${pageNum}`}
                                        className={`px-4 py-2 text-sm font-medium rounded-md ${
                                            pageNum === currentPage
                                                ? 'bg-blue-600 text-white'
                                                : 'text-gray-700 bg-white border border-gray-300 hover:bg-gray-50'
                                        }`}
                                    >
                                        {pageNum}
                                    </Link>
                                ))}
                            </div>

                            {hasNextPage && (
                                <Link
                                    href={`/blog?page=${currentPage + 1}`}
                                    className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50"
                                >
                                    Next
                                </Link>
                            )}
                        </div>
                    )}
                </>
            )}
        </div>
    );
}
