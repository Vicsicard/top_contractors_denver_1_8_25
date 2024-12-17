require('dotenv').config({ path: '.env.local' })
const { PrismaClient } = require('@prisma/client')

const sampleBusinesses = [
  {
    name: "Denver Elite Contractors",
    rating: 4.8,
    reviewCount: 156,
    address: "1234 Market St, Denver, CO 80202",
    location: {
      lat: 39.7489,
      lng: -104.9995
    },
    categories: ["Home Remodeling", "Kitchen Remodeling", "Bathroom Remodeling"],
    phone: "(303) 555-0123",
    website: "https://denverelitecontractors.com",
    businessStatus: "OPERATIONAL"
  },
  {
    name: "Mile High Construction",
    rating: 4.9,
    reviewCount: 203,
    address: "789 Broadway, Denver, CO 80203",
    location: {
      lat: 39.7312,
      lng: -104.9876
    },
    categories: ["General Contractor", "Home Additions", "Custom Homes"],
    phone: "(303) 555-0124",
    website: "https://milehighconstruction.com",
    businessStatus: "OPERATIONAL"
  },
  {
    name: "Rocky Mountain Renovators",
    rating: 4.7,
    reviewCount: 178,
    address: "456 Blake St, Denver, CO 80205",
    location: {
      lat: 39.7577,
      lng: -104.9889
    },
    categories: ["Kitchen Remodeling", "Bathroom Remodeling", "Basement Finishing"],
    phone: "(303) 555-0125",
    website: "https://rockymountainrenovators.com",
    businessStatus: "OPERATIONAL"
  },
  {
    name: "Denver Design & Build",
    rating: 4.6,
    reviewCount: 142,
    address: "321 Larimer St, Denver, CO 80204",
    location: {
      lat: 39.7534,
      lng: -104.9932
    },
    categories: ["Home Remodeling", "Interior Design", "Custom Cabinets"],
    phone: "(303) 555-0126",
    website: "https://denverdesignbuild.com",
    businessStatus: "OPERATIONAL"
  },
  {
    name: "Colorado Custom Contractors",
    rating: 4.9,
    reviewCount: 189,
    address: "567 Wynkoop St, Denver, CO 80202",
    location: {
      lat: 39.7515,
      lng: -104.9978
    },
    categories: ["Custom Homes", "Luxury Remodeling", "Outdoor Living"],
    phone: "(303) 555-0127",
    website: "https://coloradocustomcontractors.com",
    businessStatus: "OPERATIONAL"
  }
];

async function main() {
  const prisma = new PrismaClient()
  
  try {
    console.log('Starting to seed database...')
    
    // Clear existing data
    await prisma.business.deleteMany()
    console.log('Cleared existing data')
    
    // Insert new businesses
    const createdBusinesses = await Promise.all(
      sampleBusinesses.map(business =>
        prisma.business.create({
          data: business
        })
      )
    )
    
    console.log(`Successfully seeded ${createdBusinesses.length} businesses:`)
    createdBusinesses.forEach(business => {
      console.log(`- ${business.name}`)
    })

  } catch (error) {
    console.error('Error seeding database:', error)
  } finally {
    await prisma.$disconnect()
  }
}

main()
