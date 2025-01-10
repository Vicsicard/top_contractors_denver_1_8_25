import { tradesData } from "@/lib/trades-data";
import { MetadataRoute } from "next";
import { getLocations } from "@/lib/locations";
import { getAllPosts } from "@/lib/ghost-client";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://topcontractorsdenver.com";
  
  // Get all locations
  const locations = await getLocations();
  
  // Get all blog posts
  const posts = await getAllPosts();

  // Create sitemap entries for all trades
  const tradeEntries = Object.keys(tradesData).map((trade) => ({
    url: `${baseUrl}/trades/${trade}`,
    lastModified: new Date(),
    changeFrequency: "weekly" as const,
    priority: 0.8,
  }));

  // Create sitemap entries for all locations
  const locationEntries = locations.map((location) => ({
    url: `${baseUrl}/trades/${location.trade}/${location.region}`,
    lastModified: new Date(),
    changeFrequency: "weekly" as const,
    priority: 0.7,
  }));

  // Create sitemap entries for all blog posts
  const blogEntries = posts.map((post) => ({
    url: `${baseUrl}/blog/${post.slug}`,
    lastModified: new Date(post.updated_at || post.published_at),
    changeFrequency: "monthly" as const,
    priority: 0.6,
  }));

  // Create sitemap entries for static pages
  const staticPages = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "daily" as const,
      priority: 1,
    },
    {
      url: `${baseUrl}/blog`,
      lastModified: new Date(),
      changeFrequency: "daily" as const,
      priority: 0.9,
    },
    // Add any other static pages here
  ];

  return [
    ...staticPages,
    ...tradeEntries,
    ...locationEntries,
    ...blogEntries,
  ];
}
