import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { trades } from '@/data/trades';

// Function to safely get contractors
async function getContractors() {
  try {
    // Return empty array since we're using static pages
    return [];
  } catch (error) {
    console.error('Error fetching contractors:', error);
    return [];
  }
}

export async function generateStaticParams() {
  return [];
}

async function getContractorBySlug(slug: string) {
  return null;
}

export async function generateMetadata({ params }: { params: { slug: string } }): Promise<Metadata> {
  const contractor = await getContractorBySlug(params.slug);
  
  return {
    title: contractor ? `${contractor.name} | Top Contractors Denver` : 'Contractor Not Found',
    description: contractor ? `Learn more about ${contractor.name} in Denver, CO` : 'Contractor information not available',
  };
}

export default async function ContractorPage({ params }: { params: { slug: string } }) {
  const contractor = await getContractorBySlug(params.slug);
  
  if (!contractor) {
    notFound();
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-4">Contractor Not Found</h1>
      <p>This contractor page is no longer available.</p>
    </div>
  );
}
