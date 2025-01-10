interface SchemaParams {
  trade?: string;
  subregion?: string;
  isHomePage?: boolean;
}

export function generateOrganizationSchema() {
  return {
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: 'Top Contractors Denver',
    url: 'https://topcontractorsdenver.com',
    logo: 'https://topcontractorsdenver.com/logo.png',
    description: 'Find the best local contractors in Denver. Compare verified reviews, ratings, and get free quotes.',
    address: {
      '@type': 'PostalAddress',
      addressLocality: 'Denver',
      addressRegion: 'CO',
      postalCode: '80202',
      addressCountry: 'US'
    },
    contactPoint: {
      '@type': 'ContactPoint',
      telephone: '+1-303-555-0123',
      contactType: 'customer service',
      areaServed: 'Denver Metropolitan Area',
      availableLanguage: ['English', 'Spanish']
    },
    sameAs: [
      'https://www.facebook.com/topcontractorsdenver',
      'https://twitter.com/denvercontractor',
      'https://www.linkedin.com/company/top-contractors-denver'
    ]
  };
}

export function generateLocalBusinessSchema({ trade, subregion }: SchemaParams) {
  const baseSchema = {
    '@context': 'https://schema.org',
    '@type': 'LocalBusiness',
    name: trade ? `${trade} in Denver` : 'Top Contractors Denver',
    description: trade 
      ? `Find the best ${trade.toLowerCase()} in ${subregion ? `${subregion}, ` : ''}Denver. Compare local contractors, read verified reviews, and get free quotes.`
      : 'Find the best local contractors in Denver. Compare verified reviews, ratings, and get free quotes.',
    url: 'https://topcontractorsdenver.com',
    telephone: '+1-303-555-0123',
    areaServed: {
      '@type': 'City',
      name: 'Denver',
      '@id': 'https://www.wikidata.org/wiki/Q16554'
    },
    geo: {
      '@type': 'GeoCoordinates',
      latitude: 39.7392,
      longitude: -104.9903
    },
    aggregateRating: {
      '@type': 'AggregateRating',
      ratingValue: '4.8',
      reviewCount: '150'
    }
  };

  if (trade) {
    return {
      ...baseSchema,
      '@type': 'Service',
      serviceType: trade,
      provider: generateOrganizationSchema()
    };
  }

  return baseSchema;
}

export function generateFAQSchema(faqs: Array<{ question: string; answer: string }>) {
  return {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map(faq => ({
      '@type': 'Question',
      name: faq.question,
      acceptedAnswer: {
        '@type': 'Answer',
        text: faq.answer
      }
    }))
  };
}

export function generateBreadcrumbSchema({ trade, subregion }: SchemaParams) {
  const items = [
    {
      '@type': 'ListItem',
      position: 1,
      name: 'Home',
      item: 'https://topcontractorsdenver.com'
    }
  ];

  if (trade) {
    items.push({
      '@type': 'ListItem',
      position: 2,
      name: trade,
      item: `https://topcontractorsdenver.com/trades/${trade.toLowerCase().replace(/ /g, '-')}`
    });
  }

  if (subregion) {
    items.push({
      '@type': 'ListItem',
      position: 3,
      name: subregion,
      item: `https://topcontractorsdenver.com/trades/${trade?.toLowerCase().replace(/ /g, '-')}/${subregion.toLowerCase().replace(/ /g, '-')}`
    });
  }

  return {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: items
  };
}
