import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  const debug = {
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV,
    database: {
      urlExists: !!process.env.MONGODB_URI,
      dbName: process.env.MONGODB_DB,
    },
    contractors: [],
    sampleUrls: [],
    error: null
  };

  try {
    console.log('Fetching contractors for debug...');
    const contractors = await prisma.contractor.findMany({
      select: {
        id: true,
        name: true,
        slug: true,
        updatedAt: true,
      }
    });

    debug.contractors = contractors;
    debug.sampleUrls = [
      'https://www.topcontractorsdenver.com/',
      'https://www.topcontractorsdenver.com/search/',
      ...contractors.map(c => `https://www.topcontractorsdenver.com/contractor/${c.slug}/`)
    ];

  } catch (error) {
    console.error('Debug endpoint error:', error);
    debug.error = error instanceof Error ? error.message : String(error);
  }

  return NextResponse.json(debug);
}
