import type { Metadata } from 'next';
import type { PageProps } from '@/types/next';
import { loadSearchData } from '@/utils/searchData';
import { parseUrlSegment } from '@/utils/urlHelpers';

interface Props {
  params: {
    keyword: string;
  };
  searchParams: { [key: string]: string | string[] | undefined };
}

export default async function Page({ params, searchParams }: Props) {
  const { keyword } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-4">
        {parsedKeyword} Services
      </h1>
      <p className="text-lg mb-8">
        Select a location to find {parsedKeyword} services near you.
      </p>
    </div>
  );
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { keyword } = params;
  const parsedKeyword = parseUrlSegment(keyword);
  
  return {
    title: `${parsedKeyword} Services - Denver Contractors`,
    description: `Find the best ${parsedKeyword} services in the Denver area.`,
  };
}

export async function generateStaticParams() {
  const searchData = loadSearchData();
  return searchData.keywords.map(keyword => ({
    keyword: parseUrlSegment(keyword),
  }));
}
