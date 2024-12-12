import mongoose from 'mongoose';

// Define the cache schema
interface PlaceData {
  name: string;
  formatted_address: string;
  place_id: string;
  rating?: number;
  user_ratings_total?: number;
  last_updated: Date;
}

export interface IPlaceCache extends mongoose.Document {
  placeId: string;
  data: PlaceData;
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
      last_updated: { type: Date, required: true }
    },
    required: true,
  },
  keyword: {
    type: String,
    required: true,
    index: true
  },
  location: {
    type: String,
    required: true,
    index: true
  },
  createdAt: {
    type: Date,
    default: Date.now,
    expires: 180 * 24 * 60 * 60 // 180 days TTL index
  }
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

// Create and export the model
export const PlaceCache = mongoose.models.PlaceCache || mongoose.model<IPlaceCache>('PlaceCache', PlaceCacheSchema);
