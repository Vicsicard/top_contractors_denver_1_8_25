import { MetadataRoute } from "next"
import { getAllTrades, getAllSubregions } from "@/utils/database"
import { getAllPosts } from "@/utils/ghost"

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://topcontractorsdenver.com"
  
  // Get all trades, subregions, and blog posts
  const [trades, subregions, posts] = await Promise.all([
    getAllTrades(),
    getAllSubregions(),
    getAllPosts()
  ])

  // Create sitemap entries for static pages
  const staticPages = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "monthly" as const,
      priority: 1,
    },
    {
      url: `${baseUrl}/services`,
      lastModified: new Date(),
      changeFrequency: "monthly" as const,
      priority: 0.9,
    },
    {
      url: `${baseUrl}/blog`,
      lastModified: new Date(),
      changeFrequency: "daily" as const, // Blog index changes daily with new posts
      priority: 0.9,
    },
  ]

  // Create sitemap entries for trade pages
  const tradePages = trades.map((trade) => ({
    url: `${baseUrl}/services/${trade.slug}`,
    lastModified: new Date(),
    changeFrequency: "monthly" as const,
    priority: 0.8,
  }))

  // Create sitemap entries for location-specific pages
  const locationPages = trades.flatMap((trade) =>
    subregions.map((subregion) => ({
      url: `${baseUrl}/services/${trade.slug}/${subregion.slug}`,
      lastModified: new Date(),
      changeFrequency: "monthly" as const,
      priority: 0.7,
    }))
  )

  // Create sitemap entries for blog posts
  const blogPages = posts.map((post) => ({
    url: `${baseUrl}/blog/${post.slug}`,
    lastModified: new Date(post.updated_at || post.published_at),
    changeFrequency: "daily" as const, // Individual blog posts might get comments or updates
    priority: 0.6,
  }))

  // Create sitemap entries for blog tag pages
  const uniqueTags = new Set(posts.flatMap(post => post.tags?.map(tag => tag.slug) || []))
  const tagPages = Array.from(uniqueTags).map((tagSlug) => ({
    url: `${baseUrl}/blog/tag/${tagSlug}`,
    lastModified: new Date(),
    changeFrequency: "daily" as const, // Tag pages update with new posts
    priority: 0.5,
  }))

  return [...staticPages, ...tradePages, ...locationPages, ...blogPages, ...tagPages]
}
