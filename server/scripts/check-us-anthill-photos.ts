import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function checkUSAnthillPhotos() {
  try {
    console.log('Connecting to US database...');
    await prisma.$connect();
    
    // Get Anthill properties
    const anthillProperties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: 'ANTHILL', mode: 'insensitive' } },
        ],
      },
      take: 5,
    });

    console.log(`\nFound ${anthillProperties.length} Anthill properties in US database\n`);

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

checkUSAnthillPhotos();
