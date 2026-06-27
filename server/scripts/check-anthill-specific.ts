import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkAnthillSpecific() {
  try {
    console.log('Checking Anthill property in TR database...');
    await prisma.$connect();
    
    // Check specific Anthill property
    const anthillProperty = await prisma.$queryRaw`
      SELECT id, name FROM "Property" WHERE id = 'anthill_tr_1'
    `;
    
    console.log('Anthill property:', anthillProperty);
    
    // Check for any Anthill-related properties
    const anthillProperties = await prisma.$queryRaw`
      SELECT id, name FROM "Property" WHERE name ILIKE '%anthill%' OR id ILIKE '%anthill%'
    `;
    
    console.log('Anthill-related properties:', anthillProperties);
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkAnthillSpecific();
