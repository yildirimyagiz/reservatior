import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function fixPhotosPropertyId() {
  try {
    console.log('Fixing photos propertyId...');
    await prisma.$connect();
    
    const oldId = 'airbnb_tr_1';
    const newId = 'anthill_tr_1';
    
    // Check photos with old propertyId
    const oldPhotos = await prisma.propertyPhoto.findMany({
      where: { propertyId: oldId },
    });
    
    console.log(`Found ${oldPhotos.length} photos with old propertyId ${oldId}`);
    
    // Update photos to new propertyId
    const result = await prisma.propertyPhoto.updateMany({
      where: { propertyId: oldId },
      data: { propertyId: newId },
    });
    
    console.log(`Updated ${result.count} photo records`);
    
    // Verify
    const newPhotos = await prisma.propertyPhoto.findMany({
      where: { propertyId: newId },
    });
    
    console.log(`Photos with new propertyId ${newId}: ${newPhotos.length}`);
    newPhotos.forEach(photo => {
      console.log(`- ${photo.url}`);
    });
    
    console.log('Photos propertyId fixed successfully');
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

fixPhotosPropertyId();
