import { PrismaClient } from "@prisma/client";
import fs from "fs";
import path from "path";

const prisma = new PrismaClient();

async function main() {
  console.log("🗺️ --- RESERVATIOR GEOJSON INGESTION SYSTEM ---");
  
  const geojsonPath = path.resolve(__dirname, "../../datalar/airbnb/usa/il/chicago/neighbourhoods.geojson");
  
  if (!fs.existsSync(geojsonPath)) {
    console.error("❌ GeoJSON file not found at:", geojsonPath);
    process.exit(1);
  }

  console.log(`\n📦 Reading GeoJSON: ${geojsonPath}`);
  const rawData = fs.readFileSync(geojsonPath, "utf-8");
  const geojson = JSON.parse(rawData);

  if (!geojson.features || !Array.isArray(geojson.features)) {
    console.error("❌ Invalid GeoJSON format: 'features' array missing.");
    process.exit(1);
  }

  // Ensure Organization exists
  const orgName = "Reservatior USA - Chicago Portfolio";
  let org = await prisma.organization.findFirst({
    where: { name: orgName }
  });

  if (!org) {
    org = await prisma.organization.create({
      data: {
        name: orgName,
        type: "OWNER_PORTFOLIO",
        region: "USA"
      }
    });
  }

  console.log(`✅ Organization Ready: ${org.name}`);
  console.log(`📊 Processing ${geojson.features.length} neighborhoods...`);

  let successCount = 0;

  for (const feature of geojson.features) {
    const name = feature.properties?.neighbourhood;
    if (!name) continue;

    // Calculate a rough centroid (average of first polygon's coordinates)
    let lat = 41.8781; // default Chicago lat
    let lng = -87.6298; // default Chicago lng
    
    if (feature.geometry?.coordinates?.[0]?.[0]) {
      const coords = feature.geometry.coordinates[0][0]; // MultiPolygon structure
      if (Array.isArray(coords)) {
        let sumLat = 0, sumLng = 0, count = 0;
        // Simple average of boundary points for centroid
        for (const [ptLng, ptLat] of coords) {
          if (typeof ptLng === 'number' && typeof ptLat === 'number') {
            sumLng += ptLng;
            sumLat += ptLat;
            count++;
          }
        }
        if (count > 0) {
          lng = sumLng / count;
          lat = sumLat / count;
        }
      }
    }

    try {
      await prisma.neighborhood.upsert({
        where: {
          orgId_name: {
            orgId: org.id,
            name: name
          }
        },
        update: {
          lat,
          lng
        },
        create: {
          orgId: org.id,
          name: name,
          city: "Chicago",
          state: "IL",
          lat,
          lng
        }
      });
      successCount++;
    } catch (e: any) {
      console.error(`⚠️ Failed to ingest neighborhood ${name}:`, e.message);
    }
  }

  console.log(`\n🏁 --- GEOJSON INGESTION COMPLETED ---`);
  console.log(`✅ Successfully loaded ${successCount} Neighborhood boundaries!`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
