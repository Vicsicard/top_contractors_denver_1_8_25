import { Metadata } from 'next';
import { PrismaClient } from '@prisma/client';
import { notFound } from 'next/navigation';

const prisma = new PrismaClient();

// Function to safely get contractors
async function getContractors() {
  try {
    return await prisma.business.findMany();
  } catch (error) {
    console.error('Error fetching contractors:', error);
    return [];
  } finally {
    await prisma.$disconnect();
  }
}

export async function generateStaticParams() {
  const contractors = await getContractors();
  
  return contractors.map((contractor) => ({
    slug: contractor.placeId,
  }));
}

async function getContractorBySlug(slug: string) {
  try {
    const contractor = await prisma.business.findUnique({
      where: { placeId: slug },
    });
    return contractor;
  } catch (error) {
    console.error('Error fetching contractor:', error);
    return null;
  } finally {
    await prisma.$disconnect();
  }
}

export async function generateMetadata({ params }: { params: { slug: string } }): Promise<Metadata> {
  const contractor = await getContractorBySlug(params.slug);

  if (!contractor) {
    return {
      title: 'Contractor Not Found',
      description: 'The requested contractor page could not be found.',
    };
  }

  return {
    title: `${contractor.name} - Top Denver Contractor`,
    description: `Learn more about ${contractor.name}, a top-rated contractor in Denver. View contact information, services, and reviews.`,
    openGraph: {
      title: `${contractor.name} - Denver Contractor`,
      description: `${contractor.name} is a professional contractor in Denver. Contact information, services, and reviews available.`,
      url: `https://www.topcontractorsdenver.com/contractor/${params.slug}`,
      siteName: 'Top Contractors Denver',
      locale: 'en_US',
      type: 'website',
    },
  };
}

export default async function ContractorPage({ params }: { params: { slug: string } }) {
  const contractor = await getContractorBySlug(params.slug);

  if (!contractor) {
    notFound();
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-4">{contractor.name}</h1>
      <div className="bg-white shadow-lg rounded-lg p-6">
        <div className="mb-4">
          <h2 className="text-xl font-semibold mb-2">Contact Information</h2>
          <p>{contractor.address}</p>
          <p>Phone: {contractor.phone}</p>
          {contractor.website && (
            <p>
              <a 
                href={contractor.website} 
                target="_blank" 
                rel="noopener noreferrer"
                className="text-blue-600 hover:text-blue-800"
              >
                Visit Website
              </a>
            </p>
          )}
        </div>
        
        <div className="mb-4">
          <h2 className="text-xl font-semibold mb-2">Business Details</h2>
          <p>Rating: {contractor.rating} ⭐</p>
          <p>Reviews: {contractor.reviewCount}</p>
        </div>

        {contractor.businessStatus && (
          <div className="mb-4">
            <h2 className="text-xl font-semibold mb-2">Status</h2>
            <p className={`font-semibold ${
              contractor.businessStatus === 'OPERATIONAL' ? 'text-green-600' : 'text-red-600'
            }`}>
              {contractor.businessStatus === 'OPERATIONAL' ? 'Open' : 'Closed'}
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
