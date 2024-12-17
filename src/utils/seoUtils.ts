import { Business } from '@prisma/client';

export function generateSlug(business: Business): string {
  // Convert business name to lowercase and replace spaces/special chars with hyphens
  return business.name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '');
}

export function generateMetadata(business: Business) {
  const categories = business.categories?.join(', ') || '';
  const rating = business.rating ? `${business.rating} stars` : '';
  const reviews = business.reviewCount ? `(${business.reviewCount} reviews)` : '';

  return {
    title: `${business.name} - Denver Contractor ${rating} ${reviews}`,
    description: `${business.name} is a trusted Denver contractor specializing in ${categories}. Located at ${business.address}. Contact us at ${business.phone || 'our website'}.`,
    keywords: [
      'Denver Contractor',
      'Colorado Contractor',
      ...(business.categories || []),
      business.name,
      'Denver',
      'Construction',
      'Remodeling'
    ].join(', '),
    openGraph: {
      title: `${business.name} - Top Denver Contractor`,
      description: `Trusted Denver contractor with ${rating} ${reviews}. Specializing in ${categories}.`,
      type: 'website',
      url: `https://www.topcontractorsdenver.com/contractor/${generateSlug(business)}`,
    },
  };
}
