import Link from 'next/link';

interface BreadcrumbsProps {
  keyword: string;
  location: string;
}

export default function Breadcrumbs({ keyword, location }: BreadcrumbsProps): JSX.Element {
  return (
    <nav className="text-sm text-gray-600 mb-6" aria-label="Breadcrumb">
      <ol className="list-none p-0 inline-flex">
        <li className="flex items-center">
          <Link href="/" className="hover:text-blue-600">
            Home
          </Link>
          <span className="mx-2">/</span>
        </li>
        <li className="flex items-center">
          <Link href={`/${encodeURIComponent(keyword)}`} className="hover:text-blue-600">
            {keyword}
          </Link>
          <span className="mx-2">/</span>
        </li>
        <li className="text-gray-800" aria-current="page">
          {location}
        </li>
      </ol>
    </nav>
  );
}