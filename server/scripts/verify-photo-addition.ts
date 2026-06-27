import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function verifyPhotoAddition() {
  try {
    console.log('Verifying photo addition to Anthill properties...');
    await prisma.$connect();
    
    // Check total photos in database
    const totalPhotos = await prisma.$queryRaw`
      SELECT COUNT(*) as count FROM "PropertyPhoto"
    `;
    
    console.log('Total photos in database:', totalPhotos);
    
    // Check photos for specific Anthill properties
    const testProperties = [
      'prop_ANTHILL2018__UNIT1234',
      'prop_ANTHILL2018__UNIT1995',
      'prop_ANTHILL2018__UNIT2650',
    ];
    
    for (const propertyId of testProperties) {
      const photos = await prisma.propertyPhoto.findMany({
        where: { propertyId },
      });
      console.log(`${propertyId}: ${photos.length} photos`);
      if (photos.length > 0) {
        photos.forEach(p => console.log(`  - ${p.url}`));
      }
    }
    
    // Check how many Anthill properties have photos
    const anthillPropertiesWithPhotos = await prisma.$queryRaw`
      SELECT COUNT(DISTINCT "propertyId") as count 
      FROM "PropertyPhoto" 
      WHERE "propertyId" ILIKE '%anthill%'
    `;
    
    console.log('Anthill properties with photos:', anthillPropertiesWithPhotos);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

verifyPhotoAddition();
