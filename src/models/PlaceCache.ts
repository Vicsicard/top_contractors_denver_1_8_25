import mongoose from 'mongoose';

// Define the cache schema
export interface IPlaceCache extends mongoose.Document {
  placeId: string;
  data: any;
  keyword: string;
  location: string;
  createdAt: Date;
}

const PlaceCacheSchema = new mongoose.Schema({
  placeId: {
    type: String,
    required: true,
    unique: true,
  },
  data: {
    type: mongoose.Schema.Types.Mixed,
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
export const PlaceCache = (mongoose.models.PlaceCache as mongoose.Model<IPlaceCache>) || 
  mongoose.model<IPlaceCache>('PlaceCache', PlaceCacheSchema);

export default { PlaceCache: './PlaceCache.js' };
