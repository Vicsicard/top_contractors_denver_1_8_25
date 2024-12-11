import { parseUrlSegment } from '@/utils/urlHelpers';
import { loadSearchData } from '@/utils/searchData';
import { Metadata } from 'next';
import Breadcrumbs from '@/components/Breadcrumbs';
import { JsonLd } from '@/components/JsonLd';
import CategoryList from '@/components/CategoryList';

interface PageParams {
  keyword: string;
  location: string;
}

interface PageProps {
  params: PageParams;
  searchParams?: { [key: string]: string | string[] | undefined };
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  console.log('generateMetadata params:', JSON.stringify(params, null, 2));
  const { keyword, location } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  const parsedLocation = parseUrlSegment(location);
  
  return {
    title: `${keyword} in ${location} - Find Local Contractors`,
    description: `Find trusted ${keyword.toLowerCase()} in ${location}. Get connected with skilled professionals for your home improvement and construction needs.`,
    alternates: {
      canonical: `/${parsedKeyword}/${parsedLocation}`,
    },
  };
}

export default function Page({ params }: PageProps): JSX.Element {
  console.log('Page component params:', JSON.stringify(params, null, 2));
  console.log('Page component params type:', Object.prototype.toString.call(params));
  console.log('Is params a promise?', params instanceof Promise);
  
  const { keyword, location } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  const parsedLocation = parseUrlSegment(location);
  const searchData = loadSearchData();
  const locationData = searchData.locations.find(
    (loc) => parseUrlSegment(loc.location) === parsedLocation
  );

  if (!locationData) {
    return (
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-4">Location Not Found</h1>
        <p>Sorry, we could not find the location you&apos;re looking for.</p>
      </div>
    );
  }

  const jsonLd = {
    type: 'Service',
    data: {
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
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={keyword} location={location} />
      <JsonLd {...jsonLd} />
      <h1 className="text-3xl font-bold mb-4">
        {parsedKeyword} in {locationData.location}
      </h1>
      <CategoryList contractors={[]} />
    </div>
  );
}

export async function generateStaticParams(): Promise<PageParams[]> {
  console.log('generateStaticParams called');
  const searchData = loadSearchData();
  const params = [];

  for (const keyword of searchData.keywords) {
    for (const location of searchData.locations) {
      params.push({
        keyword,
        location: location.location,
      });
    }
  }

  console.log('Generated params:', JSON.stringify(params, null, 2));
  return params;
}