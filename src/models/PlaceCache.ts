import mongoose from 'mongoose';
import { connectDB } from '@/utils/db';

// Define interfaces for Google Places result types
interface PlaceLocation {
  lat: number;
  lng: number;
}

interface PlaceGeometry {
  location: PlaceLocation;
  viewport?: {
    northeast: PlaceLocation;
    southwest: PlaceLocation;
  };
}

interface PlaceResult {
  place_id: string;
  name: string;
  formatted_address: string;
  geometry: PlaceGeometry;
  rating?: number;
  user_ratings_total?: number;
  business_status?: string;
  types?: string[];
  photos?: Array<{
    photo_reference: string;
    height: number;
    width: number;
  }>;
}

// Define the interface for cached places
interface IPlaceCache {
  query: string;
  results: PlaceResult[];
  lastUpdated: Date;
  expiresAt: Date;
}

// Define the schema
const placeCacheSchema = new mongoose.Schema<IPlaceCache>({
  query: { 
    type: String, 
    required: true, 
    unique: true,
    index: true 
  },
  results: [{ 
    type: mongoose.Schema.Types.Mixed,
    required: true 
  }],
  lastUpdated: { 
    type: Date, 
    default: Date.now 
  },
  expiresAt: { 
    type: Date, 
    required: true,
    index: true 
  }
});

// Ensure connection before operations
placeCacheSchema.pre('save', async function() {
  await connectDB();
});

placeCacheSchema.pre('findOne', async function() {
  await connectDB();
});

placeCacheSchema.pre('find', async function() {
  await connectDB();
});

// Define static methods interface
interface PlaceCacheModel extends mongoose.Model<IPlaceCache> {
  findByQuery(query: string): Promise<IPlaceCache | null>;
  createOrUpdateCache(query: string, results: PlaceResult[], expirationHours?: number): Promise<IPlaceCache>;
}

// Static method to find by query
placeCacheSchema.statics.findByQuery = async function(this: PlaceCacheModel, query: string) {
  await connectDB();
  return this.findOne({ 
    query,
    expiresAt: { $gt: new Date() }
  });
};

// Static method to create or update cache
placeCacheSchema.statics.createOrUpdateCache = async function(
  this: PlaceCacheModel,
  query: string,
  results: PlaceResult[],
  expirationHours = 24
) {
  await connectDB();
  const expiresAt = new Date();
  expiresAt.setHours(expiresAt.getHours() + expirationHours);

  try {
    // Try to update existing cache first
    const updated = await this.findOneAndUpdate(
      { query },
      {
        results,
        lastUpdated: new Date(),
        expiresAt
      },
      {
        new: true,
        upsert: true,
        runValidators: true,
        setDefaultsOnInsert: true
      }
    );

    return updated;
  } catch (error) {
    if (error instanceof Error && 'code' in error && error.code === 11000) {
      // If duplicate key error, wait a bit and try to update again
      await new Promise(resolve => setTimeout(resolve, 100));
      return this.findOneAndUpdate(
        { query },
        {
          results,
          lastUpdated: new Date(),
          expiresAt
        },
        { new: true }
      );
    }
    throw error;
  }
};

// Create and export the model
export const PlaceCache = (mongoose.models.PlaceCache as PlaceCacheModel) || 
  mongoose.model<IPlaceCache, PlaceCacheModel>('PlaceCache', placeCacheSchema);
