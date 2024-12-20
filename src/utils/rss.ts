import { BlogPost, RSSFeedResponse } from '@/types/blog';
import { XMLParser } from 'fast-xml-parser';

const RSS_URL = 'https://top-contractors-denver.ghost.io/c36da403a913b9a47563b6235f0016/rss';
const CACHE_TIME = 3600; // 1 hour in seconds

let cachedData: RSSFeedResponse | null = null;
let lastFetchTime = 0;

interface RSSItem {
  guid: string;
  title: string;
  link: string;
  'content:encoded': string;
  'media:content'?: {
    '@_url': string;
  };
  meta_title?: string;
  meta_description?: string;
  og_image?: string;
  og_title?: string;
  og_description?: string;
  pubDate: string;
  category: string | string[];
}

interface RSSChannel {
  item: RSSItem[];
  title: string;
  description: string;
  link: string;
}

interface RSSData {
  rss: {
    channel: RSSChannel;
  };
}

export async function fetchBlogPosts(): Promise<RSSFeedResponse> {
  const now = Date.now();
  
  // Return cached data if it's still fresh
  if (cachedData && (now - lastFetchTime) / 1000 < CACHE_TIME) {
    return cachedData;
  }

  try {
    const response = await fetch(RSS_URL);
    const xmlData = await response.text();
    
    const parser = new XMLParser({
      ignoreAttributes: false,
      attributeNamePrefix: "@_"
    });
    
    const result = parser.parse(xmlData) as RSSData;
    const channel = result.rss.channel;
    
    const posts: BlogPost[] = channel.item.map((item: RSSItem) => ({
      id: item.guid,
      title: item.title,
      slug: item.link.split('/').pop() || '',
      html: item['content:encoded'],
      feature_image: item['media:content']?.['@_url'],
      meta_title: item.meta_title,
      meta_description: item.meta_description,
      og_image: item.og_image,
      og_title: item.og_title,
      og_description: item.og_description,
      published_at: item.pubDate,
      categories: Array.isArray(item.category) ? item.category : [item.category]
    }));

    const feed: RSSFeedResponse = {
      items: posts,
      title: channel.title,
      description: channel.description,
      link: channel.link
    };

    // Update cache
    cachedData = feed;
    lastFetchTime = now;

    return feed;
  } catch (error) {
    console.error('Error fetching RSS feed:', error);
    throw new Error('Failed to fetch blog posts');
  }
}
