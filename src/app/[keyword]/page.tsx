import type { Metadata } from 'next';
import { loadSearchData } from '@/utils/searchData';
import { parseUrlSegment } from '@/utils/urlHelpers';

interface PageProps {
  params: Promise<{
    keyword: string;
  }>;
}

export default async function Page({ params }: PageProps): Promise<JSX.Element> {
  const resolvedParams = await params;
  const { keyword } = resolvedParams;
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

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const resolvedParams = await params;
  const { keyword } = resolvedParams;
  const parsedKeyword = parseUrlSegment(keyword);
  
  return {
    title: `${parsedKeyword} Services - Denver Contractors`,
    description: `Find the best ${parsedKeyword} services in the Denver area.`,
  };
}

export async function generateStaticParams(): Promise<Array<{ keyword: string }>> {
  const searchData = loadSearchData();
  return searchData.keywords.map(keyword => ({
    keyword: parseUrlSegment(keyword),
  }));
}
