import { NextResponse } from 'next/server';
import { loadLocations } from '@/utils/searchData';

export async function GET(request: Request): Promise<NextResponse> {
  const { searchParams } = new URL(request.url);
  const query = searchParams.get('q') || '';

  const locations = await loadLocations(query);
  
  return NextResponse.json({ locations });
}
