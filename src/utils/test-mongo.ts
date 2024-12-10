import { MongoClient } from 'mongodb';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname } from 'path';
import { join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables from .env.local
dotenv.config({ path: join(__dirname, '../../.env.local') });

async function testConnection(): Promise<void> {
  const uri = process.env.MONGODB_URI;

  if (!uri) {
    throw new Error('Please define the MONGODB_URI environment variable');
  }

  console.log('MongoDB URI available:', !!uri);
  
  try {
    console.log('Attempting to connect to MongoDB...');
    const client = new MongoClient(uri);
    await client.connect();
    console.log('Connected to MongoDB successfully');
    
    // Test the connection by listing databases
    const adminDb = client.db().admin();
    const dbs = await adminDb.listDatabases();
    console.log('Available databases:', dbs.databases.map(db => db.name));
    
    await client.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Failed to connect to MongoDB:', error);
    process.exit(1);
  }
}

testConnection().catch(error => {
  console.error('Unhandled error:', error);
  process.exit(1);
});
