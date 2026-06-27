import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function updateAnthillProperty() {
  try {
    console.log('Updating Anthill property in Turkish database...');
    await prisma.$connect();
    
    // Update property type and name
    const property = await prisma.property.update({
      where: { id: 'anthill_tr_1' },
      data: {
        name: 'Anthill Residence - İstanbul',
        type: 'APARTMENT', // Update to appropriate property type for apartments
      },
    });
    
    console.log('Property updated:', property.name, property.type);
    
    // Update listing type from BOOKING to SALE
    const listing = await prisma.listing.updateMany({
      where: { propertyId: 'anthill_tr_1' },
      data: {
        type: 'SALE',
        title: 'Anthill Residence - Satılık Daireler',
        description: 'Anthill Residence İstanbul\'da modern yaşam alanları. Satılık daireler.',
      },
    });
    
    console.log(`Updated ${listing.count} listing records`);
    
    console.log('Anthill property updated successfully');
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

updateAnthillProperty();
