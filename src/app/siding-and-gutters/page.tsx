import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Siding & Gutters', 'siding-and-gutters', contractorServices.sidingAndGutters.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/siding-and-gutters',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function SidingAndGuttersPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Siding & Gutters Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional siding installation and gutter services for your home."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Siding Installation</h3>
        <p className="text-gray-700">
          Protect and beautify your home with our professional siding installation
          services. We offer a wide range of siding materials including vinyl,
          fiber cement, and wood to match your style and budget.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Gutter Installation</h3>
        <p className="text-blue-800">
          Ensure proper water drainage with our seamless gutter installation
          services. We install durable gutters and downspouts that protect
          your home from water damage and foundation issues.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Repairs & Maintenance</h3>
        <p className="text-green-800">
          Keep your siding and gutters in top condition with our repair and
          maintenance services. We fix damaged siding, clean gutters, and
          ensure your home's exterior protection system works effectively.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Storm Damage Repair</h3>
        <p className="text-yellow-800">
          Quick response to storm damage repairs. We work with insurance
          companies and provide emergency services to protect your home
          from further damage after severe weather events.
        </p>
      </div>
    </ContractorLayout>
  );
}
