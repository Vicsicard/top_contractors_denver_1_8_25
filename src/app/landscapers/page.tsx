import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Landscaper', 'landscapers', contractorServices.landscaper.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/landscapers',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function LandscapersPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Landscape Design Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional landscaping services for residential and commercial properties."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Landscape Design</h3>
        <p className="text-gray-700">
          Transform your outdoor space with our professional landscape design services.
          Our experienced designers create beautiful, sustainable landscapes that enhance
          your property's value and your enjoyment of the outdoors.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Lawn Care & Maintenance</h3>
        <p className="text-blue-800">
          Keep your lawn looking its best with our comprehensive maintenance services.
          From regular mowing and fertilization to aeration and weed control, we provide
          everything your lawn needs to stay healthy and beautiful.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Hardscaping</h3>
        <p className="text-green-800">
          Enhance your outdoor living space with our professional hardscaping services.
          We design and install patios, walkways, retaining walls, and other hardscape
          features that complement your landscape design.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Irrigation Systems</h3>
        <p className="text-yellow-800">
          Ensure your landscape stays healthy with our irrigation system services.
          We design, install, and maintain efficient irrigation systems that provide
          proper watering while conserving water resources.
        </p>
      </div>
    </ContractorLayout>
  );
}
