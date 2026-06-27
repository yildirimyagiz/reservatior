import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkTRPropertyIds() {
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
      select: {
        id: true,
        name: true,
      },
      take: 10,
    });

    console.log(`\nFound ${anthillProperties.length} Anthill properties in Turkish database\n`);

    for (const property of anthillProperties) {
      console.log(`ID: ${property.id}, Name: ${property.name}`);
    }
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkTRPropertyIds();
