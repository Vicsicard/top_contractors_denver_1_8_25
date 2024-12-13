import { NextResponse } from 'next/server';
import { connectDB } from '@/utils/mongodb';
import mongoose from 'mongoose';

export async function GET() {
  try {
    // Connect to MongoDB
    const conn = await connectDB();
    
    // Drop the placeCache collection if it exists
    try {
      await mongoose.connection.db.dropCollection('placeCache');
    } catch (error) {
      // Ignore error if collection doesn't exist
      console.log('Collection may not exist:', error);
    }
    
    // Delete the model from mongoose's model cache
    try {
      delete mongoose.models.PlaceCache;
      delete mongoose.modelSchemas.PlaceCache;
    } catch (error) {
      console.log('Model deletion error:', error);
    }
    
    return NextResponse.json({
      status: 'success',
      message: 'Database and model cache cleanup successful'
    });

  } catch (error) {
    console.error('Database cleanup failed:', error);
    return NextResponse.json({
      status: 'error',
      message: error instanceof Error ? error.message : 'Unknown error occurred',
      error: error
    }, { status: 500 });
  }
}
