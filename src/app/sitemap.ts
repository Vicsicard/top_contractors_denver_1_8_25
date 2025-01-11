import { MetadataRoute } from "next"
import { getAllTrades, getAllSubregions } from "@/utils/database"

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://topcontractorsdenver.com"
  
  // Get all trades and subregions
  const [trades, subregions] = await Promise.all([
    getAllTrades(),
    getAllSubregions()
  ])

  // Create sitemap entries for static pages
  const staticPages = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "daily" as const,
      priority: 1,
    },
    {
      url: `${baseUrl}/services`,
      lastModified: new Date(),
      changeFrequency: "daily" as const,
      priority: 0.9,
    },
  ]

  // Create sitemap entries for trade pages
  const tradePages = trades.map((trade) => ({
    url: `${baseUrl}/services/${trade.slug}`,
    lastModified: new Date(),
    changeFrequency: "weekly" as const,
    priority: 0.8,
  }))

  // Create sitemap entries for location-specific pages
  const locationPages = trades.flatMap((trade) =>
    subregions.map((subregion) => ({
      url: `${baseUrl}/services/${trade.slug}/${subregion.slug}`,
      lastModified: new Date(),
      changeFrequency: "weekly" as const,
      priority: 0.7,
    }))
  )

  return [...staticPages, ...tradePages, ...locationPages]
}
