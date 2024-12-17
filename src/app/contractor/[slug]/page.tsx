import { Metadata } from 'next';
import { PrismaClient } from '@prisma/client';
import { generateMetadata, generateSlug } from '@/utils/seoUtils';
import { notFound } from 'next/navigation';

const prisma = new PrismaClient();

interface PageProps {
  params: {
    slug: string;
  };
}

// Generate static metadata for the page
export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const business = await prisma.business.findFirst({
    where: {
      name: {
        contains: params.slug.replace(/-/g, ' '),
        mode: 'insensitive'
      }
    }
  });

  if (!business) {
    return {
      title: 'Contractor Not Found - Denver Contractors',
      description: 'The requested contractor page could not be found.'
    };
  }

  return generateMetadata(business);
}

// The main page component
export default async function ContractorPage({ params }: PageProps) {
  const business = await prisma.business.findFirst({
    where: {
      name: {
        contains: params.slug.replace(/-/g, ' '),
        mode: 'insensitive'
      }
    }
  });

  if (!business) {
    notFound();
  }

  return (
    <main className="container mx-auto px-4 py-8">
      <article className="max-w-4xl mx-auto">
        <header className="mb-8">
          <h1 className="text-4xl font-bold mb-4">{business.name}</h1>
          <div className="flex items-center mb-4">
            <span className="text-yellow-400 mr-2">★</span>
            <span>{business.rating} ({business.reviewCount} reviews)</span>
          </div>
        </header>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold mb-4">About Us</h2>
          <p className="mb-4">
            {business.name} is a trusted contractor serving the Denver area. 
            We specialize in {business.categories?.join(', ')}.
          </p>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold mb-4">Contact Information</h2>
          <div className="space-y-2">
            <p><strong>Address:</strong> {business.address}</p>
            {business.phone && <p><strong>Phone:</strong> <a href={`tel:${business.phone}`} className="text-blue-600 hover:underline">{business.phone}</a></p>}
            {business.website && <p><strong>Website:</strong> <a href={business.website} target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">{business.website}</a></p>}
          </div>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold mb-4">Services</h2>
          <ul className="list-disc list-inside space-y-2">
            {business.categories?.map((category) => (
              <li key={category}>{category}</li>
            ))}
          </ul>
        </section>
      </article>
    </main>
  );
}

// Generate static paths for all contractors
export async function generateStaticParams() {
  const businesses = await prisma.business.findMany();
  
  return businesses.map((business) => ({
    slug: generateSlug(business),
  }));
}
