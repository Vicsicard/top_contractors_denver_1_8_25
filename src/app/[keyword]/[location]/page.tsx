import type { Metadata } from 'next';
import { loadSearchData } from '@/utils/searchData';
import { parseUrlSegment } from '@/utils/urlHelpers';
import { generateMetaContent } from '@/utils/metaContent';
import Breadcrumbs from '@/app/components/Breadcrumbs';
import { JsonLd } from '@/components/JsonLd';
import CategoryList from '@/components/CategoryList';

interface PageProps {
  params: {
    keyword: string;
    location: string;
  };
}

export default async function Page({ params }: PageProps) {
  const { keyword, location } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  const searchData = loadSearchData();
  const locationData = searchData.locations.find(
    (loc) => parseUrlSegment(loc.location) === parseUrlSegment(location)
  );

  if (!locationData) {
    return (
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-4">
          {parsedKeyword} in {location}
        </h1>
        <p>Location not found.</p>
      </div>
    );
  }

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Service",
    "name": `${parsedKeyword} in ${locationData.location}`,
    "description": `Find the best ${parsedKeyword} in ${locationData.location}, ${locationData.county} County`,
    "areaServed": {
      "@type": "City",
      "name": locationData.location,
      "containedIn": locationData.county
    },
    "provider": {
      "@type": "LocalBusiness",
      "name": "Denver Contractors"
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={keyword} location={location} />
      <JsonLd data={jsonLd} />
      <h1 className="text-3xl font-bold mb-4">
        {parsedKeyword} in {locationData.location}
      </h1>
      <CategoryList />
    </div>
  );
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { keyword, location } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  const searchData = loadSearchData();
  const locationData = searchData.locations.find(
    (loc) => parseUrlSegment(loc.location) === parseUrlSegment(location)
  );
  
  if (!locationData) {
    return {
      title: `${parsedKeyword} in ${location} - Not Found`,
      description: `Location not found for ${parsedKeyword} services.`,
    };
  }
  
  return generateMetaContent(parsedKeyword, locationData);
}

export async function generateStaticParams() {
  const searchData = loadSearchData();
  return searchData.locations.flatMap(loc => 
    searchData.keywords.map(keyword => ({
      keyword: parseUrlSegment(keyword),
      location: parseUrlSegment(loc.location),
    }))
  );
}