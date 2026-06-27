import { PropertyCategory, PropertyType, ListingType, ListingStatus, Region } from '@/schemas/generated';
import prismaManager from '../lib/prisma';

async function main() {
  const prisma = prismaManager.getClient('TR');
  console.log('🚀 Starting Queen Sinpaş Missing Units Import...');

  // 1. Get all existing BB numbers to find the gaps
  const existingProps = await prisma.property.findMany({
    where: { id: { startsWith: 'prop_queen_' } },
    select: { id: true }
  });
  const existingBBs = new Set(existingProps.map(p => parseInt(p.id.replace('prop_queen_', ''))));

  // The 26 column types in order (from right to left in the floor plan for mathematical mapping)
  // Left wing (8), Right wing (8), Mid left (5), Mid right (5)
  const columns = [
    { type: '1+1', letter: 'H', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'G', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'F', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'E', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'D', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'C', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'B', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'A', m2: 103.58, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'U', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'F', m2: 49.33, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'E', m2: 49.33, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'D', m2: 49.33, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'T', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'S', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'R', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'P', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'O', m2: 49.33, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'N', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'M', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'L', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'K', m2: 103.58, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'J', m2: 99.4, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'C', m2: 49.33, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'B', m2: 46.23, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+0', letter: 'A', m2: 49.33, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT },
    { type: '1+1', letter: 'I', m2: 99.18, cat: PropertyCategory.RESIDENTIAL, pType: PropertyType.APARTMENT }
  ];

  let addedProps = 0;
  
  // Define standard floor ranges
  const standardFloors = [];
  for (let f = 10; f <= 16; f++) standardFloors.push({ kat: f, startBB: 261 + (f - 10) * 26, count: 26 });
  for (let f = 18; f <= 38; f++) standardFloors.push({ kat: f, startBB: 261 + (f - 10) * 26 - 8, count: 26 });
  for (let f = 44; f <= 46; f++) standardFloors.push({ kat: f, startBB: 1094 + (f - 44) * 26, count: 26 });

  for (const floor of standardFloors) {
    for (let i = 0; i < floor.count; i++) {
      // The BB layout formula matches the column mapping
      // Left block A-H is offset +7 to 0
      // Right block I-Z is offset +25 to +8
      let colIndex = 0;
      if (i < 8) { // Left block (H to A)
        colIndex = 7 - i;
      } else { // Right block (I to Z)
        colIndex = 25 - (i - 8);
      }
      
      const bbNo = floor.startBB + i;
      const col = columns[colIndex];
      
      if (!existingBBs.has(bbNo)) {
        const propId = `prop_queen_${bbNo}`;
        const bedBath = col.type === '1+1' ? { b: 1, ba: 1 } : col.type === '1+0' ? { b: 0, ba: 1 } : { b: 2, ba: 1 };
        
        await prisma.property.upsert({
          where: { id: propId },
          update: {},
          create: {
            id: propId,
            orgId: 'org_queen_mgmt',
            name: `Queen ${col.type} ${col.letter} - BB ${bbNo}`,
            type: col.pType,
            region: Region.TR,
            currency: 'TRY',
            addressLine1: `Cumhuriyet Mah. Bomonti, Şişli/İstanbul - BB ${bbNo}`,
            city: 'Istanbul',
            state: 'Sisli',
            country: 'Turkey',
            daireNo: String(bbNo),
            site_ici: true,
            kat: floor.kat,
            bedrooms: bedBath.b,
            bathrooms: bedBath.ba,
            areaSqm: col.m2,
            yearBuilt: 2018,
            propertyCategory: col.cat,
            listingType: ListingType.SALE,
            listingStatus: ListingStatus.AVAILABLE,
            guvenlik: true,
            otopark: true,
            havuz: true,
            spor_salonu: true,
            projects: { connect: { id: 'proj_QUEEN' } }
          }
        });
        addedProps++;
      }
    }
  }

  // Generic Sinpas units for non-standard gaps (1-260, 443-460, 1007-1093, 1172-1198)
  const maxBB = 1198;
  for (let bb = 1; bb <= maxBB; bb++) {
    if (!existingBBs.has(bb)) {
      // Check if it's already covered by standard floors logic
      const isStandard = standardFloors.some(f => bb >= f.startBB && bb < f.startBB + f.count);
      if (!isStandard) {
        const propId = `prop_queen_${bb}`;
        await prisma.property.upsert({
          where: { id: propId },
          update: {},
          create: {
            id: propId,
            orgId: 'org_queen_mgmt',
            name: `Queen Daire - BB ${bb}`,
            type: PropertyType.APARTMENT,
            region: Region.TR,
            currency: 'TRY',
            addressLine1: `Cumhuriyet Mah. Bomonti, Şişli/İstanbul - BB ${bb}`,
            city: 'Istanbul',
            state: 'Sisli',
            country: 'Turkey',
            daireNo: String(bb),
            site_ici: true,
            bedrooms: 1,
            bathrooms: 1,
            areaSqm: 80,
            yearBuilt: 2018,
            propertyCategory: PropertyCategory.RESIDENTIAL,
            listingType: ListingType.SALE,
            listingStatus: ListingStatus.AVAILABLE,
            projects: { connect: { id: 'proj_QUEEN' } }
          }
        });
        addedProps++;
      }
    }
  }

  console.log(`✅ Successfully added ${addedProps} missing Sinpaş properties!`);
  const total = await prisma.property.count({ where: { id: { startsWith: 'prop_queen_' } } });
  console.log(`🏢 Total Queen Properties in DB: ${total}`);
  await prisma.$disconnect();
}

main().catch(console.error);
