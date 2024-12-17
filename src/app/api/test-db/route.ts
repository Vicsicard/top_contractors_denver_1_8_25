import { NextRequest, NextResponse } from 'next/server';
import { PrismaClient } from '@prisma/client';

interface Diagnostics {
  environment: string;
  databaseUrlExists: boolean;
  databaseNameExists: boolean;
  prismaInitialized: boolean;
  connectionTest: string | null;
  contractorCount: number | null;
  error: {
    message: string;
    name: string;
    stack: string | undefined;
  } | null;
}

interface SampleContractor {
  id: string;
  name: string;
  slug: string;
  updatedAt: Date;
}

interface Response {
  success: boolean;
  diagnostics: Diagnostics;
  sampleContractor?: SampleContractor;
}

export async function GET(_request: NextRequest): Promise<NextResponse> {
  const prisma = new PrismaClient();
  
  const diagnostics: Diagnostics = {
    environment: process.env.NODE_ENV,
    databaseUrlExists: !!process.env.MONGODB_URI,
    databaseNameExists: !!process.env.MONGODB_DB,
    prismaInitialized: !!prisma,
    connectionTest: null,
    contractorCount: null,
    error: null
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
    const sampleContractor: SampleContractor = await prisma.contractor.findFirst({
      select: {
        id: true,
        name: true,
        slug: true,
        updatedAt: true
      }
    });

    const response: Response = {
      success: true,
      diagnostics,
      sampleContractor
    };

    return NextResponse.json(response);
  } catch (error) {
    console.error('Database connection error:', error);
    diagnostics.error = {
      message: error instanceof Error ? error.message : String(error),
      name: error instanceof Error ? error.name : 'Unknown',
      stack: error instanceof Error ? error.stack : undefined
    };
    const response: Response = {
      success: false,
      diagnostics
    };
    return NextResponse.json(response, { status: 500 });
  } finally {
    try {
      await prisma.$disconnect();
      console.log('Database disconnected successfully');
    } catch (disconnectError) {
      console.error('Error disconnecting from database:', disconnectError);
    }
  }
}
