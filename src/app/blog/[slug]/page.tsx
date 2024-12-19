import { fetchBlogPosts } from '@/utils/rss';
import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import BlogImage from '@/components/BlogImage';
import { JsonLd } from '@/components/JsonLd';

interface BlogPostPageProps {
  params: {
    slug: string;
  };
}

export const dynamic = 'force-dynamic';
export const revalidate = 3600; // Revalidate every hour

export async function generateMetadata({ params }: BlogPostPageProps): Promise<Metadata> {
  try {
    const feed = await fetchBlogPosts();
    const post = feed.items.find(item => item.slug === params.slug);
    
    if (!post) {
      return {
        title: 'Post Not Found',
      };
    }

    const title = post.meta_title || post.title;
    const description = post.meta_description || post.html?.substring(0, 160);

    return {
      title,
      description,
      openGraph: {
        title: post.og_title || title,
        description: post.og_description || description,
        images: post.og_image ? [post.og_image] : undefined,
        type: 'article',
        article: {
          publishedTime: post.published_at,
          authors: ['Denver Contractors'],
          tags: post.categories,
        },
      },
      twitter: {
        card: 'summary_large_image',
        title: post.og_title || title,
        description: post.og_description || description,
        images: post.og_image ? [post.og_image] : undefined,
      },
    };
  } catch (error) {
    console.error('Error generating metadata:', error);
    return {
      title: 'Blog Post',
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
  let feed;
  try {
    feed = await fetchBlogPosts();
  } catch (error) {
    console.error('Error fetching blog posts:', error);
    return notFound();
  }

  const post = feed.items.find(item => item.slug === params.slug);

  if (!post) {
    return notFound();
  }

  const postUrl = `https://topcontractorsdenver.com/blog/${post.slug}`;
  
  // Create structured data for the blog post
  const blogPostSchema: BlogPostSchema = {
    "@context": "https://schema.org",
    "@type": "BlogPosting",
    headline: post.title,
    description: post.meta_description,
    image: post.feature_image,
    datePublished: post.published_at,
    dateModified: post.published_at, // Update if you have modified date
    author: {
      "@type": "Organization",
      name: "Denver Contractors",
      url: "https://topcontractorsdenver.com"
    },
    publisher: {
      "@type": "Organization",
      name: "Denver Contractors",
      logo: {
        "@type": "ImageObject",
        url: "https://topcontractorsdenver.com/logo.png" // Make sure this exists
      }
    },
    mainEntityOfPage: {
      "@type": "WebPage",
      "@id": postUrl
    },
    keywords: post.categories
  };

  return (
    <>
      <JsonLd data={blogPostSchema} />
      <main className="min-h-screen bg-gray-50">
        <article 
          className="container mx-auto px-4 py-12 max-w-4xl"
          itemScope 
          itemType="https://schema.org/BlogPosting"
        >
          {post.feature_image && (
            <div className="h-96 mb-8 rounded-xl overflow-hidden">
              <BlogImage
                src={post.feature_image}
                alt={post.title}
                className="object-cover"
                priority
              />
            </div>
          )}
          
          <h1 
            className="text-4xl md:text-5xl font-bold mb-4 text-gray-900"
            itemProp="headline"
          >
            {post.title}
          </h1>
          
          <div 
            className="mb-8 text-gray-500"
            itemProp="datePublished"
            content={post.published_at}
          >
            {new Date(post.published_at).toLocaleDateString('en-US', {
              year: 'numeric',
              month: 'long',
              day: 'numeric'
            })}
          </div>

          {post.categories.length > 0 && (
            <div className="flex flex-wrap gap-2 mb-8">
              {post.categories.map((category, index) => (
                <span
                  key={`category-${index}-${category}`}
                  className="px-3 py-1 text-sm bg-blue-100 text-blue-800 rounded-full"
                  itemProp="keywords"
                >
                  {category}
                </span>
              ))}
            </div>
          )}

          <div 
            className="prose prose-lg max-w-none"
            dangerouslySetInnerHTML={{ __html: post.html }}
            itemProp="articleBody"
          />

          <meta itemProp="author" content="Denver Contractors" />
          <meta itemProp="publisher" content="Denver Contractors" />
          <link itemProp="mainEntityOfPage" href={postUrl} />
        </article>
      </main>
    </>
  );
}
