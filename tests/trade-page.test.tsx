import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import TradePage from '../src/app/trades/[slug]/page';
import * as database from '@/utils/database';

// Mock the database utilities
jest.mock('@/utils/database', () => ({
  getTradeBySlug: jest.fn(),
  getAllSubregions: jest.fn(),
  getTradeStats: jest.fn(),
}));

// Mock next/navigation
jest.mock('next/navigation', () => ({
  notFound: jest.fn(),
}));

describe('TradePage', () => {
  const mockTrade = {
    id: '1',
    category_name: 'Bathroom Remodelers',
    slug: 'bathroom-remodelers',
    created_at: '2025-01-09T14:56:32Z',
    updated_at: '2025-01-09T14:56:32Z'
  };

  const mockStats = {
    totalContractors: 25,
    avgRating: 4.5,
    totalReviews: 500
  };

  const mockSubregions = [
    {
      id: '1',
      subregion_name: 'Denver Tech Center',
      slug: 'denver-tech-center',
      created_at: '2025-01-09T14:56:32Z',
      updated_at: '2025-01-09T14:56:32Z'
    },
    {
      id: '2',
      subregion_name: 'Cherry Creek',
      slug: 'cherry-creek',
      created_at: '2025-01-09T14:56:32Z',
      updated_at: '2025-01-09T14:56:32Z'
    }
  ];

  beforeEach(() => {
    // Reset all mocks before each test
    jest.clearAllMocks();
    
    // Setup default mock implementations
    (database.getTradeBySlug as jest.Mock).mockResolvedValue(mockTrade);
    (database.getAllSubregions as jest.Mock).mockResolvedValue(mockSubregions);
    (database.getTradeStats as jest.Mock).mockResolvedValue(mockStats);
  });

  it('renders trade page with correct information', async () => {
    const params = { slug: 'bathroom-remodelers' };
    render(await TradePage({ params }));

    // Verify trade name is displayed
    expect(screen.getByText('Bathroom Remodelers')).toBeInTheDocument();

    // Verify statistics are displayed
    expect(screen.getByText('25')).toBeInTheDocument();
    expect(screen.getByText('4.5')).toBeInTheDocument();
    expect(screen.getByText('500')).toBeInTheDocument();
    expect(screen.getByText('Contractors')).toBeInTheDocument();
    expect(screen.getByText('Avg Rating')).toBeInTheDocument();
    expect(screen.getByText('Reviews')).toBeInTheDocument();

    // Verify subregions are displayed
    expect(screen.getByText('Denver Tech Center')).toBeInTheDocument();
    expect(screen.getByText('Cherry Creek')).toBeInTheDocument();
  });

  it('calls notFound() when trade is not found', async () => {
    const notFound = jest.requireMock('next/navigation').notFound;
    (database.getTradeBySlug as jest.Mock).mockResolvedValue(null);

    try {
      await TradePage({ params: { slug: 'non-existent-trade' } });
    } catch (error) {
      // Expected to throw when notFound is called
    }
    expect(notFound).toHaveBeenCalled();
  });

  it('fetches data with correct parameters', async () => {
    const params = { slug: 'bathroom-remodelers' };
    await TradePage({ params });

    expect(database.getTradeBySlug).toHaveBeenCalledWith('bathroom-remodelers');
    expect(database.getAllSubregions).toHaveBeenCalled();
    expect(database.getTradeStats).toHaveBeenCalledWith('bathroom-remodelers');
  });
});
