import prismaManager from '../lib/prisma';

async function main() {
  console.log('🧹 ANTHILL DUPLICATE CLEANUP INITIATED...');
  const prisma = prismaManager.getClient('TR');

  // Fetch all Anthill properties
  const props = await prisma.property.findMany({
    where: {
      id: { startsWith: 'prop_ANTHILL_' }
    }
  });

  console.log(`Found ${props.length} Anthill properties in total.`);

  const toDelete = props.filter(p => {
    if (p.id === 'prop_ANTHILL_MASTER') return false;
    // Suffix IDs have more than 4 segments when split by '_'
    return p.id.split('_').length > 4;
  });

  console.log(`Identified ${toDelete.length} suffix properties to delete.`);

  if (toDelete.length === 0) {
    console.log('No duplicates to delete.');
    return;
  }

  const deleteIds = toDelete.map(p => p.id);

  // Perform deletion
  const result = await prisma.property.deleteMany({
    where: {
      id: { in: deleteIds }
    }
  });

  console.log(`✅ Successfully deleted ${result.count} duplicate property records!`);
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
