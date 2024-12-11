import Link from 'next/link';
import React from 'react';

interface BreadcrumbsProps {
  keyword?: string;
  location?: string;
}

export default function Breadcrumbs({ keyword, location }: BreadcrumbsProps): React.ReactElement {
  return (
    <nav className="text-sm text-gray-600 mb-6" aria-label="Breadcrumb">
      <ol className="list-none p-0 inline-flex">
        <li>
          <Link href="/" className="hover:text-blue-600">
            Home
          </Link>
        </li>
        {keyword && (
          <li className="flex items-center">
            <span className="mx-2">/</span>
            <Link href={`/${encodeURIComponent(keyword)}`} className="hover:text-blue-600">
              {keyword}
            </Link>
            {location && <span className="mx-2">/</span>}
          </li>
        )}
        {location && keyword && (
          <li className="flex items-center">
            <Link href={`/${encodeURIComponent(keyword)}/${encodeURIComponent(location)}`} className="hover:text-blue-600">
              {location}
            </Link>
          </li>
        )}
      </ol>
    </nav>
  );
}