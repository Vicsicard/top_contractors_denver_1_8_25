import Link from 'next/link';

interface PaginationProps {
  currentPage: number;
  totalPages: number;
  baseUrl: string;
  maxDisplayed?: number;
}

export default function Pagination({ 
  currentPage, 
  totalPages, 
  baseUrl,
  maxDisplayed = 5 
}: PaginationProps): JSX.Element {
  // Don't render pagination if there's only one page
  if (totalPages <= 1) return null;

  // Calculate range of pages to display
  let startPage = Math.max(1, currentPage - Math.floor(maxDisplayed / 2));
  const endPage = Math.min(totalPages, startPage + maxDisplayed - 1);

  // Adjust start if we're near the end
  if (endPage - startPage + 1 < maxDisplayed) {
    startPage = Math.max(1, endPage - maxDisplayed + 1);
  }

  // Generate page numbers to display
  const pages = Array.from(
    { length: endPage - startPage + 1 },
    (_, i) => startPage + i
  );

  // Helper function to generate page URLs
  const getPageUrl = (page: number): string => {
    return page === 1 ? baseUrl : `${baseUrl}?page=${page}`;
  };

  return (
    <nav
      role="navigation"
      aria-label="Pagination Navigation"
      className="flex justify-center items-center space-x-2"
    >
      {/* Previous page button */}
      {currentPage > 1 && (
        <Link
          href={getPageUrl(currentPage - 1)}
          className="px-3 py-2 rounded-md bg-gray-100 hover:bg-gray-200 text-gray-700"
          aria-label="Go to previous page"
          rel="prev"
        >
          ←
        </Link>
      )}

      {/* First page if not in range */}
      {startPage > 1 && (
        <>
          <Link
            href={baseUrl}
            className="px-3 py-2 rounded-md hover:bg-gray-100"
            aria-label="Go to page 1"
          >
            1
          </Link>
          {startPage > 2 && (
            <span className="px-2 text-gray-500" aria-hidden="true">
              ...
            </span>
          )}
        </>
      )}

      {/* Page numbers */}
      {pages.map((page) => {
        const isCurrentPage = page === currentPage;
        return (
          <Link
            key={page}
            href={getPageUrl(page)}
            className={`px-3 py-2 rounded-md ${
              isCurrentPage
                ? 'bg-blue-600 text-white'
                : 'hover:bg-gray-100 text-gray-700'
            }`}
            aria-label={`Go to page ${page}`}
            aria-current={isCurrentPage ? 'page' : undefined}
          >
            {page}
          </Link>
        );
      })}

      {/* Last page if not in range */}
      {endPage < totalPages && (
        <>
          {endPage < totalPages - 1 && (
            <span className="px-2 text-gray-500" aria-hidden="true">
              ...
            </span>
          )}
          <Link
            href={getPageUrl(totalPages)}
            className="px-3 py-2 rounded-md hover:bg-gray-100"
            aria-label={`Go to page ${totalPages}`}
          >
            {totalPages}
          </Link>
        </>
      )}

      {/* Next page button */}
      {currentPage < totalPages && (
        <Link
          href={getPageUrl(currentPage + 1)}
          className="px-3 py-2 rounded-md bg-gray-100 hover:bg-gray-200 text-gray-700"
          aria-label="Go to next page"
          rel="next"
        >
          →
        </Link>
      )}
    </nav>
  );
}
