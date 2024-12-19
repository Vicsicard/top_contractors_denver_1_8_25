import { fetchBlogPosts } from '@/utils/rss';
import Link from 'next/link';
import BlogImage from '@/components/BlogImage';
import { Metadata } from 'next';
import { JsonLd } from '@/components/JsonLd';

export const metadata: Metadata = {
  title: 'Denver Contractors Blog - Expert Tips & Industry Insights',
  description: 'Stay informed with the latest construction and home improvement insights from Denver\'s top contractors. Expert tips, industry trends, and local project showcases.',
  openGraph: {
    title: 'Denver Contractors Blog - Expert Tips & Industry Insights',
    description: 'Stay informed with the latest construction and home improvement insights from Denver\'s top contractors. Expert tips, industry trends, and local project showcases.',
    type: 'website',
    locale: 'en_US',
  },
};

export const dynamic = 'force-dynamic';
export const revalidate = 3600; // Revalidate every hour

interface BlogListSchema {
  "@context": "https://schema.org";
  "@type": "Blog";
  name: string;
  description: string;
  url: string;
  blogPost: Array<{
    "@type": "BlogPosting";
    headline: string;
    description?: string;
    image?: string;
    datePublished: string;
    author: {
      "@type": "Organization";
      name: string;
    };
    publisher: {
      "@type": "Organization";
      name: string;
      logo: {
        "@type": "ImageObject";
        url: string;
      };
    };
  }>;
}

export default async function BlogPage() {
  let feed;
  try {
    feed = await fetchBlogPosts();
  } catch (error) {
    console.error('Error fetching blog posts:', error);
    // Return a fallback UI when feed is not available
    return (
      <main className="min-h-screen bg-gray-50">
        <div className="container mx-auto px-4 py-12">
          <h1 className="text-4xl font-bold mb-8 text-gray-900">Blog</h1>
          <p className="text-lg mb-12 text-gray-600">Coming soon! Check back later for our latest articles.</p>
        </div>
      </main>
    );
  }

  // Create structured data for the blog list
  const blogListSchema: BlogListSchema = {
    "@context": "https://schema.org",
    "@type": "Blog",
    name: "Denver Contractors Blog",
    description: "Expert insights and tips from Denver's top contractors",
    url: "https://topcontractorsdenver.com/blog",
    blogPost: feed.items.map(post => ({
      "@type": "BlogPosting",
      headline: post.title,
      description: post.meta_description,
      image: post.feature_image,
      datePublished: post.published_at,
      author: {
        "@type": "Organization",
        name: "Denver Contractors"
      },
      publisher: {
        "@type": "Organization",
        name: "Denver Contractors",
        logo: {
          "@type": "ImageObject",
          url: "https://topcontractorsdenver.com/logo.png" // Make sure this exists
        }
      }
    }))
  };
  
  return (
    <>
      <JsonLd data={blogListSchema} />
      <main className="min-h-screen bg-gray-50">
        <div className="container mx-auto px-4 py-12">
          <h1 className="text-4xl font-bold mb-8 text-gray-900">{feed.title || 'Denver Contractors Blog'}</h1>
          <p className="text-lg mb-12 text-gray-600">
            {feed.description || 'Stay informed with the latest construction and home improvement insights from Denver\'s top contractors. Expert tips, industry trends, and local project showcases.'}
          </p>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {(feed.items || []).map((post, postIndex) => {
              const postKey = `post-${post.slug || postIndex}`;
              return (
                <article 
                  key={postKey} 
                  className="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300"
                  itemScope 
                  itemType="https://schema.org/BlogPosting"
                >
                  {post.feature_image && (
                    <div className="h-48">
                      <BlogImage
                        src={post.feature_image}
                        alt={post.title}
                        className="object-cover"
                      />
                    </div>
                  )}
                  <div className="p-6">
                    <h2 
                      className="text-xl font-semibold mb-2 text-gray-900"
                      itemProp="headline"
                    >
                      <Link 
                        href={`/blog/${post.slug}`} 
                        className="hover:text-blue-600"
                        itemProp="url"
                      >
                        {post.title}
                      </Link>
                    </h2>
                    <div 
                      className="mb-4 text-sm text-gray-500"
                      itemProp="datePublished"
                      content={post.published_at}
                    >
                      {new Date(post.published_at).toLocaleDateString('en-US', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric'
                      })}
                    </div>
                    {(post.categories || []).length > 0 && (
                      <div key={`categories-${postKey}`} className="flex flex-wrap gap-2 mb-4">
                        {post.categories.map((category, categoryIndex) => (
                          <span
                            key={`${postKey}-category-${categoryIndex}-${category}`}
                            className="px-2 py-1 text-sm bg-blue-100 text-blue-800 rounded-full"
                            itemProp="keywords"
                          >
                            {category}
                          </span>
                        ))}
                      </div>
                    )}
                    <div 
                      className="text-gray-600 line-clamp-3" 
                      dangerouslySetInnerHTML={{ 
                        __html: post.meta_description || (post.html && post.html.substring(0, 150) + '...') || ''
                      }}
                      itemProp="description"
                    />
                  </div>
                </article>
              );
            })}
          </div>
        </div>
      </main>
    </>
  );
}
