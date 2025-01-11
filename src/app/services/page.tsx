import Link from 'next/link'
import { Metadata } from 'next'
import { ServiceHero } from '@/components/services/ServiceHero'
import { getAllTrades } from '@/utils/database'

export const metadata: Metadata = {
  title: 'Contractor Services | Top Contractors Denver',
  description: 'Find local contractors in Denver for plumbing, electrical, HVAC, and more. Browse our directory of professional contractors serving the Denver metro area.',
}

export default async function ServicesPage() {
  const trades = await getAllTrades()

  // Icons for each trade
  const tradeIcons: Record<string, string> = {
    'Plumbers': '🔧',
    'Electricians': '⚡',
    'HVAC Contractors': '❄️',
    'Roofers': '🏠',
    'General Contractors': '🏗️',
    'Painters': '🎨',
    'Landscapers': '🌳',
    'Concrete Contractors': '🏗️',
    'Drywall Contractors': '🏢',
    'Fencing Contractors': '🚧',
    'Flooring Contractors': '🏠',
    'Garage Door Contractors': '🚪',
    'Handyman Services': '🔨',
    'Siding Contractors': '🏘️',
    'Tree Service Contractors': '🌲',
    'Window Contractors': '🪟',
  }

  return (
    <main>
      <ServiceHero
        title="Find Local Contractors in Denver"
        description="Browse our directory of professional contractors serving the Denver metro area"
      />

      <section className="py-12 bg-white">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold text-gray-900 mb-8 text-center">
            Browse by Service
          </h2>

          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {trades.map((trade) => (
              <Link
                key={trade.id}
                href={`/services/${trade.slug}`}
                className="group"
              >
                <div className="bg-white rounded-lg shadow-md p-6 hover:shadow-lg transition-shadow">
                  <div className="flex items-center mb-4">
                    <span className="text-3xl mr-3" aria-hidden="true">
                      {tradeIcons[trade.category_name] || '🔨'}
                    </span>
                    <h3 className="text-xl font-semibold text-gray-900 group-hover:text-blue-600 transition-colors">
                      {trade.category_name}
                    </h3>
                  </div>
                  
                  <p className="text-gray-600">
                    Find {trade.category_name.toLowerCase()} in the Denver metro area
                  </p>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </section>
    </main>
  )
}
