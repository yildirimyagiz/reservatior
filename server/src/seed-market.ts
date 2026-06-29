import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding MarketState...');

  const segments = ['PROPERTY', 'TOURISM', 'AGENT_SERVICE'];

  for (const segment of segments) {
    await prisma.marketState.upsert({
      where: { segment },
      update: {},
      create: {
        segment,
        demandIndex: 0.5,
        supplyIndex: 0.5,
        priceElasticity: 1.2,
        liquidityScore: 1.0,
      },
    });
    console.log(`Seeded MarketState for segment: ${segment}`);
  }

  console.log('Seeding complete.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
