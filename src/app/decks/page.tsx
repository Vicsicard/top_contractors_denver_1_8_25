import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Deck Builder', 'decks', contractorServices.decks.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/decks',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function DecksPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Deck Design Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional deck building and repair services for your outdoor living space."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Custom Deck Design</h3>
        <p className="text-gray-700">
          Create your perfect outdoor living space with our custom deck design services.
          Our experienced designers work with you to create a deck that complements
          your home's architecture and meets your lifestyle needs.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Deck Construction</h3>
        <p className="text-blue-800">
          Trust our skilled craftsmen to build your dream deck. We use premium
          materials and follow strict building codes to ensure your deck is
          beautiful, safe, and built to last.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Deck Renovation</h3>
        <p className="text-green-800">
          Breathe new life into your existing deck with our renovation services.
          From structural repairs to cosmetic updates, we can transform your
          old deck into a stunning outdoor retreat.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Maintenance & Repairs</h3>
        <p className="text-yellow-800">
          Keep your deck safe and beautiful with our maintenance and repair
          services. We offer deck inspections, repairs, cleaning, and
          refinishing to protect your investment.
        </p>
      </div>
    </ContractorLayout>
  );
}
