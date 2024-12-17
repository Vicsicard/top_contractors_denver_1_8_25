import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  const diagnostics = {
    environment: process.env.NODE_ENV,
    databaseUrlExists: !!process.env.MONGODB_URI,
    databaseNameExists: !!process.env.MONGODB_DB,
    prismaInitialized: !!prisma,
    connectionTest: null as any,
    contractorCount: null as any,
    error: null as any
  };

  try {
    console.log('Testing database connection...');
    
    // Test connection
    await prisma.$connect();
    diagnostics.connectionTest = 'success';
    console.log('Database connection successful');

    // Test query
    const count = await prisma.contractor.count();
    diagnostics.contractorCount = count;
    console.log('Contractor count:', count);

    // Get a sample contractor
    const sampleContractor = await prisma.contractor.findFirst({
      select: {
        id: true,
        name: true,
        slug: true,
        updatedAt: true
      }
    });

    return NextResponse.json({
      success: true,
      diagnostics,
      sampleContractor
    });
  } catch (error) {
    console.error('Database connection error:', error);
    diagnostics.error = {
      message: error instanceof Error ? error.message : String(error),
      name: error instanceof Error ? error.name : 'Unknown',
      stack: error instanceof Error ? error.stack : undefined
    };
    return NextResponse.json({ 
      success: false, 
      diagnostics
    }, { 
      status: 500 
    });
  } finally {
    try {
      await prisma.$disconnect();
      console.log('Database disconnected successfully');
    } catch (disconnectError) {
      console.error('Error disconnecting from database:', disconnectError);
    }
  }
}
