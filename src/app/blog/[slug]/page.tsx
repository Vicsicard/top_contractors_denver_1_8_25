import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import Image from 'next/image';
import Link from 'next/link';
import { getPostBySlug } from '@/utils/ghost';

interface Props {
    params: {
        slug: string;
    };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
    const post = await getPostBySlug(params.slug);
    
    if (!post) {
        return {
            title: 'Post Not Found',
            description: 'The requested blog post could not be found.',
        };
    }

    return {
        title: `${post.title} | Contractor Blog`,
        description: post.excerpt,
        keywords: post.tags?.map(tag => tag.name).join(', '),
        openGraph: {
            title: post.title,
            description: post.excerpt,
            images: post.feature_image ? [post.feature_image] : [],
        },
    };
}

export default async function BlogPost({ params }: Props) {
    const post = await getPostBySlug(params.slug);

    if (!post) {
        notFound();
    }

    return (
        <article className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <header className="mb-8">
                <h1 className="text-4xl font-bold text-gray-900 mb-4">{post.title}</h1>
                <div className="flex items-center gap-4 text-gray-600 mb-6">
                    <time dateTime={post.published_at}>
                        {new Date(post.published_at).toLocaleDateString()}
                    </time>
                    <span>•</span>
                    <span>{post.reading_time} min read</span>
                </div>
                {post.feature_image && (
                    <div className="relative aspect-video mb-8">
                        <Image
                            src={post.feature_image}
                            alt={post.title}
                            fill
                            className="object-cover rounded-lg"
                            priority
                        />
                    </div>
                )}
                {post.tags && post.tags.length > 0 && (
                    <div className="flex flex-wrap gap-2 mb-8">
                        {post.tags.map(tag => (
                            <Link
                                key={tag.slug}
                                href={`/blog/tag/${tag.slug}`}
                                className="text-sm bg-gray-100 text-gray-600 px-3 py-1 rounded-full hover:bg-gray-200"
                            >
                                {tag.name}
                            </Link>
                        ))}
                    </div>
                )}
            </header>
            <div 
                className="prose prose-lg max-w-none"
                dangerouslySetInnerHTML={{ __html: post.html }} 
            />
        </article>
    );
}
