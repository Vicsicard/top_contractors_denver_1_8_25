import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Bathroom Remodeling', 'bathroom-remodeling', contractorServices.bathroomRemodeling.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/bathroom-remodeling',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function BathroomRemodelingPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Bathroom Remodel Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional bathroom remodeling services for your home."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Full Bathroom Remodeling</h3>
        <p className="text-gray-700">
          Transform your bathroom with our comprehensive remodeling services.
          From design to completion, we handle every aspect of your bathroom
          renovation to create your dream space.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Custom Shower & Tub Installation</h3>
        <p className="text-blue-800">
          Upgrade your bathroom with a custom shower or luxury tub installation.
          We offer a wide range of options from walk-in showers to soaking tubs,
          all professionally installed for lasting beauty.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Vanities & Fixtures</h3>
        <p className="text-green-800">
          Enhance your bathroom's functionality and style with custom vanities
          and modern fixtures. We install quality products that combine
          beauty with durability.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Tile & Flooring</h3>
        <p className="text-yellow-800">
          Complete your bathroom renovation with expert tile and flooring
          installation. We work with a variety of materials to create
          beautiful, water-resistant surfaces.
        </p>
      </div>
    </ContractorLayout>
  );
}
