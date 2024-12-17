import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  try {
    const contractors = await prisma.contractor.findMany({
      select: {
        slug: true,
        updatedAt: true,
        name: true,
      }
    });

    return NextResponse.json({
      success: true,
      count: contractors.length,
      contractors: contractors,
    });
  } catch (error) {
    console.error('Error in debug-sitemap:', error);
    return NextResponse.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
    }, { status: 500 });
  }
}
