import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Kitchen Remodeling', 'kitchen-remodeling', contractorServices.kitchenRemodeling.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/kitchen-remodeling',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function KitchenRemodelingPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Kitchen Remodel Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional kitchen remodeling services for your home."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Full Kitchen Remodeling</h3>
        <p className="text-gray-700">
          Transform your kitchen with our comprehensive remodeling services.
          From design to completion, we handle every aspect of your kitchen
          renovation to create your dream cooking and entertaining space.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Custom Cabinets</h3>
        <p className="text-blue-800">
          Maximize your kitchen's storage and style with custom cabinets.
          We offer a wide range of styles, finishes, and organizational
          features to create the perfect solution for your needs.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Countertops & Backsplashes</h3>
        <p className="text-green-800">
          Enhance your kitchen's beauty with premium countertops and
          backsplashes. We work with quality materials including granite,
          quartz, marble, and tile to create stunning surfaces.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Appliance Installation</h3>
        <p className="text-yellow-800">
          Complete your kitchen remodel with professional appliance
          installation. We ensure proper fitting and connection of all
          your new appliances for safe and efficient operation.
        </p>
      </div>
    </ContractorLayout>
  );
}
