import React from 'react';
import Link from 'next/link';
import { DENVER_LOCATIONS } from '@/types/locations';

export const LocationCategories = () => {
  return (
    <div className="space-y-12">
      {DENVER_LOCATIONS.map((category) => (
        <div key={category.name} className="bg-white rounded-xl shadow-lg overflow-hidden">
          <div className="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-900 text-white px-8 py-6">
            <h2 className="text-3xl font-bold">{category.name}</h2>
          </div>
          <div className="p-8">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {category.subcategories.map((subcategory) => (
                <div key={subcategory.name} 
                  className="bg-gradient-to-br from-gray-50 to-blue-50 rounded-xl p-6 shadow-md 
                  transition-all duration-300 hover:shadow-lg hover:scale-[1.02]"
                >
                  <h3 className="text-xl font-semibold text-blue-900 mb-4 border-b border-blue-100 pb-3">
                    {subcategory.name}
                  </h3>
                  <ul className="space-y-2.5">
                    {subcategory.areas.map((area) => (
                      <li key={area}>
                        <Link 
                          href={`/location/${encodeURIComponent(area.toLowerCase().replace(/\s+/g, '-'))}`}
                          className="text-blue-700 hover:text-blue-900 hover:underline block py-1 transition-colors duration-200"
                        >
                          {area}
                        </Link>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default LocationCategories;
