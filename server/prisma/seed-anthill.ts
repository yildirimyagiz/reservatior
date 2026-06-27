import { PrismaClient } from '@prisma/client';
import dotenv from 'dotenv';

dotenv.config();

const url = process.env.DATABASE_URL_TR;
const prisma = new PrismaClient({
  datasources: {
    db: { url }
  }
});

async function main() {
  console.log('Seeding Anthill Residence (880 units) into TR database...');

  const orgId = 'org-reservatior-global';
  
  // 1. Ensure Organization exists
  await prisma.organization.upsert({
    where: { id: orgId },
    update: {
      type: 'OWNER_PORTFOLIO',
      region: 'TR'
    },
    create: {
      id: orgId,
      name: 'Reservatiôr Global',
      type: 'OWNER_PORTFOLIO',
      region: 'TR'
    }
  });

  // 2. Ensure Anthill Project exists
  const projectId = 'project-anthill-residence-1';
  await prisma.project.upsert({
    where: { id: projectId },
    update: {
      name: 'Anthill Residence',
      description: 'Luxury twin towers in Bomonti, Istanbul with 880 units.',
      projectType: 'RESIDENTIAL_COMPLEX',
      status: 'COMPLETED',
      orgId
    },
    create: {
      id: projectId,
      name: 'Anthill Residence',
      description: 'Luxury twin towers in Bomonti, Istanbul with 880 units.',
      projectType: 'RESIDENTIAL_COMPLEX',
      status: 'COMPLETED',
      orgId
    }
  });

  // 3. Seed Units (880 units)
  const towers = ['A', 'B'];
  const floors = 54;
  const unitsPerFloor = 8;
  
  console.log('Creating units...');
  
  let unitCount = 0;
  const batchSize = 100;
  let currentBatch: any[] = [];

  for (const tower of towers) {
    for (let floor = 1; floor <= floors; floor++) {
      for (let u = 1; u <= unitsPerFloor; u++) {
        unitCount++;
        const unitNumber = `${tower}-${floor}${u.toString().padStart(2, '0')}`;
        const hasSeaView = floor >= 23;
        
        currentBatch.push({
          id: `property-anthill-${unitNumber}`,
          orgId,
          projectId,
          name: `Anthill Residence ${unitNumber}`,
          type: 'APARTMENT',
          region: 'TR',
          currency: 'TRY',
          addressLine1: 'Bomonti, Şişli',
          addressLine2: '', // Avoid null if possible
          city: 'Istanbul',
          country: 'Turkey',
          // cityCode: 'ISTANBUL', // Removed to avoid enum issues
          kat: floor,
          daireNo: unitNumber,
          viewType: hasSeaView ? 'SEA_VIEW' : 'CITY_VIEW',
          propertyCategory: 'RESIDENTIAL',
          listingType: 'SALE',
          listingStatus: 'AVAILABLE',
          listingPrice: 5000000 + (floor * 100000) + (hasSeaView ? 2000000 : 0),
          areaSqm: 80 + (u * 10),
          bedrooms: u <= 4 ? 1 : (u <= 7 ? 2 : 3),
          bathrooms: u <= 7 ? 1 : 2,
          iskanRuhsatiNo: 'ISKAN-ANTHILL-' + unitNumber,
          katMulkiyeti: true,
          guvenlik: true,
          otopark: true,
          havuz: true,
          sauna: true,
          spor_salonu: true
        });

        if (currentBatch.length >= batchSize) {
          await prisma.property.createMany({
            data: currentBatch,
            skipDuplicates: true
          });
          console.log(`Seeded ${unitCount} units...`);
          currentBatch = [];
        }
      }
    }
  }

  if (currentBatch.length > 0) {
    await prisma.property.createMany({
      data: currentBatch,
      skipDuplicates: true
    });
  }

  console.log(`Finished seeding 880 units for Anthill Residence!`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
