import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function removeMockPhotos() {
  try {
    console.log('Removing mock/Unsplash photos from Turkish database...');
    await prisma.$connect();
    
    // Find all photos for airbnb_tr_1 property
    const photos = await prisma.propertyPhoto.findMany({
      where: { propertyId: 'airbnb_tr_1' },
    });
    
    console.log(`Found ${photos.length} photos for airbnb_tr_1`);
    
    // Identify mock photos (Unsplash URLs or null captions)
    const mockPhotos = photos.filter(photo => 
      photo.url.includes('unsplash.com') || 
      !photo.caption ||
      photo.caption === null
    );
    
    console.log(`Found ${mockPhotos.length} mock photos to remove`);
    
    // Delete mock photos
    for (const photo of mockPhotos) {
      await prisma.propertyPhoto.delete({
        where: { id: photo.id },
      });
      console.log(`Deleted mock photo: ${photo.id}`);
    }
    
    // Verify remaining photos
    const remainingPhotos = await prisma.propertyPhoto.findMany({
      where: { propertyId: 'airbnb_tr_1' },
    });
    
    console.log(`Remaining photos: ${remainingPhotos.length}`);
    remainingPhotos.forEach(photo => {
      console.log(`- ${photo.url} (${photo.caption})`);
    });
    
    console.log('Mock photos removed successfully');
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

removeMockPhotos();
