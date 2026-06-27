import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function removeUSAnthillPhotos() {
  try {
    console.log('Connecting to US database...');
    await prisma.$connect();
    
    // Find Anthill properties in US database
    const anthillProperties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: 'ANTHILL', mode: 'insensitive' } },
        ],
      },
      select: { id: true },
    });

    console.log(`Found ${anthillProperties.length} Anthill properties in US database`);

    const propertyIds = anthillProperties.map(p => p.id);
    
    // Delete all photos for these properties
    const result = await prisma.propertyPhoto.deleteMany({
      where: {
        propertyId: {
          in: propertyIds,
        },
      },
    });

    console.log(`Deleted ${result.count} photos from US database`);
  } catch (error) {
    console.error('Error removing Anthill photos from US database:', error);
  } finally {
    await prisma.$disconnect();
  }
}

removeUSAnthillPhotos();
