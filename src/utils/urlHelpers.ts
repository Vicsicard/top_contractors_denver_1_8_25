// Sanitize and format URL segments
export function formatUrlSegment(segment: string): string {
  return segment
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-') // Replace non-alphanumeric chars with hyphens
    .replace(/^-+|-+$/g, ''); // Remove leading/trailing hyphens
}

// Format location for URL (e.g., "Denver, CO" -> "denver-co")
export function formatLocationForUrl(location: string): string {
  return location
    .replace(/,\s*/g, '-') // Replace commas and spaces with hyphen
    .split(' ')
    .map(formatUrlSegment)
    .join('-');
}

// Format keyword for URL (e.g., "Home Improvement" -> "home-improvement")
export function formatKeywordForUrl(keyword: string): string {
  return formatUrlSegment(keyword);
}

// Parse URL segments back into display format
export function parseUrlSegment(segment: string): string {
  return segment
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
}
