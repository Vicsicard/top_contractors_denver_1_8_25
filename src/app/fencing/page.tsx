import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Fencing', 'fencing', contractorServices.fencing.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/fencing',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function FencingPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Fencing Estimate"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional fence installation and repair services."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Residential Fencing</h3>
        <p className="text-gray-700">
          Enhance your property's security and curb appeal with our residential
          fencing services. We offer a wide range of styles and materials to
          match your home's architecture and meet your specific needs.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Commercial Fencing</h3>
        <p className="text-blue-800">
          Protect your business with our commercial fencing solutions. From
          security fences to decorative barriers, we provide durable installations
          that meet commercial property requirements.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Custom Gates</h3>
        <p className="text-green-800">
          Complete your fence with a custom gate that matches your style and
          security needs. We design and install manual and automatic gates
          for both residential and commercial properties.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Fence Repair & Maintenance</h3>
        <p className="text-yellow-800">
          Keep your fence in top condition with our repair and maintenance
          services. We fix damaged sections, replace posts, and provide
          regular maintenance to extend your fence's lifespan.
        </p>
      </div>
    </ContractorLayout>
  );
}
