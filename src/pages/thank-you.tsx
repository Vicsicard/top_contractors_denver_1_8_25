import React from 'react';
import Link from 'next/link';

export default function ThankYou(): React.ReactElement {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8 text-center">
        <div>
          <h2 className="mt-6 text-3xl font-extrabold text-gray-900">
            Thank You for Your Inquiry!
          </h2>
          <p className="mt-2 text-sm text-gray-600">
            We have received your submission and will contact you soon.
          </p>
        </div>
        <div className="mt-4">
          <Link 
            href="/"
            className="text-blue-600 hover:text-blue-800 font-medium"
          >
            ← Return to Home
          </Link>
        </div>
      </div>
    </div>
  );
}
