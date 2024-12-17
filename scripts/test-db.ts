require('dotenv').config({ path: '.env.local' })
const { PrismaClient } = require('@prisma/client')

async function main() {
  const prisma = new PrismaClient()
  
  try {
    // Test connection by attempting to count businesses
    const count = await prisma.business.count()
    console.log('Successfully connected to database!')
    console.log(`Number of businesses in database: ${count}`)

    // Test query capability
    const firstBusiness = await prisma.business.findFirst()
    if (firstBusiness) {
      console.log('\nSample business from database:')
      console.log(JSON.stringify(firstBusiness, null, 2))
    } else {
      console.log('\nNo businesses found in database')
    }

  } catch (error) {
    console.error('Database connection error:', error)
  } finally {
    await prisma.$disconnect()
  }
}

main()
