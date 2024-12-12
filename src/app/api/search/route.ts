import { NextResponse } from 'next/server';
import { loadLocations } from '@/utils/searchData';
import { PaginatedResponse } from '@/types/pagination';
import { Business } from '@/types/business';

const DEFAULT_PAGE_SIZE = 10;

export async function GET(request: Request): Promise<NextResponse> {
  const { searchParams } = new URL(request.url);
  const query = searchParams.get('q') || '';
  const page = parseInt(searchParams.get('page') || '1', 10);
  const limit = parseInt(searchParams.get('limit') || DEFAULT_PAGE_SIZE.toString(), 10);

  const skip = (page - 1) * limit;
  
  try {
    const { locations, total } = await loadLocations(query, { skip, limit });
    
    const totalPages = Math.ceil(total / limit);
    
    const response: PaginatedResponse<Business> = {
      data: locations,
      pagination: {
        currentPage: page,
        totalPages,
        totalItems: total,
        itemsPerPage: limit,
        hasNextPage: page < totalPages,
        hasPreviousPage: page > 1
      }
    };
    
    return NextResponse.json(response);
  } catch (error) {
    console.error('Search error:', error);
    return NextResponse.json(
      { error: 'Failed to fetch search results' },
      { status: 500 }
    );
  }
}
