import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function testTurkishConnection() {
  try {
    console.log('Testing Turkish database connection with main schema...');
    await prisma.$connect();
    
    // Test PropertyPhoto query
    const photos = await prisma.propertyPhoto.findMany({
      where: {
        propertyId: 'airbnb_tr_1',
      },
      take: 5,
    });

    console.log(`Found ${photos.length} photos for airbnb_tr_1`);
    if (photos.length > 0) {
      console.log('Sample photo:', photos[0]);
    }

    // Test Property query with photos
    const property = await prisma.property.findUnique({
      where: { id: 'airbnb_tr_1' },
      include: { photos: true },
    });

    console.log(`Property with photos:`, property ? 'Found' : 'Not found');
    if (property) {
      console.log(`Photos count: ${property.photos.length}`);
    }
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

testTurkishConnection();
