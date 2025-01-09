import '@testing-library/jest-dom';

// Mock environment variables
process.env.NEXT_PUBLIC_SUPABASE_URL = 'http://localhost:54321';
process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = 'test-anon-key';

// Mock Supabase client
jest.mock('../src/lib/supabase/client', () => ({
  supabase: {
    from: jest.fn(() => ({
      select: jest.fn(() => ({
        order: jest.fn(() => Promise.resolve({
          data: [
            {
              id: '1',
              category_name: 'Bathroom Remodelers',
              slug: 'bathroom-remodelers',
              created_at: '2025-01-09T14:56:32Z',
              updated_at: '2025-01-09T14:56:32Z'
            }
          ],
          error: null
        }))
      }))
    }))
  }
}));

// Mock next/navigation
jest.mock('next/navigation', () => ({
  useRouter() {
    return {
      push: jest.fn(),
      replace: jest.fn(),
      prefetch: jest.fn()
    };
  },
  useSearchParams() {
    return {
      get: jest.fn()
    };
  }
}));
