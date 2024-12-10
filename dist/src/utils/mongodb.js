import mongoose from 'mongoose';
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import * as dotenv from 'dotenv';
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
// Load environment variables
dotenv.config({ path: new URL('../../.env.local', import.meta.url) });
const mongoUri = process.env.MONGODB_URI;
if (!mongoUri) {
    throw new Error('Please define the MONGODB_URI environment variable');
}
// Create cache object
let cached = {
    conn: null,
    promise: null,
};
// Check if we have a cached connection in global scope
if (!global.mongooseCache) {
    global.mongooseCache = cached;
}
else {
    cached = global.mongooseCache;
}
export async function connectDB() {
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
            cached.promise = mongoose.connect(mongoUri, opts);
        }
        cached.conn = await cached.promise;
        console.log('MongoDB connection established');
        return cached.conn;
    }
    catch (error) {
        console.error('Error connecting to MongoDB:', error);
        cached.promise = null;
        throw error;
    }
}
