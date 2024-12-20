import { Metadata } from 'next';
import { searchPlaces } from '@/utils/googlePlaces';
import ContractorListings from '@/components/ContractorListings';
import InquiryForm from '@/components/InquiryForm';

export const metadata: Metadata = {
  title: 'Top Epoxy Garage Floor Contractors in Denver - Professional Installation',
  description: 'Find the best epoxy garage floor contractors in Denver. Professional installation services for your garage.',
  openGraph: {
    title: 'Top Epoxy Garage Floor Contractors in Denver - Professional Installation',
    description: 'Find the best epoxy garage floor contractors in Denver. Professional installation services for your garage.',
    url: 'https://www.topcontractorsdenver.com/epoxy-garage',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

async function getEpoxyContractors() {
  try {
    const response = await searchPlaces('epoxy garage floor contractors', 'Denver, CO');
    return response.results;
  } catch (error) {
    console.error('Error fetching epoxy garage floor contractors:', error);
    return [];
  }
}

export default async function EpoxyGaragePage() {
  const contractors = await getEpoxyContractors();

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-16">
          <h1 className="text-4xl md:text-5xl font-bold mb-4 text-center">
            Top-Rated Epoxy Garage Floor Contractors in Denver
          </h1>
          <p className="text-xl text-center text-blue-100 max-w-3xl mx-auto">
            Find skilled and professional contractors in Denver for your garage floor coating project.
          </p>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto px-4 py-12">
        {/* Contractor Listings */}
        <div className="mb-16">
          <h2 className="text-3xl font-bold text-gray-900 mb-8">Featured Epoxy Floor Contractors in Denver</h2>
          <ContractorListings contractors={contractors} />
        </div>

        {/* Contact Section */}
        <div className="bg-white rounded-lg shadow-lg p-8 max-w-2xl mx-auto">
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-gray-900 mb-4">Get a Free Epoxy Floor Consultation</h2>
            <p className="text-lg text-gray-600 mb-4">
              Connect with top epoxy floor contractors in Denver for your garage project
            </p>
            <a
              href="tel:+17204632319"
              className="inline-block bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold text-lg hover:bg-blue-700 transition-colors mb-6"
            >
              Call (720) 463-2319
            </a>
            <p className="text-gray-600">or submit your details online:</p>
          </div>
          <InquiryForm buttonText="Get Free Quotes" service="Epoxy Garage Floor" />
        </div>
      </div>
    </div>
  );
}
