import mongoose from 'mongoose';

declare global {
  var mongooseCache: {
    conn: typeof mongoose | null;
    promise: Promise<typeof mongoose> | null;
  };
}

if (!global.mongooseCache) {
  global.mongooseCache = {
    conn: null,
    promise: null
  };
}

export async function connectDB() {
  if (global.mongooseCache.conn) {
    console.log('Using cached MongoDB connection');
    return global.mongooseCache.conn;
  }

  if (!process.env.MONGODB_URI) {
    throw new Error('Please define the MONGODB_URI environment variable');
  }

  if (!global.mongooseCache.promise) {
    const opts = {
      bufferCommands: false,
      maxPoolSize: 10,
      minPoolSize: 5,
      socketTimeoutMS: 30000,
      family: 4,
      serverSelectionTimeoutMS: 5000,
    };

    global.mongooseCache.promise = mongoose
      .connect(process.env.MONGODB_URI, opts)
      .then((mongoose) => {
        console.log('MongoDB connected successfully');
        // Set up connection event handlers
        const db = mongoose.connection;
        
        db.on('connected', () => {
          console.log('MongoDB connected');
        });

        db.on('error', (error) => {
          console.error('MongoDB error:', error);
        });

        db.on('disconnected', () => {
          console.log('MongoDB disconnected');
        });

        db.on('reconnected', () => {
          console.log('MongoDB reconnected');
        });

        return mongoose;
      })
      .catch((error) => {
        console.error('MongoDB connection error:', error);
        throw error;
      });
  }

  try {
    global.mongooseCache.conn = await global.mongooseCache.promise;
    return global.mongooseCache.conn;
  } catch (e) {
    global.mongooseCache.promise = null;
    throw e;
  }
}

export default connectDB;
