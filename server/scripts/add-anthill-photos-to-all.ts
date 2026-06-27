import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function addAnthillPhotosToAllProperties() {
  try {
    console.log('Adding Anthill photos to all Anthill properties...');
    await prisma.$connect();
    
    // Get general Anthill images from the main property
    const sourcePhotos = await prisma.propertyPhoto.findMany({
      where: { propertyId: 'anthill_tr_1' },
    });
    
    console.log(`Found ${sourcePhotos.length} source photos from anthill_tr_1`);
    
    // Get all Anthill properties
    const anthillProperties = await prisma.$queryRaw`
      SELECT id FROM "Property" WHERE id ILIKE '%anthill%' OR name ILIKE '%anthill%'
    `;
    
    console.log(`Found ${(anthillProperties as any[]).length} Anthill properties`);
    
    // Add photos to each Anthill property
    let addedCount = 0;
    let skippedCount = 0;
    
    for (const property of anthillProperties as any[]) {
      const propertyId = (property as any).id;
      
      // Check if property already has photos
      const existingPhotos = await prisma.propertyPhoto.findMany({
        where: { propertyId },
      });
      
      if (existingPhotos.length > 0) {
        console.log(`Skipping ${propertyId} - already has ${existingPhotos.length} photos`);
        skippedCount++;
        continue;
      }
      
      // Add photos to this property
      for (const photo of sourcePhotos) {
        await prisma.propertyPhoto.create({
          data: {
            id: `photo_${propertyId}_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
            orgId: photo.orgId,
            propertyId,
            url: photo.url,
            caption: photo.caption,
            isPrimary: photo.isPrimary,
            sortOrder: photo.sortOrder,
          },
        });
      }
      
      console.log(`Added ${sourcePhotos.length} photos to ${propertyId}`);
      addedCount++;
    }
    
    console.log('\n=== SUMMARY ===');
    console.log(`Total Anthill properties: ${(anthillProperties as any[]).length}`);
    console.log(`Photos added to: ${addedCount} properties`);
    console.log(`Skipped (already had photos): ${skippedCount} properties`);
    console.log('Anthill photos added successfully');
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

addAnthillPhotosToAllProperties();
