import { Metadata } from 'next';
import { searchPlaces } from '@/utils/googlePlaces';
import ContractorListings from '@/components/ContractorListings';
import InquiryForm from '@/components/InquiryForm';

export const metadata: Metadata = {
  title: 'Top Electricians in Denver - Licensed & Professional Electrical Services',
  description: 'Find the best electricians in Denver. Professional, licensed electrical services for residential and commercial needs.',
  openGraph: {
    title: 'Top Electricians in Denver - Licensed & Professional Electrical Services',
    description: 'Find the best electricians in Denver. Professional, licensed electrical services for residential and commercial needs.',
    url: 'https://www.topcontractorsdenver.com/electricians',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

async function getElectricians() {
  try {
    const response = await searchPlaces('electricians', 'Denver, CO');
    return response.results;
  } catch (error) {
    console.error('Error fetching electricians:', error);
    return [];
  }
}

export default async function ElectriciansPage() {
  const electricians = await getElectricians();

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-16">
          <h1 className="text-4xl md:text-5xl font-bold mb-4 text-center">
            Top-Rated Electricians in Denver
          </h1>
          <p className="text-xl text-center text-blue-100 max-w-3xl mx-auto">
            Find licensed and professional electricians in Denver for all your residential and commercial electrical needs.
          </p>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto px-4 py-12">
        {/* Electrician Listings */}
        <div className="mb-16">
          <h2 className="text-3xl font-bold text-gray-900 mb-8">Featured Electricians in Denver</h2>
          <ContractorListings contractors={electricians} />
        </div>

        {/* Contact Section */}
        <div className="bg-white rounded-lg shadow-lg p-8 max-w-2xl mx-auto">
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-gray-900 mb-4">Get a Free Electrical Consultation</h2>
            <p className="text-lg text-gray-600 mb-4">
              Connect with top electricians in Denver for your project
            </p>
            <a
              href="tel:+17204632319"
              className="inline-block bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold text-lg hover:bg-blue-700 transition-colors mb-6"
            >
              Call (720) 463-2319
            </a>
            <p className="text-gray-600">or submit your details online:</p>
          </div>
          <InquiryForm buttonText="Get Free Quotes" service="Electrical" />
        </div>
      </div>
    </div>
  );
}
