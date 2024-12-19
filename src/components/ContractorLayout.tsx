import { ReactNode } from 'react';
import Link from 'next/link';
import SchemaMarkup from './SchemaMarkup';
import InquiryForm from './InquiryForm';
import { ContractorPageData } from '@/utils/contractorPageUtils';

interface ContractorLayoutProps {
  data: ContractorPageData;
  children: ReactNode;
  ctaText: string;
  ctaButtonText: string;
  emergencyText?: string;
}

const ContractorLayout = ({ data, children, ctaText, ctaButtonText, emergencyText }: ContractorLayoutProps) => {
  return (
    <div className="container mx-auto px-4 py-8">
      <SchemaMarkup type="local" data={data.schema.local} />
      <SchemaMarkup type="breadcrumb" data={data.schema.breadcrumb} />

      <nav className="flex mb-8 text-sm breadcrumbs" aria-label="Breadcrumb">
        <ul>
          <li>
            <Link href="/" className="text-blue-600 hover:text-blue-800">
              Home
            </Link>
          </li>
          <li className="flex items-center">
            <span className="mx-2">/</span>
            <span className="text-gray-500">{data.type}s</span>
          </li>
        </ul>
      </nav>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">
            Top-Rated {data.type}s in Denver, CO
          </h1>
          <p className="text-lg text-gray-700 mb-8">{data.description}</p>

          {children}

          <div className="bg-white p-6 rounded-lg shadow-sm mt-8">
            <h2 className="text-2xl font-semibold text-gray-900 mb-4">Our Services</h2>
            <ul className="space-y-4">
              {data.services.map((service, index) => (
                <li key={index} className="flex items-start">
                  <svg
                    className="h-6 w-6 text-green-500 mr-2"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M5 13l4 4L19 7"
                    />
                  </svg>
                  <span className="text-gray-700">{service}</span>
                </li>
              ))}
            </ul>
          </div>
        </div>

        <div className="lg:col-span-1">
          <div className="bg-blue-50 p-6 rounded-lg shadow-sm mt-6">
            <h3 className="text-xl font-semibold text-blue-900 mb-4">Contact Us</h3>
            <p className="text-blue-800 mb-4">Need professional {data.type.toLowerCase()} service?</p>
            <Link href="tel:+17204632319" 
               className="inline-flex items-center justify-center w-full px-4 py-2 text-base font-medium text-white bg-blue-600 border border-transparent rounded-md shadow-sm hover:bg-blue-700">
              Call (720) 463-2319
            </Link>
          </div>

          <div className="bg-green-50 p-6 rounded-lg shadow-sm mt-6">
            <h3 className="text-xl font-semibold text-green-900 mb-4">{ctaText}</h3>
            <p className="text-green-800 mb-4">Get started with your project today!</p>
            <Link href="#contact-form" 
               className="inline-flex items-center justify-center w-full px-4 py-2 text-base font-medium text-white bg-green-600 border border-transparent rounded-md shadow-sm hover:bg-green-700">
              {ctaButtonText}
            </Link>
          </div>

          {emergencyText && (
            <div className="bg-red-50 p-6 rounded-lg shadow-sm mt-6">
              <h3 className="text-xl font-semibold text-red-900 mb-4">24/7 Emergency Service</h3>
              <p className="text-red-800">{emergencyText}</p>
            </div>
          )}

          <div className="bg-gray-50 p-6 rounded-lg shadow-sm mt-6">
            <h3 className="text-xl font-semibold text-gray-900 mb-4">Service Areas</h3>
            <div className="grid grid-cols-2 gap-2">
              {data.serviceAreas.map((area, index) => (
                <div key={index} className="text-gray-600 text-sm">
                  {`${area.city}, ${area.state} ${area.zip}`}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      <div id="contact-form" className="mt-16">
        <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">Request a Free Estimate</h2>
        <InquiryForm />
      </div>
    </div>
  );
};

export default ContractorLayout;
