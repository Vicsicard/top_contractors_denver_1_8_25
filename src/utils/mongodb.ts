import mongoose from 'mongoose';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Get the directory path for the current module
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables from root .env.local
dotenv.config({ path: join(__dirname, '../../../.env.local') });

// Get MongoDB URI from environment variables
const mongoUri = process.env.MONGODB_URI;
console.log('MongoDB URI available:', !!mongoUri);

if (!mongoUri) {
  throw new Error('MONGODB_URI is not defined in environment variables');
}

// Now TypeScript knows mongoUri is a string

// Define the interface for our cached connection
interface CachedConnection {
  conn: typeof mongoose | null;
  promise: Promise<typeof mongoose> | null;
}

// Create cache object
let cached: CachedConnection = {
  conn: null,
  promise: null,
};

// Create global type
declare global {
  let mongooseCache: CachedConnection | undefined;
}

// Check if we have a cached connection in global scope
if (!global.mongooseCache) {
  global.mongooseCache = cached;
} else {
  cached = global.mongooseCache;
}

export async function connectDB(): Promise<typeof mongoose> {
  try {
    if (cached.conn) {
      console.log('Using existing MongoDB connection');
      return cached.conn;
    }

    if (!cached.promise) {
      console.log('Creating new MongoDB connection...');
      const opts = {
        bufferCommands: false,
      };

      // Ensure mongoUri is defined before using it
      if (!mongoUri) {
        throw new Error('MONGODB_URI is not defined in environment variables');
      }

      // Now TypeScript knows mongoUri is a string
      cached.promise = mongoose.connect(mongoUri, opts);
    }

    cached.conn = await cached.promise;
    console.log('MongoDB connection established');
    return cached.conn;
  } catch (error) {
    console.error('Error connecting to MongoDB:', error);
    cached.promise = null;
    throw error;
  }
}
