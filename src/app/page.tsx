import React from 'react';
import Link from 'next/link';
import SearchBox from '@/components/SearchBox';
import InquiryForm from '@/components/InquiryForm';
import PopularTradesSection from '@/components/PopularTrades';
import LocationCategoriesSection from '@/components/LocationCategoriesSection';
import { FaPhone } from 'react-icons/fa';

export default function Home() {
  return (
    <main className="min-h-screen bg-white">
      <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white">
        <div className="container mx-auto px-4 py-24">
          <h1 className="text-5xl md:text-6xl font-bold mb-8 text-center">
            Find Trusted Local Contractors in Denver
          </h1>
          <p className="text-xl mb-12 text-center text-blue-100">
            Connect with verified contractors for your home improvement needs
          </p>
          <div className="max-w-2xl mx-auto">
            <SearchBox />
          </div>
        </div>
      </div>

      <PopularTradesSection />

      <LocationCategoriesSection />

      <section className="py-20 bg-white">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-12 text-blue-900">Why Choose Our Platform?</h2>
          <div className="grid md:grid-cols-3 gap-12">
            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Verified Contractors</h3>
              <p className="text-blue-100">All contractors are thoroughly vetted and verified for your peace of mind</p>
            </div>

            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Fast Response</h3>
              <p className="text-blue-100">Get quick responses from available contractors in your area</p>
            </div>

            <div className="text-center">
              <div className="bg-blue-800 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 8h2a2 2 0 012 2v6a2 2 0 01-2 2h-2v4l-4-4H9a1.994 1.994 0 01-1.414-.586m0 0L11 14h4a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2v4l.586-.586z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold mb-4">Free Consultation</h3>
              <p className="text-blue-100">Get expert advice and estimates at no cost to you</p>
            </div>
          </div>
        </div>
      </section>

      <section id="contact-form" className="py-20 bg-white">
        <div className="container mx-auto px-4">
          <h2 className="text-4xl font-bold mb-4 text-center text-gray-900">Get a Free Estimate</h2>
          <div className="text-center mb-12">
            <p className="text-lg text-gray-600 mb-4">Fill out the form below or call us directly:</p>
            <a 
              href="tel:+17205555555" 
              className="inline-flex items-center text-2xl font-semibold text-green-600 hover:text-green-800 transition-colors"
            >
              <FaPhone className="h-6 w-6 mr-2" />
              (720) 555-5555
            </a>
          </div>
          <div className="max-w-3xl mx-auto">
            <InquiryForm />
          </div>
        </div>
      </section>
    </main>
  );
}
