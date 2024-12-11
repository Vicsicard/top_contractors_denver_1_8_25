import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { PageProps } from '@/types/routes';
import Breadcrumbs from '@/components/Breadcrumbs';
import JsonLd from '@/components/JsonLd';
import LocationList from '@/components/LocationList';
import { loadLocations } from '@/utils/searchData';

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const resolvedParams = await params;
  const { keyword } = resolvedParams;
  const parsedKeyword = decodeURIComponent(keyword);
  
  return {
    title: `${parsedKeyword} in Denver Area | Denver Contractors`,
    description: `Find the best ${parsedKeyword} in the Denver area. Browse reviews, ratings, and contact information.`,
  };
}

export default async function Page({ params }: PageProps): Promise<JSX.Element> {
  const resolvedParams = await params;
  const { keyword } = resolvedParams;
  const parsedKeyword = decodeURIComponent(keyword);
  
  const locations = await loadLocations(parsedKeyword);
  if (!locations || locations.length === 0) {
    notFound();
  }

  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Service',
    name: `${parsedKeyword} in Denver Area`,
    areaServed: {
      '@type': 'City',
      name: 'Denver',
      containedIn: {
        '@type': 'State',
        name: 'Colorado'
      }
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <Breadcrumbs keyword={parsedKeyword} />
      <JsonLd type="Service" data={jsonLd} />
      <h1 className="text-3xl font-bold mb-4">{parsedKeyword} in Denver Area</h1>
      <p className="text-lg mb-8">
        Find the best {parsedKeyword} in these Denver area locations:
      </p>
      <LocationList locations={locations} keyword={parsedKeyword} />
    </div>
  );
}
