import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('Painter', 'painters', contractorServices.painter.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/painters',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function PaintersPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free Painting Estimate"
      ctaButtonText="Schedule Consultation"
      emergencyText="Professional painting services for interior and exterior projects."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Interior Painting</h3>
        <p className="text-gray-700">
          Transform your home's interior with our professional painting services. We use
          premium paints and materials to ensure a flawless finish that lasts. Our team
          handles everything from color consultation to final cleanup.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Exterior Painting</h3>
        <p className="text-blue-800">
          Protect and beautify your home's exterior with our comprehensive painting
          services. We handle proper surface preparation, repairs, and use weather-resistant
          paints for lasting results.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Commercial Painting</h3>
        <p className="text-green-800">
          Keep your business looking professional with our commercial painting services.
          We work efficiently to minimize disruption while delivering exceptional results
          for offices, retail spaces, and industrial facilities.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Specialty Finishes</h3>
        <p className="text-yellow-800">
          Enhance your space with our specialty painting services including faux finishes,
          textured walls, cabinet refinishing, and decorative painting techniques that
          add unique character to your property.
        </p>
      </div>
    </ContractorLayout>
  );
}
