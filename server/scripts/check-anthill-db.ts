import { PrismaClient } from '@prisma/client';
const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';
const prisma = new PrismaClient({ datasources: { db: { url: trDatabaseUrl } } });
async function main() {
  const anthills = await prisma.property.findMany({
    where: { name: { contains: 'Anthill', mode: 'insensitive' } },
    include: { photos: true, floorPlans: true, videoContents: true }
  });
  console.log(`Found ${anthills.length} Anthill properties.`);
  if (anthills.length > 0) {
    console.log(anthills[0].name, 'Photos:', anthills[0].photos.length, 'FloorPlans:', anthills[0].floorPlans.length, 'Videos:', anthills[0].videoContents.length);
  }
}
main().catch(console.error).finally(() => prisma.$disconnect());
