interface PriceRange {
  low: number
  high: number
  unit?: string
}

interface CostFactor {
  factor: string
  description: string
}

interface ServicePricingProps {
  priceRange: PriceRange
  costFactors: CostFactor[]
}

export function ServicePricing({ priceRange, costFactors }: ServicePricingProps) {
  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    }).format(price)
  }

  return (
    <div className="bg-white py-12">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-gray-900 mb-8">Pricing Guide</h2>
        
        <div className="bg-blue-50 rounded-lg p-6 mb-8">
          <p className="text-lg mb-2">Typical Price Range:</p>
          <p className="text-3xl font-bold text-blue-600">
            {formatPrice(priceRange.low)} - {formatPrice(priceRange.high)}
            {priceRange.unit && <span className="text-lg ml-1">{priceRange.unit}</span>}
          </p>
        </div>

        <div>
          <h3 className="text-xl font-semibold mb-4">Cost Factors</h3>
          <div className="grid gap-4">
            {costFactors.map((factor, index) => (
              <div key={index} className="bg-gray-50 rounded-lg p-4">
                <h4 className="font-semibold text-gray-900 mb-2">{factor.factor}</h4>
                <p className="text-gray-600">{factor.description}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
