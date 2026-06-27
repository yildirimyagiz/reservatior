import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkPropertiesSimple() {
  try {
    console.log('Checking properties in TR database...');
    await prisma.$connect();
    
    // Get just property IDs and names
    const properties = await prisma.$queryRaw`
      SELECT id, name FROM "Property" LIMIT 20
    `;
    
    console.log('\nProperties in TR database:');
    console.log(properties);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkPropertiesSimple();
