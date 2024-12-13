import { NextResponse } from 'next/server';
import { searchPlaces } from '@/utils/googlePlaces';

export async function GET(request: Request) {
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
      status: 'success',
      results
    });

  } catch (error) {
    console.error('API: Search error:', error);
    return NextResponse.json({
      status: 'error',
      message: error instanceof Error ? error.message : 'An error occurred during search'
    }, { status: 500 });
  }
}
