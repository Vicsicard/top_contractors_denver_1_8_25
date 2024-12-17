import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Home Remodeler', 'home-remodeling', contractorServices.homeRemodeling);

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/home-remodeling',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function HomeRemodelingPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Remodeling Consultation"
      ctaButtonText="Start Your Project"
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Full Home Transformations</h3>
        <p className="text-gray-700">
          We specialize in complete home renovations that transform your living space while adding value
          to your property. Our experienced team handles everything from design to final touches,
          ensuring a seamless remodeling experience.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Design & Planning</h3>
        <p className="text-blue-800">
          Our design team works closely with you to create a renovation plan that matches your vision
          and budget. We handle all necessary permits and ensure your project meets local building codes.
        </p>
      </div>
    </ContractorLayout>
  );
}
