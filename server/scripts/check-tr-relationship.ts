import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkRelationship() {
  try {
    console.log('Checking Property-PropertyPhoto relationship in Turkish database...');
    await prisma.$connect();
    
    // Check if property exists
    const property = await prisma.property.findUnique({
      where: { id: 'airbnb_tr_1' },
    });
    console.log(`Property exists: ${property ? 'Yes' : 'No'}`);
    
    // Check photos with direct query
    const photos = await prisma.propertyPhoto.findMany({
      where: { propertyId: 'airbnb_tr_1' },
    });
    console.log(`Direct photo query found: ${photos.length} photos`);
    
    // Check relationship with raw SQL
    const result = await prisma.$queryRaw`
      SELECT 
        p.id as property_id,
        p.name as property_name,
        COUNT(pp.id) as photo_count
      FROM "Property" p
      LEFT JOIN "PropertyPhoto" pp ON p.id = pp."propertyId"
      WHERE p.id = ${'airbnb_tr_1'}
      GROUP BY p.id, p.name
    `;
    console.log('Raw SQL result:', result);
    
    // Check table structure
    const tableInfo = await prisma.$queryRaw`
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'PropertyPhoto' 
      ORDER BY ordinal_position
      LIMIT 10
    `;
    console.log('PropertyPhoto columns:', tableInfo);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkRelationship();
