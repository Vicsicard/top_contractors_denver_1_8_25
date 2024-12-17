import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  try {
    // Try to fetch contractors
    const contractors = await prisma.contractor.findMany({
      select: {
        id: true,
        slug: true,
        name: true,
        updatedAt: true,
      }
    });

    // Try to fetch a count
    const count = await prisma.contractor.count();

    return NextResponse.json({
      success: true,
      contractorsFound: contractors.length,
      count,
      contractors: contractors,
      prismaVersion: prisma._engineConfig?.version || 'unknown',
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
