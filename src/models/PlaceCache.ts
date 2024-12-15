import mongoose from 'mongoose';
import { PlacesApiResponse } from '../utils/placesApi';

// Define the cache schema
export interface IPlaceCache {
  keyword: string;
  location: string;
  data: PlacesApiResponse;
  createdAt: Date;
}

const PlaceCacheSchema = new mongoose.Schema<IPlaceCache>({
  keyword: {
    type: String,
    required: true,
    index: true,
    lowercase: true,
    trim: true
  },
  location: {
    type: String,
    required: true,
    index: true,
    lowercase: true,
    trim: true
  },
  data: {
    type: {
      results: [{
        place_id: String,
        name: String,
        formatted_address: String,
        geometry: {
          location: {
            lat: Number,
            lng: Number
          }
        },
        rating: Number,
        user_ratings_total: Number,
        formatted_phone_number: String,
        website: String
      }],
      status: String,
      error_message: String
    },
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now,
    expires: 180 * 24 * 60 * 60 // 180 days in seconds
  }
}, {
  timestamps: true,
  collection: 'placeCache',
  strict: true,
  strictQuery: true
});

// Create compound index for keyword and location
PlaceCacheSchema.index({ keyword: 1, location: 1 }, { unique: true });

// Add error handling middleware
PlaceCacheSchema.post('save', function(
  error: Error & { code?: number },
  doc: IPlaceCache,
  next: (err?: Error) => void
) {
  if (error.name === 'MongoServerError' && error.code === 11000) {
    next(new Error('Place already exists in cache'));
  } else {
    next(error);
  }
});

// Add pre-save middleware for data validation
PlaceCacheSchema.pre('save', function(next) {
  if (!this.data || !this.data.results || this.data.results.length === 0) {
    next(new Error('Invalid place data'));
    return;
  }
  next();
});

// Add static methods
PlaceCacheSchema.statics.findByKeywordAndLocation = async function(
  keyword: string,
  location: string
): Promise<IPlaceCache[]> {
  const normalizedKeyword = keyword.toLowerCase().trim();
  const normalizedLocation = location.toLowerCase().trim();
  
  console.log('🔍 Searching cache:', {
    keyword: normalizedKeyword,
    location: normalizedLocation,
    timestamp: new Date().toISOString()
  });

  const results = await this.find({
    keyword: normalizedKeyword,
    location: normalizedLocation,
    createdAt: { $gt: new Date(Date.now() - 180 * 24 * 60 * 60 * 1000) } // Only return results less than 180 days old
  }).exec();

  console.log('📊 Cache stats:', {
    found: results.length > 0,
    resultCount: results.length,
    timestamp: new Date().toISOString()
  });

  return results;
};

// Create and export the model
export const PlaceCache = mongoose.models.PlaceCache || mongoose.model<IPlaceCache>('PlaceCache', PlaceCacheSchema);
