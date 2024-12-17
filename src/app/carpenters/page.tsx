import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Carpenter', 'carpenters', contractorServices.carpenter.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/carpenters',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function CarpentersPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Carpentry Consultation"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional carpentry services for residential and commercial projects."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Custom Woodworking</h3>
        <p className="text-gray-700">
          Transform your space with our custom woodworking services. From built-in
          cabinets to custom furniture, our skilled carpenters create beautiful,
          functional pieces that perfectly match your style and needs.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Home Renovations</h3>
        <p className="text-blue-800">
          Our carpentry expertise brings your renovation dreams to life. We handle
          everything from structural modifications to finish carpentry, ensuring
          high-quality craftsmanship throughout your project.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Commercial Carpentry</h3>
        <p className="text-green-800">
          Support your business with our commercial carpentry services. We provide
          expert installation of store fixtures, office furniture, and custom
          woodwork that enhances your commercial space.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Repair & Restoration</h3>
        <p className="text-yellow-800">
          Preserve the beauty and functionality of your wooden elements with our
          repair and restoration services. We fix damaged woodwork and restore
          antique pieces to their former glory.
        </p>
      </div>
    </ContractorLayout>
  );
}
