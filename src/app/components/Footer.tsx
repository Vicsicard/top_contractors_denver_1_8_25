import React from 'react';

const Footer: React.FC = () => {
  return (
    <footer className="bg-gray-50 border-t">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="text-center">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Denver Contractors</h2>
          <p className="text-gray-600 mb-4">
            Connecting Denver residents with qualified, reliable contractors for all home improvement needs.
          </p>
          <div className="text-gray-600">
            <p>Denver, Colorado</p>
            <p className="mt-2">
              <a href="mailto:contact@denvercontractors.com" className="hover:text-gray-900">
                contact@denvercontractors.com
              </a>
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
