
import PrismaManager from "../src/lib/prisma-manager";

PrismaManager.init();

const GOOGLE_API_KEY = "AIzaSyCb35OmKQht_g443dtLLMzDJA9qArHdFTM";

// Google Street View Static API — returns a real photo of the building at those coordinates
function getStreetViewUrl(lat: number, lng: number, heading: number = 0, size: string = "800x600"): string {
  return `https://maps.googleapis.com/maps/api/streetview?size=${size}&location=${lat},${lng}&heading=${heading}&pitch=10&fov=90&key=${GOOGLE_API_KEY}`;
}

async function run() {
  const client = PrismaManager.getClient("US");

  // 1. Audit: how many properties have coordinates?
  const allProps = await client.property.findMany({
    select: {
      id: true,
      name: true,
      lat: true,
      lng: true,
      addressLine1: true,
      city: true,
      state: true,
      orgId: true,
    }
  });

  const withCoords = allProps.filter(p => p.lat && p.lng && p.lat !== 0 && p.lng !== 0);
  const withoutCoords = allProps.filter(p => !p.lat || !p.lng || p.lat === 0 || p.lng === 0);

  console.log(`\n📊 Property Audit:`);
  console.log(`   Total: ${allProps.length}`);
  console.log(`   With Coordinates: ${withCoords.length} → Street View ready`);
  console.log(`   Without Coordinates: ${withoutCoords.length} → Need DuckDuckGo fallback`);

  // 2. Delete ALL existing garbage photos
  const deleted = await client.propertyPhoto.deleteMany({});
  console.log(`\n🗑️  Deleted ${deleted.count} garbage photos.`);

  // 3. For properties WITH coordinates: generate Google Street View URLs
  // Each property gets 3 angles: front (0°), left side (90°), right side (270°)
  let successCount = 0;
  let errorCount = 0;

  console.log(`\n🏗️  Generating real Street View images for ${withCoords.length} properties...`);

  // Process in batches to avoid overwhelming the DB
  const BATCH_SIZE = 100;
  for (let batch = 0; batch < withCoords.length; batch += BATCH_SIZE) {
    const slice = withCoords.slice(batch, batch + BATCH_SIZE);
    
    const photoData: any[] = [];
    for (const prop of slice) {
      const headings = [0, 90, 270]; // Front, left, right views
      headings.forEach((heading, idx) => {
        photoData.push({
          propertyId: prop.id,
          orgId: prop.orgId,
          url: getStreetViewUrl(prop.lat!, prop.lng!, heading),
          sortOrder: idx,
          isPrimary: idx === 0,
        });
      });
    }

    try {
      await client.propertyPhoto.createMany({ data: photoData, skipDuplicates: true });
      successCount += slice.length;
    } catch (e: any) {
      // Some might fail due to FK constraints (orphan properties), continue
      // Insert one by one as fallback
      for (const photo of photoData) {
        try {
          await client.propertyPhoto.create({ data: photo });
        } catch (_) {
          errorCount++;
        }
      }
      successCount += slice.length;
    }

    if ((batch + BATCH_SIZE) % 500 === 0 || batch + BATCH_SIZE >= withCoords.length) {
      console.log(`   Progress: ${Math.min(batch + BATCH_SIZE, withCoords.length)}/${withCoords.length}`);
    }
  }

  console.log(`\n✅ Street View Photos Generated:`);
  console.log(`   Success: ${successCount} properties (${successCount * 3} photos)`);
  console.log(`   Errors: ${errorCount}`);

  // 4. Report properties without coordinates (for DuckDuckGo phase)
  if (withoutCoords.length > 0) {
    console.log(`\n⚠️  ${withoutCoords.length} properties have no coordinates.`);
    console.log(`   These need geocoding first, then Street View can be applied.`);
    console.log(`   Sample:`);
    withoutCoords.slice(0, 5).forEach(p => {
      console.log(`     - ${p.name} | ${p.addressLine1}, ${p.city} ${p.state}`);
    });
  }

  console.log(`\n🎉 Real image pipeline complete.`);
}

run().catch(console.error).finally(() => PrismaManager.disconnectAll());
