import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import * as dotenv from 'dotenv';
import { getPlacesData } from './placesApi.js';
import { connectDB } from './mongodb.js';
import mongoose from 'mongoose';
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
// Load environment variables from root .env.local
dotenv.config({ path: join(__dirname, '../../../.env.local') });
async function testPlacesCache() {
    try {
        console.log('Testing Places Cache...');
        // Test data
        const testData = {
            keyword: 'plumbers',
            location: 'Denver, CO'
        };
        // Connect to MongoDB
        console.log('Connecting to MongoDB...');
        await connectDB();
        console.log('Connection successful!');
        // Test the connection with a simple operation
        if (!mongoose.connection.db) {
            throw new Error('Database connection not established');
        }
        const collections = await mongoose.connection.db.collections();
        console.log(`Connected to database with ${collections.length} collections`);
        // Test the getPlacesData function
        console.log('Testing getPlacesData function...');
        const results = await getPlacesData(testData);
        console.log('Results:', {
            status: results.status,
            resultCount: results.results.length,
            firstResult: results.results[0] ? {
                name: results.results[0].name,
                address: results.results[0].formatted_address
            } : null
        });
        // Close the MongoDB connection
        await mongoose.connection.close();
        console.log('Test completed successfully!');
    }
    catch (error) {
        console.error('Error during test:', error);
        // Ensure connection is closed even if there's an error
        if (mongoose.connection.readyState !== 0) {
            await mongoose.connection.close();
        }
        process.exit(1);
    }
}
// Run the test
testPlacesCache();
