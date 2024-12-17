import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Mason', 'masonry', contractorServices.masonry.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/masonry',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function MasonryPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Masonry Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional masonry services for residential and commercial properties."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Brick & Stone Work</h3>
        <p className="text-gray-700">
          Transform your property with our expert brick and stone masonry services.
          From elegant stone facades to classic brick walls, we create lasting
          structures that enhance your property's beauty and value.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Retaining Walls</h3>
        <p className="text-blue-800">
          Protect your property and add functional beauty with our retaining wall
          services. We design and build sturdy walls that prevent soil erosion
          while complementing your landscape design.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Outdoor Living Spaces</h3>
        <p className="text-green-800">
          Create stunning outdoor living areas with our masonry expertise. From
          fire pits and outdoor kitchens to patios and walkways, we build
          beautiful spaces for outdoor enjoyment.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Restoration & Repair</h3>
        <p className="text-yellow-800">
          Preserve the integrity of your masonry with our restoration and repair
          services. We fix cracks, replace damaged bricks, and restore historic
          masonry to its original beauty.
        </p>
      </div>
    </ContractorLayout>
  );
}
