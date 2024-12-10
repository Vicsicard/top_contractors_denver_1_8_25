import Link from 'next/link';
export default function Breadcrumbs({ keyword, location }) {
    return (<nav className="text-sm breadcrumbs py-4">
      <ul>
        <li>
          <Link href="/" className="hover:underline">
            Home
          </Link>
        </li>
        <li>
          <Link href={`/${keyword}`} className="hover:underline">
            {keyword}
          </Link>
        </li>
        <li className="text-gray-600">{location}</li>
      </ul>
    </nav>);
}
