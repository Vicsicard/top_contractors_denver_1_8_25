import { NextResponse } from 'next/server';
import { connectDB } from '@/utils/mongodb';
import { PlaceCache } from '@/models/PlaceCache';

export async function GET(): Promise<NextResponse> {
  try {
    await connectDB();
    const result = await PlaceCache.deleteMany({});
    return NextResponse.json({ message: 'Database cleaned', deletedCount: result.deletedCount });
  } catch (error) {
    console.error('Cleanup error:', error);
    return NextResponse.json({ error: 'Failed to clean database' }, { status: 500 });
  }
}
