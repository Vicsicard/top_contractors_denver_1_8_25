import { tradesData } from "@/lib/trades-data";
import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://yourwebsite.com";

  // Create sitemap entries for all trades
  const tradeEntries = Object.keys(tradesData).map((trade) => ({
    url: `${baseUrl}/${trade}`,
    lastModified: new Date(),
    changeFrequency: "weekly" as const,
    priority: 0.8,
  }));

  return [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: "daily",
      priority: 1,
    },
    ...tradeEntries,
  ];
}
