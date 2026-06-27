import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkAnthillApartments() {
  try {
    console.log('Checking Anthill apartments in Turkish database...');
    await prisma.$connect();
    
    // Check anthill_tr_1 property
    const property = await prisma.property.findUnique({
      where: { id: 'anthill_tr_1' },
    });
    
    console.log('Property:', property?.name, property?.id);
    
    // Check for any related units/apartments
    const units = await prisma.$queryRaw`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      AND table_name LIKE '%unit%' 
      OR table_name LIKE '%apartment%'
    `;
    
    console.log('Unit/Apartment tables:', units);
    
    // Check if there are any properties with Anthill in the name
    const anthillProperties = await prisma.property.findMany({
      where: {
        name: {
          contains: 'Anthill',
          mode: 'insensitive'
        }
      }
    });
    
    console.log(`Found ${anthillProperties.length} properties with 'Anthill' in name`);
    anthillProperties.forEach(p => {
      console.log(`- ${p.id}: ${p.name}`);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkAnthillApartments();
