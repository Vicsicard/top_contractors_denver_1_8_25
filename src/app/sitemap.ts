import { tradesData } from "@/lib/trades-data";
import { MetadataRoute } from "next";
import { denverRegions } from "@/lib/locations";

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://topcontractorsdenver.com";
  
  // Create sitemap entries for all trades
  const tradeEntries = Object.keys(tradesData).map((trade) => ({
    url: `${baseUrl}/trades/${trade}`,
    lastModified: new Date(),
    changeFrequency: "weekly" as const,
    priority: 0.8,
  }));

  // Create sitemap entries for all locations
  const locationEntries = Object.entries(denverRegions).flatMap(([region, data]) =>
    Object.entries(data.areas).map(([area]) => ({
      url: `${baseUrl}/trades/painters/${region}/${area}`,
      lastModified: new Date(),
      changeFrequency: "weekly" as const,
      priority: 0.7,
    }))
  );

  // Create sitemap entries for static pages
  const staticPages = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "daily" as const,
      priority: 1,
    },
  ];

  return [...staticPages, ...tradeEntries, ...locationEntries];
}
