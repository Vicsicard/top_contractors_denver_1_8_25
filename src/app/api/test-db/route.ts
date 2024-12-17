import { NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  try {
    const count = await prisma.contractor.count();
    return NextResponse.json({ success: true, count });
  } catch (error) {
    console.error('Database connection error:', error);
    return NextResponse.json({ success: false, error: String(error) }, { status: 500 });
  } finally {
    await prisma.$disconnect();
  }
}
