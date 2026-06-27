import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function checkAllAnthillProperties() {
  try {
    console.log('Checking all Anthill properties in TR database...');
    await prisma.$connect();
    
    // Check all properties
    const allProperties = await prisma.property.findMany();
    
    console.log(`\nTotal properties in TR database: ${allProperties.length}`);
    
    // Check for Anthill-related properties
    const anthillProperties = allProperties.filter(p => 
      p.name.toLowerCase().includes('anthill') || 
      p.id.toLowerCase().includes('anthill')
    );
    
    console.log(`\nAnthill-related properties: ${anthillProperties.length}`);
    anthillProperties.forEach(p => {
      console.log(`- ${p.id}: ${p.name}`);
    });
    
    // Check photos for each Anthill property
    for (const property of anthillProperties) {
      const photos = await prisma.propertyPhoto.findMany({
        where: { propertyId: property.id },
      });
      console.log(`\n${property.name} (${property.id}): ${photos.length} photos`);
      photos.forEach(photo => {
        console.log(`  - ${photo.url}`);
      });
    }
    
    // Check all properties that might need Anthill photos
    console.log('\n=== ALL PROPERTIES ===');
    allProperties.forEach(p => {
      console.log(`- ${p.id}: ${p.name}`);
    });
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

checkAllAnthillProperties();
