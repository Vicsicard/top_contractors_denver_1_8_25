interface Contractor {
  id: string;
  name: string;
  rating: number;
  reviewCount: number;
  address: string;
  phone?: string;
  website?: string;
  services: string[];
}

interface CategoryListProps {
  keyword: string;
  location: {
    location: string;
    county: string;
  };
  contractors: Contractor[];
}

export default function CategoryList({
  keyword,
  location,
  contractors,
}: CategoryListProps) {
  return (
    <div className="space-y-8">
      {contractors.map((contractor, index) => (
        <article
          key={contractor.id}
          className="bg-white rounded-lg shadow-sm p-6 transition-shadow hover:shadow-md"
          itemScope
          itemType="https://schema.org/LocalBusiness"
        >
          {/* Rank Number */}
          <div className="flex items-start gap-4">
            <div className="flex-shrink-0 w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
              <span className="text-xl font-bold text-blue-600">#{index + 1}</span>
            </div>

            <div className="flex-grow">
              {/* Business Name */}
              <h2 className="text-xl font-semibold mb-2" itemProp="name">
                {contractor.name}
              </h2>

              {/* Rating */}
              <div className="flex items-center mb-3">
                <div
                  className="flex items-center"
                  itemProp="aggregateRating"
                  itemScope
                  itemType="https://schema.org/AggregateRating"
                >
                  <div className="flex items-center">
                    {[...Array(5)].map((_, i) => (
                      <svg
                        key={i}
                        className={`w-5 h-5 ${
                          i < Math.floor(contractor.rating)
                            ? 'text-yellow-400'
                            : 'text-gray-300'
                        }`}
                        fill="currentColor"
                        viewBox="0 0 20 20"
                      >
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                      </svg>
                    ))}
                  </div>
                  <span className="ml-2 text-gray-600">
                    <span itemProp="ratingValue">{contractor.rating}</span>
                    <span className="mx-1">•</span>
                    <span itemProp="reviewCount">{contractor.reviewCount}</span>{' '}
                    reviews
                  </span>
                </div>
              </div>

              {/* Address */}
              <div
                className="text-gray-600 mb-2"
                itemProp="address"
                itemScope
                itemType="https://schema.org/PostalAddress"
              >
                <span itemProp="streetAddress">{contractor.address}</span>
              </div>

              {/* Services */}
              <div className="flex flex-wrap gap-2 mb-3">
                {contractor.services.map((service) => (
                  <span
                    key={service}
                    className="px-3 py-1 bg-gray-100 text-gray-700 text-sm rounded-full"
                  >
                    {service}
                  </span>
                ))}
              </div>

              {/* Contact Information */}
              <div className="flex items-center gap-4 mt-4">
                {contractor.phone && (
                  <a
                    href={`tel:${contractor.phone}`}
                    className="inline-flex items-center text-blue-600 hover:text-blue-700"
                    itemProp="telephone"
                  >
                    <svg
                      className="w-5 h-5 mr-2"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
                      />
                    </svg>
                    {contractor.phone}
                  </a>
                )}
                {contractor.website && (
                  <a
                    href={contractor.website}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center text-blue-600 hover:text-blue-700"
                    itemProp="url"
                  >
                    <svg
                      className="w-5 h-5 mr-2"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9m-9 9a9 9 0 019-9"
                      />
                    </svg>
                    Visit Website
                  </a>
                )}
              </div>
            </div>
          </div>
        </article>
      ))}
    </div>
  );
}
