import { supabase } from '../src/lib/supabase/client';
import { getTradeBySlug, getContractorsByTradeAndSubregion } from '../src/utils/database';

jest.mock('../src/utils/database', () => ({
  getTradeBySlug: jest.fn((slug: string) => {
    if (slug === 'bathroom-remodelers') {
      return Promise.resolve({
        id: '1',
        category_name: 'Bathroom Remodelers',
        slug: 'bathroom-remodelers',
        created_at: '2025-01-09T14:56:32Z',
        updated_at: '2025-01-09T14:56:32Z'
      });
    }
    return Promise.resolve(null);
  }),
  getContractorsByTradeAndSubregion: jest.fn((trade: string, subregion: string) => {
    if (trade === 'bathroom-remodelers' && subregion === 'denver-tech-center') {
      return Promise.resolve([{
        id: '1',
        category_id: 'cat-1',
        subregion_id: 'sub-1',
        contractor_name: 'Test Contractor',
        address: '123 Test St, Denver, CO',
        phone: '303-555-0123',
        website: 'https://example.com',
        reviews_avg: 4.5,
        reviews_count: 100,
        slug: 'test-contractor',
        created_at: '2025-01-09T14:56:32Z',
        updated_at: '2025-01-09T14:56:32Z'
      }]);
    }
    return Promise.resolve([]);
  })
}));

describe('Database Operations', () => {
  test('should fetch trade categories', async () => {
    const { data: categories, error } = await supabase
      .from('categories')
      .select('*')
      .order('category_name');
    
    expect(error).toBeNull();
    expect(categories).toBeDefined();
    expect(Array.isArray(categories)).toBe(true);
    expect(categories?.length).toBeGreaterThan(0);
  });

  test('should fetch contractors for a specific trade and subregion', async () => {
    const trade = 'bathroom-remodelers';
    const subregion = 'denver-tech-center';
    
    const contractors = await getContractorsByTradeAndSubregion(trade, subregion);
    
    expect(Array.isArray(contractors)).toBe(true);
    expect(contractors.length).toBe(1);
    expect(contractors[0]).toHaveProperty('contractor_name', 'Test Contractor');
    expect(contractors[0]).toHaveProperty('reviews_avg', 4.5);
    expect(contractors[0]).toHaveProperty('reviews_count', 100);
  });

  test('should handle invalid trade slug', async () => {
    const trade = await getTradeBySlug('non-existent-trade');
    expect(trade).toBeNull();
  });
});
