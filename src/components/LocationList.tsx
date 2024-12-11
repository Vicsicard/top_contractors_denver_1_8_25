import { ReactNode } from 'react';
import Link from 'next/link';
import { parseUrlSegment } from '@/utils/urlHelpers';

interface Location {
  location: string;
  county: string;
}

interface LocationListProps {
  keyword: string;
  locations: Location[];
}

export default function LocationList({ keyword, locations }: LocationListProps): ReactNode {
  const parsedKeyword = parseUrlSegment(keyword);

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {locations.map((loc) => {
        const parsedLocation = parseUrlSegment(loc.location);
        return (
          <Link
            key={loc.location}
            href={`/${parsedKeyword}/${parsedLocation}`}
            className="p-6 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow"
          >
            <h2 className="text-xl font-semibold mb-2">{loc.location}</h2>
            <p className="text-gray-600">{loc.county} County</p>
          </Link>
        );
      })}
    </div>
  );
}
