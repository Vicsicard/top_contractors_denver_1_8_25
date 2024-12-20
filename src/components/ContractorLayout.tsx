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
  if (!data) {
    return null;
  }

  const { type, services, serviceAreas, schema, description } = data;

  return (
    <div className="container mx-auto px-4 py-8">
      {schema?.local && <SchemaMarkup type="local" data={schema.local} />}
      {schema?.breadcrumb && <SchemaMarkup type="breadcrumb" data={schema.breadcrumb} />}

      <nav className="flex mb-8 text-sm breadcrumbs" aria-label="Breadcrumb">
        <ul>
          <li>
            <Link href="/" className="text-blue-600 hover:text-blue-800">
              Home
            </Link>
          </li>
          <li className="flex items-center">
            <span className="mx-2">/</span>
            <span className="text-gray-500">{type}s</span>
          </li>
        </ul>
      </nav>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">
            Top-Rated {type}s in Denver, CO
          </h1>
          <p className="text-lg text-gray-700 mb-8">{description}</p>

          {children}

          <div className="bg-white p-6 rounded-lg shadow-sm mt-8">
            <h2 className="text-2xl font-semibold text-gray-900 mb-4">Our Services</h2>
            <ul className="space-y-4">
              {services.map((service, index) => (
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

          <div className="bg-white p-6 rounded-lg shadow-sm mt-8">
            <h2 className="text-2xl font-semibold text-gray-900 mb-4">Service Areas</h2>
            <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
              {serviceAreas.map((area, index) => (
                <div key={index} className="text-gray-700">
                  {area.city}, {area.state} {area.zip}
                </div>
              ))}
            </div>
          </div>
        </div>

        <div className="lg:col-span-1">
          <div className="bg-white p-6 rounded-lg shadow-sm sticky top-4">
            {emergencyText && (
              <div className="bg-red-50 border-l-4 border-red-400 p-4 mb-6">
                <div className="flex">
                  <div className="flex-shrink-0">
                    <svg
                      className="h-5 w-5 text-red-400"
                      viewBox="0 0 20 20"
                      fill="currentColor"
                    >
                      <path
                        fillRule="evenodd"
                        d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                        clipRule="evenodd"
                      />
                    </svg>
                  </div>
                  <div className="ml-3">
                    <p className="text-sm text-red-700">{emergencyText}</p>
                  </div>
                </div>
              </div>
            )}
            <h2 className="text-2xl font-semibold text-gray-900 mb-4">{ctaText}</h2>
            <InquiryForm buttonText={ctaButtonText} service={type} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default ContractorLayout;
