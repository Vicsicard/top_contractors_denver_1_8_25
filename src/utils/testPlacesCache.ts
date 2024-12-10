import { fileURLToPath } from 'url';
import { dirname } from 'path';
import * as dotenv from 'dotenv';
import { connectDB } from './mongodb.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables
dotenv.config({ path: new URL('../../.env.local', import.meta.url) });

async function testConnection() {
  try {
    // Verify environment variables
    console.log('Checking environment variables...');
    const mongoUri = process.env.MONGODB_URI;
    console.log('MongoDB URI available:', !!mongoUri);

    if (!mongoUri) {
      throw new Error('MONGODB_URI is not defined');
    }

    console.log('Testing MongoDB connection...');
    const mongoose = await connectDB();
    console.log('Connection successful!');

    // Test the connection with a simple operation
    const collections = await mongoose.connection.db.collections();
    console.log(`Connected to database with ${collections.length} collections`);
    
    // Close the connection
    await mongoose.disconnect();
    console.log('Connection closed successfully.');

  } catch (error) {
    console.error('Test failed with error:', error instanceof Error ? error.message : String(error));
    if (error instanceof Error && error.stack) {
      console.error('Error stack:', error.stack);
    }
    process.exit(1);
  }
}

// Run the test
testConnection().catch(error => {
  console.error('Unhandled error:', error instanceof Error ? error.message : String(error));
  process.exit(1);
});
