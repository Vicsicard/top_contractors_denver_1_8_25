import { Metadata } from 'next';
import { searchPlaces } from '@/utils/googlePlaces';
import ContractorListings from '@/components/ContractorListings';
import InquiryForm from '@/components/InquiryForm';

export const metadata: Metadata = {
  title: 'Top Home Remodeling Contractors in Denver - Professional Renovation Services',
  description: 'Find the best home remodeling contractors in Denver. Professional renovation services for your entire home.',
  openGraph: {
    title: 'Top Home Remodeling Contractors in Denver - Professional Renovation Services',
    description: 'Find the best home remodeling contractors in Denver. Professional renovation services for your entire home.',
    url: 'https://www.topcontractorsdenver.com/home-remodeling',
    siteName: 'Denver Contractors',
    locale: 'en_US',
    type: 'website',
  },
};

async function getRemodelers() {
  try {
    const response = await searchPlaces('home remodeling contractors', 'Denver, CO');
    return response.results;
  } catch (error) {
    console.error('Error fetching remodeling contractors:', error);
    return [];
  }
}

export default async function HomeRemodelingPage() {
  const remodelers = await getRemodelers();

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-16">
          <h1 className="text-4xl md:text-5xl font-bold mb-4 text-center">
            Top-Rated Home Remodeling Contractors in Denver
          </h1>
          <p className="text-xl text-center text-blue-100 max-w-3xl mx-auto">
            Find skilled and professional remodeling contractors in Denver for your home renovation project.
          </p>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto px-4 py-12">
        {/* Remodeler Listings */}
        <div className="mb-16">
          <h2 className="text-3xl font-bold text-gray-900 mb-8">Featured Remodeling Contractors in Denver</h2>
          <ContractorListings contractors={remodelers} />
        </div>

        {/* Contact Section */}
        <div className="bg-white rounded-lg shadow-lg p-8 max-w-2xl mx-auto">
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-gray-900 mb-4">Get a Free Remodeling Consultation</h2>
            <p className="text-lg text-gray-600 mb-4">
              Connect with top remodeling contractors in Denver for your project
            </p>
            <a
              href="tel:+17204632319"
              className="inline-block bg-blue-600 text-white px-8 py-3 rounded-lg font-semibold text-lg hover:bg-blue-700 transition-colors mb-6"
            >
              Call (720) 463-2319
            </a>
            <p className="text-gray-600">or submit your details online:</p>
          </div>
          <InquiryForm buttonText="Get Free Quotes" service="Home Remodeling" />
        </div>
      </div>
    </div>
  );
}
