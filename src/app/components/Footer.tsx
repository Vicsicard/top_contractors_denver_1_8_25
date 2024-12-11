import Link from 'next/link';
import React from 'react';

const Footer: React.FC = () => {
  return (
    <footer className="bg-gray-50 border-t">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Company Info - SEO optimized with structured data */}
          <div>
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Denver Contractors</h2>
            <p className="text-gray-600">
              Connecting Denver residents with qualified, reliable contractors for all home improvement needs.
            </p>
          </div>

          {/* Quick Links - SEO optimized with descriptive text */}
          <div>
            <h3 className="text-sm font-semibold text-gray-900 mb-4">Quick Links</h3>
            <ul className="space-y-3">
              <li>
                <Link href="/services" className="text-gray-600 hover:text-gray-900">
                  Services
                </Link>
              </li>
              <li>
                <Link href="/contractors" className="text-gray-600 hover:text-gray-900">
                  Find Contractors
                </Link>
              </li>
              <li>
                <Link href="/about" className="text-gray-600 hover:text-gray-900">
                  About Us
                </Link>
              </li>
            </ul>
          </div>

          {/* Services - SEO optimized categories */}
          <div>
            <h3 className="text-sm font-semibold text-gray-900 mb-4">Services</h3>
            <ul className="space-y-3">
              <li>
                <Link href="/services/home-improvement" className="text-gray-600 hover:text-gray-900">
                  Home Improvement
                </Link>
              </li>
              <li>
                <Link href="/services/renovation" className="text-gray-600 hover:text-gray-900">
                  Renovation
                </Link>
              </li>
              <li>
                <Link href="/services/maintenance" className="text-gray-600 hover:text-gray-900">
                  Maintenance
                </Link>
              </li>
            </ul>
          </div>

          {/* Contact - SEO optimized with location information */}
          <div>
            <h3 className="text-sm font-semibold text-gray-900 mb-4">Contact</h3>
            <address className="text-gray-600 not-italic">
              <p>Denver, Colorado</p>
              <p className="mt-2">
                <a href="mailto:contact@denvercontractors.com" className="hover:text-gray-900">
                  contact@denvercontractors.com
                </a>
              </p>
            </address>
          </div>
        </div>

        {/* Copyright - SEO optimized with current year */}
        <div className="mt-8 pt-8 border-t border-gray-200">
          <p className="text-gray-500 text-sm text-center">
            {new Date().getFullYear()} Denver Contractors. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
