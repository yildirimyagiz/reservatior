import { PrismaClient } from "@prisma/client";

const prismaUS = new PrismaClient({ datasources: { db: { url: process.env.DATABASE_URL_US || "postgresql://postgres:1928@localhost:5432/realestate_us" } } });
const prismaTR = new PrismaClient({ datasources: { db: { url: process.env.DATABASE_URL_TR || "postgresql://postgres:1928@localhost:5432/realestate_tr" } } });

async function seedListings(client: PrismaClient, region: string) {
  const properties = await client.property.findMany({ take: 20 });
  let count = 0;

  for (const prop of properties) {
    // Check if listing already exists
    const existing = await client.listing.findFirst({ where: { propertyId: prop.id } });
    if (!existing) {
      await client.listing.create({
        data: {
          propertyId: prop.id,
          orgId: prop.orgId,
          type: "BOOKING",
          status: "AVAILABLE",
          title: `Premium Stay at ${prop.name}`,
          description: `Experience luxury at its finest in ${prop.city || 'this location'}. Perfect for short term rentals.`,
          price: 150.00 + Math.floor(Math.random() * 200), // Random price between 150 and 350
          priceCurrency: region === "USA" ? "USD" : "TRY",
        }
      });
      count++;
    }
  }
  console.log(`✅ ${region}: Seeded ${count} active 'BOOKING' listings for Google Hotels ARI test.`);
}

async function run() {
  await seedListings(prismaUS, "USA");
  await seedListings(prismaTR, "TR");
  await prismaUS.$disconnect();
  await prismaTR.$disconnect();
}

run();
