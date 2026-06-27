import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  const allProperties = await prisma.property.findMany({
    select: { id: true, name: true, createdBy: true }
  });
  
  const fakeProperties = allProperties.filter(p => 
    p.name.toLowerCase().includes('test') || 
    p.name.toLowerCase().includes('fake') ||
    p.name.toLowerCase().includes('mock') ||
    p.name.toLowerCase().includes('dummy')
  );

  console.log(`Found ${fakeProperties.length} fake properties out of ${allProperties.length} total properties.`);
  
  if (fakeProperties.length > 0) {
    const idsToDelete = fakeProperties.map(p => p.id);
    const deleteResult = await prisma.property.deleteMany({
      where: {
        id: {
          in: idsToDelete
        }
      }
    });
    console.log(`Deleted ${deleteResult.count} fake properties.`);
  } else {
    console.log('No fake properties to delete.');
  }
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
