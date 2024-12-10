import { Connection } from 'mongoose';

interface MongooseCache {
  conn: Connection | null;
  promise: Promise<Connection> | null;
}

declare global {
  var mongooseCache: MongooseCache;
}

// Ensure this file is treated as a module
export {};
