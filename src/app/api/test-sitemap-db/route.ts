import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  try {
    // Test database connection
    const dbTest = await prisma.$queryRaw`SELECT 1 as connected`;
    console.log('Database connection test:', dbTest);

    // Try to fetch contractors
    const contractors = await prisma.contractor.findMany({
      select: {
        id: true,
        slug: true,
        name: true,
        updatedAt: true,
      }
    });

    return NextResponse.json({
      success: true,
      dbConnectionTest: dbTest,
      contractorsFound: contractors.length,
      contractors: contractors,
    });
  } catch (error) {
    console.error('Error in test-sitemap-db:', error);
    return NextResponse.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
      errorDetails: error,
    }, { status: 500 });
  }
}
