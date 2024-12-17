import { MetadataRoute } from 'next';
import { PrismaClient } from '@prisma/client';
import { generateSlug } from '@/utils/seoUtils';

const prisma = new PrismaClient();

// Get all contractors from the database
async function getAllContractors() {
  return await prisma.business.findMany();
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  // Always use the custom domain
  const baseUrl = 'https://topcontractorsdenver.com';
  
  // Get all contractors
  const contractors = await getAllContractors();
  
  // Generate sitemap entries for contractor pages
  const contractorRoutes = contractors.map((contractor) => ({
    url: `${baseUrl}/contractor/${generateSlug(contractor)}`,
    lastModified: contractor.updatedAt,
    changeFrequency: 'daily' as const,
    priority: 0.9,
  }));

  // Core pages
  const coreRoutes = [
    {
      url: baseUrl,
      lastModified: new Date(),
      changeFrequency: 'daily' as const,
      priority: 1,
    },
    {
      url: `${baseUrl}/search`,
      lastModified: new Date(),
      changeFrequency: 'daily' as const,
      priority: 0.8,
    }
  ];

  // Common contractor categories
  const categoryRoutes = [
    'Home-Remodeling',
    'Kitchen-Remodeling',
    'Bathroom-Remodeling',
    'General-Contractor',
    'Custom-Homes'
  ].map(category => ({
    url: `${baseUrl}/search/${category}`,
    lastModified: new Date(),
    changeFrequency: 'weekly' as const,
    priority: 0.7,
  }));

  return [
    ...coreRoutes,
    ...categoryRoutes,
    ...contractorRoutes,
  ];
}