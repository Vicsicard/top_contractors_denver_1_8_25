import { MetadataRoute } from 'next';

// Static categories for initial sitemap
const categories = [
  'Home-Remodeling',
  'Kitchen-Remodeling',
  'Bathroom-Remodeling',
  'General-Contractor',
  'Custom-Homes',
  'Handyman',
  'Landscaping',
  'Roofing',
  'Painting',
  'Plumbing',
  'Electrical',
  'HVAC'
];

// Static locations
const locations = [
  'Denver',
  'Aurora',
  'Lakewood',
  'Arvada',
  'Westminster',
  'Thornton',
  'Centennial',
  'Highlands-Ranch',
  'Boulder',
  'Littleton'
];

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = 'https://www.topcontractorsdenver.com';
  const currentDate = new Date().toISOString();

  // Core pages
  const coreRoutes = [
    {
      url: baseUrl,
      lastModified: currentDate,
      changeFrequency: 'daily' as const,
      priority: 1,
    },
    {
      url: `${baseUrl}/search`,
      lastModified: currentDate,
      changeFrequency: 'daily' as const,
      priority: 0.8,
    }
  ];

  // Category pages
  const categoryRoutes = categories.map(category => ({
    url: `${baseUrl}/search/${category}`,
    lastModified: currentDate,
    changeFrequency: 'weekly' as const,
    priority: 0.7,
  }));

  // Location pages
  const locationRoutes = locations.map(location => ({
    url: `${baseUrl}/search/${location}`,
    lastModified: currentDate,
    changeFrequency: 'weekly' as const,
    priority: 0.7,
  }));

  // Combine all routes
  return [
    ...coreRoutes,
    ...categoryRoutes,
    ...locationRoutes,
  ];
}