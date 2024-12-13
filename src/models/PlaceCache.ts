import mongoose, { Model } from 'mongoose';

// Define the cache schema
export interface PlacesSearchResult {
  name: string;
  formatted_address: string;
  place_id: string;
  rating?: number;
  user_ratings_total?: number;
  categories?: string[];
  phone?: string;
  website?: string;
}

export interface IPlaceCache {
  placeId: string;
  data: PlacesSearchResult;
  keyword: string;
  location: string;
  createdAt: Date;
}

const PlaceCacheSchema = new mongoose.Schema<IPlaceCache>({
  placeId: {
    type: String,
    required: true,
    unique: true,
    index: true
  },
  data: {
    type: {
      name: { type: String, required: true },
      formatted_address: { type: String, required: true },
      place_id: { type: String, required: true },
      rating: { type: Number, required: false },
      user_ratings_total: { type: Number, required: false },
      categories: [{ type: String }],
      phone: { type: String, required: false },
      website: { type: String, required: false }
    },
    required: true,
  },
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
  createdAt: {
    type: Date,
    default: Date.now,
    expires: 7 * 24 * 60 * 60 // 7 days TTL index
  }
}, {
  timestamps: true,
  collection: 'placeCache',
  strict: true,
  strictQuery: true
});

// Create compound index for keyword and location
PlaceCacheSchema.index({ keyword: 1, location: 1 });

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
  if (!this.data || !this.data.name || !this.data.formatted_address) {
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
    createdAt: { $gt: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) } // Only return results less than 7 days old
  }).exec();

  console.log('📊 Cache stats:', {
    found: results.length > 0,
    resultCount: results.length,
    timestamp: new Date().toISOString()
  });

  return results;
};

// Create and export the model
let PlaceCache: Model<IPlaceCache>;

try {
  // Try to get the existing model
  PlaceCache = mongoose.model<IPlaceCache>('PlaceCache');
} catch {
  // Model doesn't exist, create it
  PlaceCache = mongoose.model<IPlaceCache>('PlaceCache', PlaceCacheSchema);
}

export { PlaceCache };
