import { NextResponse } from 'next/server';
import { loadSearchData } from '@/utils/searchData';

export async function GET(): Promise<NextResponse> {
  try {
    const searchData = loadSearchData();
    return NextResponse.json(searchData);
  } catch (error) {
    console.error('Error loading search data:', error);
    return NextResponse.json({ error: 'Failed to load search data' }, { status: 500 });
  }
}
