import Head from 'next/head';
import { generateLocalBusinessSchema, generateBreadcrumbSchema } from '../utils/schema';

const BusinessPage = () => {
  // Example data for a local business
  const businessData = {
    "@id": "https://www.topcontractorsdenver.com",
    name: "Top Contractors Denver",
    address: {
      streetAddress: "123 Main St",
      addressLocality: "Denver",
      addressRegion: "CO",
      postalCode: "80202",
      addressCountry: "US"
    },
    geo: {
      latitude: 39.7392,
      longitude: -104.9903
    },
    url: "https://www.topcontractorsdenver.com",
    telephone: "+1-303-555-0100",
    priceRange: "$$"
  };

  const breadcrumbData = [
    { name: "Home", url: "/" },
    { name: "Plumbers", url: "/plumbers" }
  ];

  return (
    <>
      <Head>
        <title>Top Contractors Denver</title>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: generateLocalBusinessSchema(businessData),
          }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: generateBreadcrumbSchema(breadcrumbData),
          }}
        />
      </Head>
      <main>
        <h1>Welcome to Top Contractors Denver</h1>
        {/* Page content goes here */}
      </main>
    </>
  );
};

export default BusinessPage;
