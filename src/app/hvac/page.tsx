import { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

const contractorData = generateContractorData('HVAC', 'hvac', contractorServices.hvac.map(service => service.name));

export const metadata: Metadata = {
  title: `${contractorData.title} | Denver Contractors`,
  description: contractorData.description,
  openGraph: {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    url: 'https://www.topcontractorsdenver.com/hvac',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

export default function HVACPage() {
  return (
    <ContractorLayout
      data={{
        ...contractorData,
        serviceAreas
      }}
      ctaText="Free HVAC Consultation"
      ctaButtonText="Schedule Service"
      emergencyText="24/7 Emergency HVAC services available for heating and cooling emergencies."
    >
      <div className="bg-gray-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-gray-900 mb-3">Emergency HVAC Services</h3>
        <p className="text-gray-700">
          Our team of certified HVAC technicians is available 24/7 for emergency repairs.
          Whether it's a broken furnace in winter or a failed AC in summer, we're here to
          help restore your comfort quickly.
        </p>
      </div>
      
      <div className="bg-blue-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-blue-900 mb-3">Heating Services</h3>
        <p className="text-blue-800">
          Keep your home warm and comfortable with our comprehensive heating services.
          We handle furnace repairs, maintenance, and installations for all major brands.
          Regular maintenance can prevent breakdowns and extend system life.
        </p>
      </div>

      <div className="bg-green-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-green-900 mb-3">Cooling Services</h3>
        <p className="text-green-800">
          Stay cool during Denver's hot summers with our expert AC services. From routine
          maintenance to emergency repairs and new system installations, we ensure your
          cooling system runs efficiently and reliably.
        </p>
      </div>

      <div className="bg-yellow-50 p-6 rounded-lg my-8">
        <h3 className="text-xl font-semibold text-yellow-900 mb-3">Indoor Air Quality</h3>
        <p className="text-yellow-800">
          Breathe easier with our indoor air quality solutions. We offer air purification
          systems, humidifiers, and ventilation improvements to ensure your home's air is
          clean and healthy.
        </p>
      </div>
    </ContractorLayout>
  );
}
