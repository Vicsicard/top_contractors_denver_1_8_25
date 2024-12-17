import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Flooring', 'flooring', contractorServices.flooring.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/flooring',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function FlooringPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Flooring Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional flooring installation and repair services."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Hardwood Flooring</h3>
        <p className="text-gray-700">
          Enhance your home with beautiful hardwood floors. We offer installation,
          refinishing, and repair services for all types of hardwood flooring,
          ensuring lasting beauty and durability.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Tile & Stone</h3>
        <p className="text-blue-800">
          From elegant marble to durable ceramic tile, our expert installers create
          stunning floors that stand the test of time. We handle all aspects of
          tile installation, including proper substrate preparation.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Carpet Installation</h3>
        <p className="text-green-800">
          Add comfort and style to your space with our professional carpet
          installation services. We work with all types of carpet and ensure
          proper installation for maximum longevity.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Luxury Vinyl & Laminate</h3>
        <p className="text-yellow-800">
          Get the look of hardwood or stone at a fraction of the cost with our
          luxury vinyl and laminate flooring options. These durable, water-resistant
          floors are perfect for busy households.
        </p>
      </div>
    </ContractorLayout>
  );
}
