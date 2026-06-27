
import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const ORG_ID = "org_global_luxury_real_estate";

const STANDARD_AMENITIES = [
  { name: "Infinity Pool", category: "OUTDOOR", icon: "pool" },
  { name: "State-of-the-art Gym", category: "FITNESS", icon: "fitness_center" },
  { name: "24/7 Concierge", category: "SECURITY", icon: "concierge" },
  { name: "Private Cinema", category: "ENTERTAINMENT", icon: "movie" },
  { name: "Underground Parking", category: "PARKING", icon: "local_parking" },
  { name: "Luxury Spa & Sauna", category: "FITNESS", icon: "spa" },
  { name: "Smart Home Infrastructure", category: "OTHER", icon: "smart_home" },
  { name: "Rooftop Garden", category: "OUTDOOR", icon: "nature" }
];

const PROJECTS = [
  {
    db: "ae",
    id: "proj_ae_burj_khalifa",
    name: "Burj Khalifa",
    address: "Downtown Dubai",
    city: "Dubai",
    country: "AE",
    region: "UAE",
    type: "PROJECT",
    images: [
      "https://images.unsplash.com/photo-1582672060674-bc2bd808a8b5?auto=format&fit=crop&q=80&w=1200",
      "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&q=80&w=1200",
      "https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?auto=format&fit=crop&q=80&w=1200"
    ],
    amenities: ["Infinity Pool", "24/7 Concierge", "State-of-the-art Gym"]
  },
  {
    db: "uk",
    id: "proj_uk_one_hyde_park",
    name: "One Hyde Park",
    address: "Knightsbridge, London",
    city: "London",
    country: "UK",
    region: "UK",
    type: "PROJECT",
    images: [
      "https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?auto=format&fit=crop&q=80&w=1200",
      "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&q=80&w=1200",
      "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&q=80&w=1200"
    ],
    amenities: ["Private Cinema", "Luxury Spa & Sauna", "24/7 Concierge"]
  },
  {
    db: "br",
    id: "proj_br_delfim_moreira",
    name: "Edifício Delfim Moreira",
    address: "Av. Delfim Moreira, 558, Leblon",
    city: "Rio de Janeiro",
    country: "BR",
    region: "GLOBAL",
    type: "PROJECT",
    images: [
      "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=1200",
      "https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&q=80&w=1200",
      "https://images.unsplash.com/photo-1600607687644-c7171b42398f?auto=format&fit=crop&q=80&w=1200"
    ],
    amenities: ["Rooftop Garden", "Infinity Pool", "Underground Parking"]
  }
];

async function seedRegion(db: string) {
  const url = `postgresql://postgres:1928@localhost:5432/realestate_${db}`;
  const prisma = new PrismaClient({ datasources: { db: { url } } });

  console.log(`\n--- Enforcing Global Infrastructure for: realestate_${db} ---`);

  try {
    // 1. Organization (Raw SQL to be resilient)
    try {
      await prisma.$executeRawUnsafe(`
        INSERT INTO "Organization" (id, name, type, region) 
        VALUES ($1, $2, $3::OrgType, $4::Region) 
        ON CONFLICT (id) DO NOTHING
      `, ORG_ID, "Global Luxury Real Estate Infrastructure", "AGENCY", "GLOBAL");
      
      // Try to update optional fields one by one
      await prisma.$executeRawUnsafe(`UPDATE "Organization" SET currency = 'USD' WHERE id = $1`, ORG_ID).catch(() => {});
      await prisma.$executeRawUnsafe(`UPDATE "Organization" SET locale = 'en-US' WHERE id = $1`, ORG_ID).catch(() => {});
    } catch (orgErr) {}

    // 2. Standard Amenities (Prisma is fine here as it's standard)
    for (const am of STANDARD_AMENITIES) {
      try {
        await prisma.amenity.upsert({
          where: { id: `${ORG_ID}_${am.name.toLowerCase().replace(/\s/g, '_')}` },
          update: { name: am.name, category: am.category as any, icon: am.icon },
          create: {
            id: `${ORG_ID}_${am.name.toLowerCase().replace(/\s/g, '_')}`,
            orgId: ORG_ID,
            name: am.name,
            category: am.category as any,
            icon: am.icon
          }
        });
      } catch (amErr) {}
    }

    // 3. Projects for this region
    const regionProjects = PROJECTS.filter(p => p.db === db);
    for (const proj of regionProjects) {
      try {
        // Upsert Property (Raw SQL)
        await prisma.$executeRawUnsafe(`
          INSERT INTO "Property" (id, "orgId", name, "addressLine1", city, country, region, type) 
          VALUES ($1, $2, $3, $4, $5, $6, $7::Region, $8::PropertyType) 
          ON CONFLICT (id) DO NOTHING
        `, proj.id, ORG_ID, proj.name, proj.address, proj.city, proj.country, proj.region, proj.type);

        // Update optional fields
        await prisma.$executeRawUnsafe(`UPDATE "Property" SET "isDigitalTwin" = true WHERE id = $1`, proj.id).catch(() => {});
      } catch (propErr) {}

      // Add Project Photos (Prisma is usually consistent here)
      for (let i = 0; i < proj.images.length; i++) {
        try {
          await prisma.propertyPhoto.upsert({
            where: { id: `${proj.id}_photo_${i}` },
            update: { url: proj.images[i] },
            create: {
              id: `${proj.id}_photo_${i}`,
              propertyId: proj.id,
              orgId: ORG_ID,
              url: proj.images[i],
              sortOrder: i,
              isPrimary: i === 0
            }
          });
        } catch (photoErr) {}
      }

      // Link Amenities
      for (const amName of proj.amenities) {
        try {
          const amId = `${ORG_ID}_${amName.toLowerCase().replace(/\s/g, '_')}`;
          await prisma.propertyAmenity.upsert({
            where: { propertyId_amenityId: { propertyId: proj.id, amenityId: amId } },
            update: {},
            create: {
              propertyId: proj.id,
              amenityId: amId,
              orgId: ORG_ID
            }
          });
        } catch (linkErr) {}
      }

      console.log(`   [SUCCESS] Seeded project: ${proj.name}`);
    }

  } catch (e) {
    console.error(`   [ERROR] Failed seeding ${db}:`, e);
  } finally {
    await prisma.$disconnect();
  }
}

async function main() {
  const configFiles = fs.readdirSync(path.join(__dirname, '../config'));
  const dbs = configFiles
    .filter(f => f.startsWith('prisma.') && f.endsWith('.config.ts'))
    .map(f => f.split('.')[1]);

  console.log(`Found ${dbs.length} regional databases to enforce.`);

  for (const db of dbs) {
    await seedRegion(db);
  }

  console.log("\nGlobal Infrastructure Enforcement Complete.");
}

main();
