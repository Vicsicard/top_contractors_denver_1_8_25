import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import { ContractorCard } from '../src/components/contractor-card';

describe('ContractorCard', () => {
  const mockContractor = {
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
  };

  it('displays contractor name and address', () => {
    render(<ContractorCard contractor={mockContractor} />);
    
    expect(screen.getByText('ABC Remodeling')).toBeInTheDocument();
    expect(screen.getByText('123 Tech Center Dr, Denver, CO')).toBeInTheDocument();
  });

  it('displays contact information correctly', () => {
    render(<ContractorCard contractor={mockContractor} />);
    
    expect(screen.getByText('Phone:')).toBeInTheDocument();
    expect(screen.getByText('303-555-0123', { exact: false })).toBeInTheDocument();
    
    const websiteLink = screen.getByText('Visit Website');
    expect(websiteLink).toBeInTheDocument();
    expect(websiteLink).toHaveAttribute('href', 'https://abcremodeling.com');
    expect(websiteLink).toHaveAttribute('target', '_blank');
    expect(websiteLink).toHaveAttribute('rel', 'noopener noreferrer');
  });

  it('displays review information correctly', () => {
    render(<ContractorCard contractor={mockContractor} />);
    
    expect(screen.getByText('(150 reviews)')).toBeInTheDocument();
    
    // Verify star rating
    const stars = document.querySelectorAll('.text-yellow-400');
    expect(stars.length).toBe(5); // 4.8 rounds to 5 stars
  });

  it('handles missing optional information gracefully', () => {
    const contractorWithoutOptionals = {
      ...mockContractor,
      phone: null,
      website: null
    };

    render(<ContractorCard contractor={contractorWithoutOptionals} />);
    
    expect(screen.queryByText('Phone:')).not.toBeInTheDocument();
    expect(screen.queryByText('Visit Website')).not.toBeInTheDocument();
  });

  it('displays correct number of filled stars based on rating', () => {
    const contractorWithLowerRating = {
      ...mockContractor,
      reviews_avg: 3.2
    };

    render(<ContractorCard contractor={contractorWithLowerRating} />);
    
    const filledStars = document.querySelectorAll('.text-yellow-400');
    const emptyStars = document.querySelectorAll('.text-gray-300');
    
    expect(filledStars.length).toBe(3); // 3.2 rounds to 3 stars
    expect(emptyStars.length).toBe(2); // remaining 2 stars should be empty
  });

  it('handles zero reviews correctly', () => {
    const contractorWithNoReviews = {
      ...mockContractor,
      reviews_avg: 0,
      reviews_count: 0
    };

    render(<ContractorCard contractor={contractorWithNoReviews} />);
    
    expect(screen.getByText('(0 reviews)')).toBeInTheDocument();
    const emptyStars = document.querySelectorAll('.text-gray-300');
    expect(emptyStars.length).toBe(5); // all stars should be empty
  });
});
