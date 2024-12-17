import { PrismaClient } from '@prisma/client';

const globalForPrisma = global as unknown as { prisma: PrismaClient };

function createPrismaClient() {
  try {
    console.log('Initializing Prisma Client...');
    console.log('Environment:', process.env.NODE_ENV);
    console.log('Database URL exists:', !!process.env.MONGODB_URI);

    const client = new PrismaClient({
      log: [
        { level: 'query', emit: 'event' },
        { level: 'error', emit: 'stdout' },
        { level: 'info', emit: 'stdout' },
        { level: 'warn', emit: 'stdout' },
      ],
    });

    // Add logging for queries
    client.$on('query', (e) => {
      console.log('Query:', e);
    });

    console.log('Prisma Client initialized successfully');
    return client;
  } catch (error) {
    console.error('Error initializing Prisma Client:', error);
    throw error;
  }
}

export const prisma = globalForPrisma.prisma || createPrismaClient();

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;

export default prisma;
