import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Plumber', 'plumbers', contractorServices.plumber.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/plumbers',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function PlumbersPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Plumbing Consultation"
      ctaButtonText="Schedule Service"
      emergencyText="24/7 Emergency plumbing services available for urgent repairs and water damage prevention."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Emergency Plumbing Services</h3>
        <p className="text-gray-700">
          Our team of licensed plumbers is available 24/7 for emergency repairs. From burst
          pipes to severe leaks, we respond quickly to prevent water damage and restore
          your plumbing system.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Residential Plumbing</h3>
        <p className="text-blue-800">
          Trust our experienced plumbers for all your home plumbing needs. We handle
          everything from routine maintenance to complex repairs, ensuring your plumbing
          system works efficiently and reliably.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Commercial Plumbing</h3>
        <p className="text-green-800">
          Keep your business running smoothly with our commercial plumbing services. We
          provide prompt, professional service for offices, restaurants, retail spaces,
          and industrial facilities.
        </p>
      </div>
    </ContractorLayout>
  );
}
