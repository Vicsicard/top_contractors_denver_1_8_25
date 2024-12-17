import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Electrician', 'electricians', contractorServices.electrician.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/electricians',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function ElectriciansPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Electrical Consultation"
      ctaButtonText="Schedule Service"
      emergencyText="24/7 Emergency electrical services available for urgent repairs and safety concerns."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Emergency Electrical Services</h3>
        <p className="text-gray-700">
          Our team of licensed electricians is available 24/7 for emergency electrical repairs.
          We handle power outages, electrical fires, and other urgent electrical issues with
          prompt, professional service.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Residential Electrical</h3>
        <p className="text-blue-800">
          From simple repairs to complete home rewiring, our residential electrical services
          ensure your home's electrical system is safe and efficient. We specialize in panel
          upgrades, lighting installation, and electrical troubleshooting.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Commercial Electrical</h3>
        <p className="text-green-800">
          Keep your business running smoothly with our commercial electrical services. We
          provide electrical maintenance, repairs, and installations for offices, retail
          spaces, and industrial facilities.
        </p>
      </div>
    </ContractorLayout>
  );
}
