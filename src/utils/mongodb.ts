import mongoose, { Connection } from 'mongoose';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

// Get the directory path for the current module
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables from root .env.local
dotenv.config({ path: join(__dirname, '../../../.env.local') });

const MONGODB_URI = process.env.MONGODB_URI;

if (!MONGODB_URI) {
  throw new Error('Please define the MONGODB_URI environment variable inside .env.local');
}

interface MongooseCache {
  conn: Connection | null;
  promise: Promise<Connection> | null;
}

// Initialize the global cache if it doesn't exist
if (!global.mongooseCache) {
  global.mongooseCache = {
    conn: null,
    promise: null,
  };
}

/**
 * Global is used here to maintain a cached connection across hot reloads
 * in development. This prevents connections growing exponentially
 * during API Route usage.
 */
const cached: MongooseCache = global.mongooseCache;

export async function connectToDatabase(): Promise<Connection> {
  if (cached.conn) {
    return cached.conn;
  }

  if (!cached.promise) {
    const opts = {
      bufferCommands: false,
      serverSelectionTimeoutMS: 30000,
      socketTimeoutMS: 45000,
      family: 4,
      maxPoolSize: 50,
      minPoolSize: 10,
      autoIndex: true,
      useCache: true,
      authSource: 'admin'
    };

    cached.promise = mongoose.connect(MONGODB_URI!, opts)
      .then((mongoose) => {
        mongoose.connection.on('connected', () => console.log('MongoDB connected successfully'));
        mongoose.connection.on('error', (err) => console.error('MongoDB connection error:', err));
        mongoose.connection.on('disconnected', () => console.log('MongoDB disconnected'));
        mongoose.connection.on('reconnected', () => console.log('MongoDB reconnected'));
        mongoose.connection.on('disconnecting', () => console.log('MongoDB disconnecting'));
        
        return mongoose.connection;
      })
      .catch((error) => {
        console.error('Error connecting to MongoDB:', error);
        if (error.name === 'MongooseServerSelectionError') {
          console.error('Server selection error. Current server state:', error.reason?.servers);
        }
        throw error;
      });
  }

  try {
    cached.conn = await cached.promise;
  } catch (e) {
    cached.promise = null;
    throw e;
  }

  return cached.conn;
}

// Export the old name for backward compatibility
export const connectDB = connectToDatabase;
