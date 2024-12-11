import React from 'react';
import Link from 'next/link';
import { Location } from '@/types/routes';

interface LocationListProps {
  locations: Location[];
  keyword: string;
}

export default function LocationList({ locations, keyword }: LocationListProps): React.ReactElement {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      {locations.map((location) => (
        <Link
          key={location.location}
          href={`/${keyword}/${location.location}`}
          className="p-4 bg-white rounded-lg shadow-sm hover:shadow-md transition-shadow"
        >
          <h2 className="text-xl font-semibold mb-2">{location.location}</h2>
          <p className="text-gray-600">{location.county}</p>
        </Link>
      ))}
    </div>
  );
}
