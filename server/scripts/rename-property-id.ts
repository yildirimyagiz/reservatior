import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function renamePropertyId() {
  try {
    console.log('Renaming property ID from airbnb_tr_1 to anthill_tr_1...');
    await prisma.$connect();
    
    const oldId = 'airbnb_tr_1';
    const newId = 'anthill_tr_1';
    
    // Check if new ID already exists
    const existingProperty = await prisma.property.findUnique({
      where: { id: newId },
    });
    
    if (existingProperty) {
      console.log(`Property with ID ${newId} already exists. Aborting.`);
      return;
    }
    
    // Update property ID
    const property = await prisma.property.update({
      where: { id: oldId },
      data: { id: newId },
    });
    
    console.log(`Property ID updated: ${oldId} -> ${newId}`);
    
    // Update related records
    const photos = await prisma.propertyPhoto.updateMany({
      where: { propertyId: oldId },
      data: { propertyId: newId },
    });
    
    console.log(`Updated ${photos.count} photo records`);
    
    const listings = await prisma.listing.updateMany({
      where: { propertyId: oldId },
      data: { propertyId: newId },
    });
    
    console.log(`Updated ${listings.count} listing records`);
    
    const agentVideos = await prisma.agentVideo.updateMany({
      where: { propertyId: oldId },
      data: { propertyId: newId },
    });
    
    console.log(`Updated ${agentVideos.count} agent video records`);
    
    const propertyAmenities = await prisma.propertyAmenity.updateMany({
      where: { propertyId: oldId },
      data: { propertyId: newId },
    });
    
    console.log(`Updated ${propertyAmenities.count} property amenity records`);
    
    console.log('Property ID renamed successfully');
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

renamePropertyId();
