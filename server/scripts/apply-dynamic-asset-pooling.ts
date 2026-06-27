import { PrismaClient } from "@prisma/client";
import crypto from "crypto";

// Initialize both databases
const prismaUS = new PrismaClient({
  datasources: { db: { url: process.env.DATABASE_URL_US || "postgresql://postgres:1928@localhost:5432/realestate_us" } }
});

const prismaTR = new PrismaClient({
  datasources: { db: { url: process.env.DATABASE_URL_TR || "postgresql://postgres:1928@localhost:5432/realestate_tr" } }
});

/**
 * Generates a deterministic sequence of numbers based on the property ID
 * so the images are random but ALWAYS consistent for the same property.
 */
function getDeterministicSeeds(propertyId: string, count: number): number[] {
  const hash = crypto.createHash("md5").update(propertyId).digest("hex");
  // Convert parts of the hash to numbers
  const seeds: number[] = [];
  for (let i = 0; i < count; i++) {
    const slice = hash.substring(i * 4, i * 4 + 4);
    seeds.push(parseInt(slice, 16));
  }
  return seeds;
}

async function processClient(client: PrismaClient, region: "USA" | "TR") {
  console.log(`\n🚀 Starting Dynamic Asset Pooling for ${region}...`);

  // Fetch all properties
  const properties = await client.property.findMany({
    select: { id: true, name: true, orgId: true }
  });

  console.log(`Found ${properties.length} total properties in ${region}.`);

  // Keywords to ensure high quality visual variety
  const keywords = region === "USA" 
    ? "luxury,apartment,interior,modern" 
    : "luxury,residence,interior,istanbul";

  let updatedCount = 0;
  let skippedCount = 0;

  // Process in batches
  const BATCH_SIZE = 100;
  for (let i = 0; i < properties.length; i += BATCH_SIZE) {
    const batch = properties.slice(i, i + BATCH_SIZE);
    
    for (const prop of batch) {
      // DONT overwrite Anthill, Buyukyali, Validebag which have real local photos
      if (
        prop.name.toLowerCase().includes("anthill") || 
        prop.name.toLowerCase().includes("büyükyalı") || 
        prop.name.toLowerCase().includes("validebağ") ||
        prop.name.toLowerCase().includes("queen")
      ) {
        skippedCount++;
        continue;
      }

      // Generate 6 unique deterministc seeds
      const seeds = getDeterministicSeeds(prop.id, 6);
      
      const newPhotos = seeds.map((seed, idx) => ({
        propertyId: prop.id,
        orgId: prop.orgId,
        url: `https://loremflickr.com/800/600/${keywords}?lock=${seed}`,
        isPrimary: idx === 0,
        sortOrder: idx
      }));

      // In a transaction: delete old photos and insert new dynamic ones
      await client.$transaction([
        client.propertyPhoto.deleteMany({ where: { propertyId: prop.id } }),
        client.propertyPhoto.createMany({ data: newPhotos })
      ]);

      updatedCount++;
    }

    if (i % 1000 === 0 && i > 0) {
      console.log(`Processed ${i} properties...`);
    }
  }

  console.log(`✅ ${region} Update Complete:`);
  console.log(`   - Diversified Images For: ${updatedCount} properties`);
  console.log(`   - Skipped (Real Assets): ${skippedCount} properties`);
}

async function run() {
  try {
    await processClient(prismaUS, "USA");
    await processClient(prismaTR, "TR");
    console.log("\n🎉 Dynamic Asset Pooling fully deployed!");
  } catch (error) {
    console.error("Error during execution:", error);
  } finally {
    await prismaUS.$disconnect();
    await prismaTR.$disconnect();
  }
}

run();
