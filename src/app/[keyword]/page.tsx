import { Metadata } from 'next';
import { parseUrlSegment } from '@/utils/urlHelpers';
import { loadSearchData } from '@/utils/searchData';
import Breadcrumbs from '@/components/Breadcrumbs';
import { JsonLd } from '@/components/JsonLd';
import LocationList from '@/components/LocationList';

interface PageParams {
  keyword: string;
}

interface PageProps {
  params: PageParams;
  searchParams?: { [key: string]: string | string[] | undefined };
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  console.log('generateMetadata params:', JSON.stringify(params, null, 2));
  const { keyword } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  
  return {
    title: `${keyword} in Denver Area - Find Local Contractors`,
    description: `Find trusted ${keyword.toLowerCase()} in the Denver metropolitan area. Get connected with skilled professionals for your home improvement and construction needs.`,
    alternates: {
      canonical: `/${parsedKeyword}`,
    },
  };
}

export default function Page({ params }: PageProps): JSX.Element {
  console.log('Page component params:', JSON.stringify(params, null, 2));
  console.log('Page component params type:', Object.prototype.toString.call(params));
  console.log('Is params a promise?', params instanceof Promise);
  
  const { keyword } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  const searchData = loadSearchData();

  if (!searchData.keywords.includes(keyword)) {
    return (
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-4">Service Not Found</h1>
        <p>Sorry, we could not find the service you&apos;re looking for.</p>
      </div>
    );
  }

  const jsonLd = {
    type: 'Service',
    data: {
      "@context": "https://schema.org",
      "@type": "Service",
      "name": `${parsedKeyword} in Denver Area`,
      "description": `Find the best ${parsedKeyword} in the Denver metropolitan area`,
      "areaServed": {
        "@type": "City",
        "name": "Denver",
        "containedIn": "Colorado"
      },
      "provider": {
        "@type": "LocalBusiness",
        "name": "Denver Contractors"
      }
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={keyword} />
      <JsonLd {...jsonLd} />
      <h1 className="text-3xl font-bold mb-4">
        {parsedKeyword} in Denver Area
      </h1>
      <LocationList keyword={keyword} locations={searchData.locations} />
    </div>
  );
}

export async function generateStaticParams(): Promise<PageParams[]> {
  console.log('generateStaticParams called');
  const searchData = loadSearchData();
  const params = searchData.keywords.map(keyword => ({
    keyword,
  }));
  
  console.log('Generated params:', JSON.stringify(params, null, 2));
  return params;
}
