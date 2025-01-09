import { denverRegions } from './locations';
import { LocationError, logError } from './error-utils';

export function getLocationFromSlugs(regionSlug: string, areaSlug: string, neighborhoodSlug: string) {
  try {
    const region = denverRegions[regionSlug];
    if (!region) {
      throw new LocationError(
        `Region not found: ${regionSlug}`,
        'INVALID_REGION',
        { region: regionSlug }
      );
    }

    const area = region.areas[areaSlug];
    if (!area) {
      throw new LocationError(
        `Area not found: ${areaSlug} in region ${region.name}`,
        'INVALID_AREA',
        { area: areaSlug, region: region.name }
      );
    }

    if (neighborhoodSlug) {
      const neighborhood = area.neighborhoods.find(n => n.slug === neighborhoodSlug);
      if (!neighborhood) {
        throw new LocationError(
          `Neighborhood not found: ${neighborhoodSlug} in area ${area.name}`,
          'INVALID_NEIGHBORHOOD',
          { neighborhood: neighborhoodSlug, area: area.name, region: region.name }
        );
      }
      return { region, area, neighborhood };
    }

    return { region, area };
  } catch (error) {
    if (error instanceof LocationError) {
      logError(error, {
        function: 'getLocationFromSlugs',
        params: { regionSlug, areaSlug, neighborhoodSlug }
      });
      throw error;
    }
    // If it's an unexpected error, wrap it
    const unexpectedError = new Error('An unexpected error occurred while processing location');
    logError(unexpectedError, {
      function: 'getLocationFromSlugs',
      params: { regionSlug, areaSlug, neighborhoodSlug },
      originalError: error
    });
    throw unexpectedError;
  }
}

export function validateLocationSlugs(regionSlug: string, areaSlug: string, neighborhoodSlug?: string): boolean {
  try {
    getLocationFromSlugs(regionSlug, areaSlug, neighborhoodSlug || '');
    return true;
  } catch (error) {
    if (error instanceof LocationError) {
      return false;
    }
    throw error;
  }
}

export function slugify(text: string): string {
  if (!text) {
    logError(new Error('Empty text provided to slugify'), {
      function: 'slugify',
      params: { text }
    });
    return '';
  }

  return text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '');
}

export function buildLocationPath(regionSlug: string, areaSlug: string, neighborhoodSlug?: string): string {
  try {
    // Validate the slugs first
    if (!validateLocationSlugs(regionSlug, areaSlug, neighborhoodSlug)) {
      throw new Error('Invalid location slugs provided');
    }

    const path = neighborhoodSlug
      ? `/${regionSlug}/${areaSlug}/${neighborhoodSlug}`
      : `/${regionSlug}/${areaSlug}`;

    return path;
  } catch (error) {
    logError(error as Error, {
      function: 'buildLocationPath',
      params: { regionSlug, areaSlug, neighborhoodSlug }
    });
    throw error;
  }
}
