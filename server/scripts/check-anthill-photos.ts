import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkAnthillPhotos() {
  try {
    console.log('Connecting to Turkish database...');
    await prisma.$connect();
    
    // Get Anthill properties
    const anthillProperties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: 'ANTHILL', mode: 'insensitive' } },
          { city: { contains: 'İSTANBUL', mode: 'insensitive' } },
        ],
      },
      take: 5,
    });

    console.log(`\nFound ${anthillProperties.length} Anthill properties\n`);

    for (const property of anthillProperties) {
      console.log(`\n=== Property: ${property.name} (${property.id}) ===`);
      
      // Get photos for this property
      const photos = await prisma.propertyPhoto.findMany({
        where: {
          propertyId: property.id,
        },
        orderBy: {
          isPrimary: 'desc',
        },
      });

      console.log(`Total photos: ${photos.length}`);
      
      if (photos.length > 0) {
        console.log('Primary photo:');
        const primaryPhoto = photos.find(p => p.isPrimary);
        if (primaryPhoto) {
          console.log(`  URL: ${primaryPhoto.url}`);
          console.log(`  Caption: ${primaryPhoto.caption}`);
        } else {
          console.log('  No primary photo found');
        }
        
        console.log('\nAll photos:');
        for (const photo of photos) {
          console.log(`  - ${photo.url} (isPrimary: ${photo.isPrimary})`);
        }
      } else {
        console.log('No photos found');
      }
    }
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkAnthillPhotos();
