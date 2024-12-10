import type { Metadata } from 'next';
import type { PageProps } from '@/types/next';
import { loadSearchData } from '@/utils/searchData';
import { parseUrlSegment } from '@/utils/urlHelpers';
import { generateMetaContent } from '@/utils/metaContent';
import Breadcrumbs from '@/app/components/Breadcrumbs';
import { JsonLd } from '@/components/JsonLd';
import CategoryList from '@/components/CategoryList';

type SearchParams = { [key: string]: string | string[] | undefined };

interface Props {
  params: {
    keyword: string;
    location: string;
  };
  searchParams: SearchParams;
}

export default async function Page({ params, searchParams }: Props) {
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
      <JsonLd type="application/ld+json" data={jsonLd} />
      <Breadcrumbs 
        items={[
          { label: 'Home', href: '/' },
          { label: parsedKeyword, href: `/${keyword}` },
          { label: locationData.location, href: `/${keyword}/${location}` }
        ]} 
      />
      <h1 className="text-3xl font-bold mb-4">
        {parsedKeyword} in {locationData.location}
      </h1>
      <p className="text-lg mb-8">
        Find the best {parsedKeyword} in {locationData.location}, {locationData.county} County
      </p>
      <CategoryList contractors={[]} />
    </div>
  );
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { keyword, location } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  const searchData = loadSearchData();
  const locationData = searchData.locations.find(
    (loc) => parseUrlSegment(loc.location) === parseUrlSegment(location)
  );

  if (!locationData) {
    return {
      title: `${parsedKeyword} in ${location} - Denver Contractors`,
      description: `Find the best ${parsedKeyword} in ${location}`,
    };
  }

  return generateMetaContent(parsedKeyword, locationData);
}

export async function generateStaticParams() {
  const searchData = loadSearchData();
  return searchData.keywords.flatMap(keyword =>
    searchData.locations.map(location => ({
      keyword: parseUrlSegment(keyword),
      location: parseUrlSegment(location.location),
    }))
  );
}