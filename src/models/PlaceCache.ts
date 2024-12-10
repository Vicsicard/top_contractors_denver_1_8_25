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
  },
  location: {
    type: String,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  }
});

// Create indexes for efficient querying
PlaceCacheSchema.index({ placeId: 1 });
PlaceCacheSchema.index({ keyword: 1, location: 1 });
PlaceCacheSchema.index({ createdAt: 1 }, { expireAfterSeconds: 180 * 24 * 60 * 60 });

// Create and export the model
export const PlaceCache = mongoose.models.PlaceCache || mongoose.model<IPlaceCache>('PlaceCache', PlaceCacheSchema);
