import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import TradeSubregionPage from '../src/app/trades/[slug]/[subregion]/page';
import * as database from '@/utils/database';

// Mock the database utilities
jest.mock('@/utils/database', () => ({
  getTradeBySlug: jest.fn(),
  getSubregionBySlug: jest.fn(),
  getContractorsByTradeAndSubregion: jest.fn(),
}));

// Mock next/navigation
jest.mock('next/navigation', () => ({
  notFound: jest.fn(),
}));

describe('TradeSubregionPage', () => {
  const mockTrade = {
    id: '1',
    category_name: 'Bathroom Remodelers',
    slug: 'bathroom-remodelers',
    created_at: '2025-01-09T14:56:32Z',
    updated_at: '2025-01-09T14:56:32Z'
  };

  const mockSubregion = {
    id: '1',
    subregion_name: 'Denver Tech Center',
    slug: 'denver-tech-center',
    created_at: '2025-01-09T14:56:32Z',
    updated_at: '2025-01-09T14:56:32Z'
  };

  const mockContractors = [
    {
      id: '1',
      category_id: 'cat-1',
      subregion_id: 'sub-1',
      contractor_name: 'ABC Remodeling',
      address: '123 Tech Center Dr, Denver, CO',
      phone: '303-555-0123',
      website: 'https://abcremodeling.com',
      reviews_avg: 4.8,
      reviews_count: 150,
      slug: 'abc-remodeling',
      created_at: '2025-01-09T14:56:32Z',
      updated_at: '2025-01-09T14:56:32Z',
      google_rating: 4.8,
      google_review_count: 150,
      category_slug: 'bathroom-remodelers',
      subregion_slug: 'denver-tech-center'
    },
    {
      id: '2',
      category_id: 'cat-1',
      subregion_id: 'sub-1',
      contractor_name: 'XYZ Bathrooms',
      address: '456 Tech Center Dr, Denver, CO',
      phone: '303-555-0456',
      website: 'https://xyzbathrooms.com',
      reviews_avg: 4.5,
      reviews_count: 120,
      slug: 'xyz-bathrooms',
      created_at: '2025-01-09T14:56:32Z',
      updated_at: '2025-01-09T14:56:32Z',
      google_rating: 4.5,
      google_review_count: 120,
      category_slug: 'bathroom-remodelers',
      subregion_slug: 'denver-tech-center'
    }
  ];

  beforeEach(() => {
    // Reset all mocks before each test
    jest.clearAllMocks();
    
    // Setup default mock implementations
    (database.getTradeBySlug as jest.Mock).mockResolvedValue(mockTrade);
    (database.getSubregionBySlug as jest.Mock).mockResolvedValue(mockSubregion);
    (database.getContractorsByTradeAndSubregion as jest.Mock).mockResolvedValue(mockContractors);
  });

  it('renders page with correct trade and subregion information', async () => {
    const params = { slug: 'bathroom-remodelers', subregion: 'denver-tech-center' };
    render(await TradeSubregionPage({ params }));

    // Verify header information
    expect(screen.getByText('Bathroom Remodelers')).toBeInTheDocument();
    expect(screen.getByText('in Denver Tech Center')).toBeInTheDocument();

    // Verify contractor information
    expect(screen.getByText('ABC Remodeling')).toBeInTheDocument();
    expect(screen.getByText('XYZ Bathrooms')).toBeInTheDocument();
    expect(screen.getByText('123 Tech Center Dr, Denver, CO')).toBeInTheDocument();
    expect(screen.getByText('456 Tech Center Dr, Denver, CO')).toBeInTheDocument();
  });

  it('calls notFound() when trade is not found', async () => {
    const notFound = jest.requireMock('next/navigation').notFound;
    (database.getTradeBySlug as jest.Mock).mockResolvedValue(null);

    try {
      await TradeSubregionPage({ params: { slug: 'invalid', subregion: 'denver-tech-center' } });
    } catch (error) {
      // Expected to throw when notFound is called
    }
    expect(notFound).toHaveBeenCalled();
  });

  it('calls notFound() when subregion is not found', async () => {
    const notFound = jest.requireMock('next/navigation').notFound;
    (database.getSubregionBySlug as jest.Mock).mockResolvedValue(null);

    try {
      await TradeSubregionPage({ params: { slug: 'bathroom-remodelers', subregion: 'invalid' } });
    } catch (error) {
      // Expected to throw when notFound is called
    }
    expect(notFound).toHaveBeenCalled();
  });

  it('handles empty contractor list', async () => {
    (database.getContractorsByTradeAndSubregion as jest.Mock).mockResolvedValue([]);
    
    const params = { slug: 'bathroom-remodelers', subregion: 'denver-tech-center' };
    render(await TradeSubregionPage({ params }));

    expect(screen.getByText('No contractors found in this area. Please try another location.')).toBeInTheDocument();
  });

  it('fetches data with correct parameters', async () => {
    const params = { slug: 'bathroom-remodelers', subregion: 'denver-tech-center' };
    await TradeSubregionPage({ params });

    expect(database.getTradeBySlug).toHaveBeenCalledWith('bathroom-remodelers');
    expect(database.getSubregionBySlug).toHaveBeenCalledWith('denver-tech-center');
    expect(database.getContractorsByTradeAndSubregion).toHaveBeenCalledWith('bathroom-remodelers', 'denver-tech-center');
  });
});
