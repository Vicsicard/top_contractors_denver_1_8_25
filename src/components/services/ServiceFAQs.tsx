'use client'

import { useState } from 'react'

interface FAQ {
  question: string
  answer: string
}

interface ServiceFAQsProps {
  trade: string
  location: string
}

export function ServiceFAQs({ trade, location }: ServiceFAQsProps) {
  const [openIndex, setOpenIndex] = useState<number | null>(null)

  // Generate dynamic FAQs based on trade and location
  const faqs: FAQ[] = [
    {
      question: `How do I find a reliable ${trade.toLowerCase()} in ${location}?`,
      answer: `To find a reliable ${trade.toLowerCase()} in ${location}, start by checking our verified contractor listings. Look for contractors with good Google reviews, proper licensing, and experience in your specific type of project. You can also ask for references and examples of their previous work in the ${location} area.`
    },
    {
      question: `What should I look for when hiring a ${trade.toLowerCase()}?`,
      answer: `When hiring a ${trade.toLowerCase()}, ensure they: 1) Are properly licensed and insured, 2) Have experience with your type of project, 3) Can provide references, 4) Offer written estimates, and 5) Have good reviews from previous customers in ${location}.`
    },
    {
      question: `What are typical rates for ${trade.toLowerCase()} in ${location}?`,
      answer: `Rates for ${trade.toLowerCase()} in ${location} vary based on the project scope, materials needed, and complexity. While we don't list specific prices as they frequently change, we recommend getting quotes from multiple contractors to compare rates and services offered.`
    },
    {
      question: `How long does it typically take to complete ${trade.toLowerCase()} work?`,
      answer: `The timeline for ${trade.toLowerCase()} work depends on the project scope. Small repairs might take a few hours, while larger projects could take several days or weeks. Our listed contractors can provide more specific timelines based on your project requirements.`
    },
    {
      question: `Do ${trade.toLowerCase()} in ${location} need to be licensed?`,
      answer: `Yes, ${trade.toLowerCase()} in ${location} and the greater Denver metro area typically need proper licensing and permits for their work. Always verify a contractor's credentials and ensure they pull necessary permits for your project.`
    }
  ]

  // Generate FAQ Schema
  const faqSchema = {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map((faq) => ({
      '@type': 'Question',
      name: faq.question,
      acceptedAnswer: {
        '@type': 'Answer',
        text: faq.answer
      }
    }))
  }

  return (
    <section className="py-12 bg-gray-50">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">
          Frequently Asked Questions
        </h2>

        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(faqSchema) }}
        />

        <div className="max-w-3xl mx-auto space-y-4">
          {faqs.map((faq, index) => (
            <div
              key={index}
              className="bg-white rounded-lg shadow-md overflow-hidden"
            >
              <button
                className="w-full px-6 py-4 text-left flex justify-between items-center hover:bg-gray-50"
                onClick={() => setOpenIndex(openIndex === index ? null : index)}
              >
                <span className="font-medium text-gray-900">{faq.question}</span>
                <svg
                  className={`w-5 h-5 text-gray-500 transform transition-transform ${
                    openIndex === index ? 'rotate-180' : ''
                  }`}
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M19 9l-7 7-7-7"
                  />
                </svg>
              </button>
              {openIndex === index && (
                <div className="px-6 py-4 text-gray-600">{faq.answer}</div>
              )}
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
