import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Window Installation', 'windows', contractorServices.windows.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/windows',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function WindowsPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Window Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional window installation and repair services for your home."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Window Installation</h3>
        <p className="text-gray-700">
          Enhance your home's beauty and energy efficiency with our professional
          window installation services. We offer a wide selection of high-quality
          windows from leading manufacturers.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Energy Efficient Windows</h3>
        <p className="text-blue-800">
          Save on energy costs with our selection of energy-efficient windows.
          We offer double-pane and triple-pane options with advanced insulation
          features to keep your home comfortable year-round.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Window Repair</h3>
        <p className="text-green-800">
          Extend the life of your windows with our professional repair services.
          From fixing broken seals to replacing damaged hardware, we keep your
          windows functioning properly and looking great.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Custom Windows</h3>
        <p className="text-yellow-800">
          Create the perfect look for your home with our custom window options.
          We offer a variety of styles, sizes, and finishes to match your
          home's architecture and your personal taste.
        </p>
      </div>
    </ContractorLayout>
  );
}
