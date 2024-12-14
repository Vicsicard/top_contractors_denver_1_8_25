import { NextResponse } from 'next/server';
import { connectDB } from '@/utils/mongodb';
import { PlaceCache } from '@/models/PlaceCache';

export async function GET(): Promise<NextResponse> {
  try {
    console.log('Starting database test...');
    
    // Test database connection
    await connectDB();
    console.log('Database connected');
    
    // Test model by creating a sample cache entry
    const testData = {
      placeId: 'test-place-id-' + Date.now(),
      data: {
        name: 'Test Place',
        formatted_address: '123 Test St, Denver, CO',
        place_id: 'test-place-id-' + Date.now(),
        rating: 4.5,
        user_ratings_total: 100,
        categories: ['test', 'place'],
        phone: '123-456-7890',
        website: 'https://test.com'
      },
      keyword: 'test',
      location: 'denver'
    };

    console.log('Creating test entry:', testData);

    // Create test entry
    const newPlace = await PlaceCache.create(testData);
    console.log('Test entry created:', newPlace);

    // Retrieve the test entry
    const foundPlace = await PlaceCache.findOne({ placeId: testData.placeId });
    console.log('Test entry retrieved:', foundPlace);

    // Test the findByKeywordAndLocation static method
    const searchResults = await PlaceCache.findByKeywordAndLocation('test', 'denver');
    console.log('Search results:', searchResults);

    return NextResponse.json({
      status: 'success',
      message: 'Database connection and model tests successful',
      testEntry: newPlace,
      foundEntry: foundPlace,
      searchResults
    });

  } catch (error) {
    console.error('Database test failed:', error);
    return NextResponse.json({
      status: 'error',
      message: error instanceof Error ? error.message : 'Unknown error occurred',
      stack: error instanceof Error ? error.stack : undefined,
      error: error
    }, { status: 500 });
  }
}
