import { NextResponse } from 'next/server';
import { loadLocations } from '@/utils/searchData';
import { PaginatedResponse } from '@/types/pagination';
import { Business } from '@/types/business';
import { searchPlaces } from '@/utils/googlePlaces';

const DEFAULT_PAGE_SIZE = 10;

export async function GET(request: Request): Promise<NextResponse> {
  try {
    const { searchParams } = new URL(request.url);
    const keyword = searchParams.get('keyword');
    const location = searchParams.get('location');

    if (!keyword || !location) {
      return NextResponse.json(
        { error: 'Missing required parameters: keyword and location' },
        { status: 400 }
      );
    }

    console.log('API: Searching for:', { keyword, location });
    const results = await searchPlaces(keyword, location);
    console.log('API: Found results:', { count: results.length });

    return NextResponse.json({
      results,
      metadata: {
        count: results.length,
        query: { keyword, location }
      }
    });
  } catch (error) {
    console.error('API Error:', error);
    return NextResponse.json(
      { error: 'Failed to fetch results' },
      { status: 500 }
    );
  }
}
