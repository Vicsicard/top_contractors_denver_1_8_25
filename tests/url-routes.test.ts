import { describe, expect, test } from '@jest/globals';
import { createSlug } from '../src/utils/slugs';

// Import the slug functions from both files to test them
import {
  createTradeSlug as pageCreateTradeSlug,
  createRegionSlug as pageCreateRegionSlug,
  createAreaSlug as pageCreateAreaSlug,
} from '../src/app/[trade]/[region]/[area]/page';

import {
  createTradeSlug as apiCreateTradeSlug,
  createRegionSlug as apiCreateRegionSlug,
  createAreaSlug as apiCreateAreaSlug,
} from '../src/app/api/locations/[trade]/[region]/[area]/route';

// Test data from database
const databaseData = {
  trades: [
    { name: 'Plumbers', slug: 'plumbers' },
    { name: 'Electricians', slug: 'electricians' },
    { name: 'HVAC', slug: 'hvac' },
    { name: 'Roofers', slug: 'roofers' },
    { name: 'Painters', slug: 'painters' },
  ],
  regions: [
    { name: 'Central Denver', slug: 'central-denver' },
    { name: 'East Denver', slug: 'east-denver' },
    { name: 'Northwest Suburbs', slug: 'northwest-suburbs' },
    { name: 'Northeast Suburbs', slug: 'northeast-suburbs' },
    { name: 'Southeast Suburbs', slug: 'southeast-suburbs' },
  ],
  areas: [
    { name: 'Downtown Area', slug: 'downtown-area' },
    { name: 'Central Parks Area', slug: 'central-parks-area' },
    { name: 'Central Shopping Area', slug: 'central-shopping-area' },
  ],
};

describe('URL Route Tests', () => {
  // Test that page and API slug functions are identical
  describe('Slug Function Consistency', () => {
    test('trade slug functions should be identical', () => {
      const inputs = [
        'plumber',
        'Plumber',
        'PLUMBER',
        'electrician',
        'HVAC',
        'hvac',
        'roofer',
        'painter',
      ];

      inputs.forEach(input => {
        expect(pageCreateTradeSlug(input)).toBe(apiCreateTradeSlug(input));
      });
    });

    test('region slug functions should be identical', () => {
      const inputs = [
        'central denver',
        'Central Denver',
        'CENTRAL DENVER',
        'east denver',
        'Northwest Suburbs',
      ];

      inputs.forEach(input => {
        expect(pageCreateRegionSlug(input)).toBe(apiCreateRegionSlug(input));
      });
    });

    test('area slug functions should be identical', () => {
      const inputs = [
        'downtown',
        'Downtown Area',
        'DOWNTOWN',
        'central parks',
        'Central Parks Area',
      ];

      inputs.forEach(input => {
        expect(pageCreateAreaSlug(input)).toBe(apiCreateAreaSlug(input));
      });
    });
  });

  // Test that slug functions match database values
  describe('Database Slug Matching', () => {
    test('trade slugs should match database', () => {
      const testCases = [
        { input: 'plumber', expected: 'plumbers' },
        { input: 'Plumber', expected: 'plumbers' },
        { input: 'PLUMBER', expected: 'plumbers' },
        { input: 'electrician', expected: 'electricians' },
        { input: 'HVAC', expected: 'hvac' },
        { input: 'hvac', expected: 'hvac' },
        { input: 'roofer', expected: 'roofers' },
        { input: 'painter', expected: 'painters' },
      ];

      testCases.forEach(({ input, expected }) => {
        expect(pageCreateTradeSlug(input)).toBe(expected);
        expect(apiCreateTradeSlug(input)).toBe(expected);
      });
    });

    test('region slugs should match database', () => {
      const testCases = [
        { input: 'central denver', expected: 'central-denver' },
        { input: 'Central Denver', expected: 'central-denver' },
        { input: 'CENTRAL DENVER', expected: 'central-denver' },
        { input: 'east denver', expected: 'east-denver' },
        { input: 'East Denver', expected: 'east-denver' },
        { input: 'northwest suburbs', expected: 'northwest-suburbs' },
        { input: 'Northwest Suburbs', expected: 'northwest-suburbs' },
      ];

      testCases.forEach(({ input, expected }) => {
        expect(pageCreateRegionSlug(input)).toBe(expected);
        expect(apiCreateRegionSlug(input)).toBe(expected);
      });
    });

    test('area slugs should match database', () => {
      const testCases = [
        { input: 'downtown', expected: 'downtown-area' },
        { input: 'Downtown Area', expected: 'downtown-area' },
        { input: 'DOWNTOWN', expected: 'downtown-area' },
        { input: 'central parks', expected: 'central-parks-area' },
        { input: 'Central Parks', expected: 'central-parks-area' },
        { input: 'Central Parks Area', expected: 'central-parks-area' },
        { input: 'central shopping', expected: 'central-shopping-area' },
        { input: 'Central Shopping Area', expected: 'central-shopping-area' },
      ];

      testCases.forEach(({ input, expected }) => {
        expect(pageCreateAreaSlug(input)).toBe(expected);
        expect(apiCreateAreaSlug(input)).toBe(expected);
      });
    });
  });

  // Test URL encoding/decoding
  describe('URL Parameter Handling', () => {
    test('should handle URL-encoded parameters', () => {
      const testCases = [
        {
          input: {
            trade: 'plumber',
            region: 'central%20denver',
            area: 'central%20parks',
          },
          expected: {
            trade: 'plumbers',
            region: 'central-denver',
            area: 'central-parks-area',
          },
        },
        {
          input: {
            trade: 'HVAC',
            region: 'east%20denver',
            area: 'downtown',
          },
          expected: {
            trade: 'hvac',
            region: 'east-denver',
            area: 'downtown-area',
          },
        },
      ];

      testCases.forEach(({ input, expected }) => {
        const decodedTrade = decodeURIComponent(input.trade);
        const decodedRegion = decodeURIComponent(input.region);
        const decodedArea = decodeURIComponent(input.area);

        expect(pageCreateTradeSlug(decodedTrade)).toBe(expected.trade);
        expect(pageCreateRegionSlug(decodedRegion)).toBe(expected.region);
        expect(pageCreateAreaSlug(decodedArea)).toBe(expected.area);

        expect(apiCreateTradeSlug(decodedTrade)).toBe(expected.trade);
        expect(apiCreateRegionSlug(decodedRegion)).toBe(expected.region);
        expect(apiCreateAreaSlug(decodedArea)).toBe(expected.area);
      });
    });
  });
});
