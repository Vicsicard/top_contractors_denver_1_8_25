import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import BlogImage from '@/components/BlogImage';
import { JsonLd } from '@/components/JsonLd';
import { api } from '@/utils/ghost';

interface BlogPostPageProps {
  params: {
    slug: string;
  };
}

export const dynamic = 'force-dynamic';
export const revalidate = 3600; // Revalidate every hour

export async function generateMetadata({ params }: BlogPostPageProps): Promise<Metadata> {
  try {
    const post = await api.posts.read({ slug: params.slug });
    
    if (!post) {
      return {
        title: 'Post Not Found',
        description: 'The requested blog post could not be found.',
      };
    }

    return {
      title: `${post.title} | Top Contractors Denver Blog`,
      description: post.excerpt || post.meta_description || `Read about ${post.title} on Top Contractors Denver`,
      openGraph: {
        title: post.title,
        description: post.excerpt || post.meta_description || '',
        url: `https://www.topcontractorsdenver.com/blog/${post.slug}`,
        siteName: 'Top Contractors Denver',
        locale: 'en_US',
        type: 'article',
        ...(post.feature_image && {
          images: [{
            url: post.feature_image,
            width: 1200,
            height: 630,
            alt: post.title,
          }],
        }),
      },
    };
  } catch (error) {
    console.error('Error fetching blog post metadata:', error);
    return {
      title: 'Blog Post',
      description: 'Top Contractors Denver Blog',
    };
  }
}

interface BlogPostSchema {
  "@context": "https://schema.org";
  "@type": "BlogPosting";
  headline: string;
  description?: string;
  image?: string;
  datePublished: string;
  dateModified?: string;
  author: {
    "@type": "Organization";
    name: string;
    url: string;
  };
  publisher: {
    "@type": "Organization";
    name: string;
    logo: {
      "@type": "ImageObject";
      url: string;
    };
  };
  mainEntityOfPage: {
    "@type": "WebPage";
    "@id": string;
  };
  keywords?: string[];
}

export default async function BlogPostPage({ params }: BlogPostPageProps) {
  try {
    const post = await api.posts.read({ slug: params.slug });

    if (!post) {
      notFound();
    }

    const schema: BlogPostSchema = {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      headline: post.title,
      description: post.excerpt || post.meta_description || '',
      image: post.feature_image || undefined,
      datePublished: post.published_at || '',
      dateModified: post.updated_at || undefined,
      author: {
        "@type": "Organization",
        name: "Top Contractors Denver",
        url: "https://www.topcontractorsdenver.com"
      },
      publisher: {
        "@type": "Organization",
        name: "Top Contractors Denver",
        logo: {
          "@type": "ImageObject",
          url: "https://www.topcontractorsdenver.com/logo.png"
        }
      },
      mainEntityOfPage: {
        "@type": "WebPage",
        "@id": `https://www.topcontractorsdenver.com/blog/${post.slug}`
      },
      keywords: post.tags?.map(tag => tag.name) || undefined
    };

    return (
      <article className="max-w-4xl mx-auto px-4 py-8">
        <JsonLd data={schema} />
        
        <h1 className="text-4xl font-bold mb-4">{post.title}</h1>
        
        {post.feature_image && (
          <div className="mb-8">
            <BlogImage
              src={post.feature_image}
              alt={post.title}
              width={1200}
              height={630}
              className="rounded-lg shadow-lg"
            />
          </div>
        )}

        <div 
          className="prose prose-lg max-w-none"
          dangerouslySetInnerHTML={{ __html: post.html || '' }}
        />
      </article>
    );
  } catch (error) {
    console.error('Error fetching blog post:', error);
    notFound();
  }
}
