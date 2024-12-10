var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import mongoose from 'mongoose';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
// Get the directory path for the current module
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
// Load environment variables from .env.local
const envPath = join(__dirname, '../../.env.local');
console.log('Loading environment variables from:', envPath);
dotenv.config({ path: envPath });
const mongoUri = process.env.MONGODB_URI;
console.log('MongoDB URI available:', !!mongoUri);
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
export function connectDB() {
    return __awaiter(this, void 0, void 0, function* () {
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
                cached.promise = mongoose.connect(mongoUri);
            }
            cached.conn = yield cached.promise;
            console.log('MongoDB connection established');
            return cached.conn;
        }
        catch (error) {
            console.error('Error connecting to MongoDB:', error);
            cached.promise = null;
            throw error;
        }
    });
}
