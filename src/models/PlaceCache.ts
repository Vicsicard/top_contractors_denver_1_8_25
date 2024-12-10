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
    type: PlaceData,
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
    expires: 180 * 24 * 60 * 60, // 180 days in seconds
  },
});

// Create indexes for efficient querying
PlaceCacheSchema.index({ placeId: 1 });
PlaceCacheSchema.index({ keyword: 1, location: 1 });
PlaceCacheSchema.index({ createdAt: 1 }, { expireAfterSeconds: 180 * 24 * 60 * 60 });

// Prevent TS error about model already being defined
const PlaceCache = mongoose.models.PlaceCache || mongoose.model<IPlaceCache>('PlaceCache', PlaceCacheSchema);

export default PlaceCache;
