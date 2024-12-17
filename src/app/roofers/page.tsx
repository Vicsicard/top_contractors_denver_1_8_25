import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Roofer', 'roofers', contractorServices.roofer.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/roofers',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function RoofersPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Roof Inspection"
      ctaButtonText="Schedule Inspection"
      emergencyText="24/7 Emergency roof repair services available for storm damage and leaks."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Emergency Roof Repairs</h3>
        <p className="text-gray-700">
          Our emergency roofing team is available 24/7 to handle storm damage, leaks, and
          other urgent roofing issues. We work quickly to prevent water damage and protect
          your property.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Residential Roofing</h3>
        <p className="text-blue-800">
          From repairs to complete roof replacements, our residential roofing services
          ensure your home is protected. We work with all types of roofing materials
          and provide long-lasting solutions.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Commercial Roofing</h3>
        <p className="text-green-800">
          Protect your business investment with our commercial roofing services. We
          specialize in flat roofs, TPO, EPDM, and other commercial roofing systems,
          providing durable solutions that minimize business disruption.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Roof Maintenance</h3>
        <p className="text-yellow-800">
          Regular roof maintenance can extend your roof's life and prevent costly repairs.
          Our maintenance programs include inspections, cleaning, and preventive repairs
          to keep your roof in top condition.
        </p>
      </div>
    </ContractorLayout>
  );
}
