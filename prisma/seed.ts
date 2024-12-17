import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const contractors = [
  {
    name: "Denver Home Remodeling Pros",
    slug: "denver-home-remodeling-pros",
    rating: 4.8,
    reviewCount: 125,
    address: "1234 Broadway, Denver, CO 80203",
    location: {
      lat: 39.7392,
      lng: -104.9903
    },
    categories: ["Home-Remodeling", "Kitchen-Remodeling", "Bathroom-Remodeling"],
    phone: "(303) 555-0123",
    website: "https://example.com/denver-remodeling",
    businessStatus: "OPERATIONAL"
  },
  {
    name: "Aurora Custom Homes",
    slug: "aurora-custom-homes",
    rating: 4.9,
    reviewCount: 89,
    address: "789 Havana St, Aurora, CO 80010",
    location: {
      lat: 39.7405,
      lng: -104.8672
    },
    categories: ["Custom-Homes", "Home-Remodeling"],
    phone: "(303) 555-0124",
    website: "https://example.com/aurora-homes",
    businessStatus: "OPERATIONAL"
  },
  {
    name: "Lakewood Handyman Services",
    slug: "lakewood-handyman-services",
    rating: 4.7,
    reviewCount: 156,
    address: "567 Wadsworth Blvd, Lakewood, CO 80214",
    location: {
      lat: 39.7280,
      lng: -105.0824
    },
    categories: ["Handyman", "Home-Remodeling", "Painting"],
    phone: "(303) 555-0125",
    website: "https://example.com/lakewood-handyman",
    businessStatus: "OPERATIONAL"
  }
];

async function main() {
  console.log('Start seeding...');
  
  for (const contractor of contractors) {
    const result = await prisma.contractor.create({
      data: contractor
    });
    console.log(`Created contractor: ${result.name} (${result.slug})`);
  }
  
  console.log('Seeding finished.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
