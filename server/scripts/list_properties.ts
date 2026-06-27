import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();
async function main() {
  const allProperties = await prisma.property.findMany({
    take: 10,
    select: { id: true, name: true, createdBy: true }
  });
  console.log(allProperties);
}
main().catch(console.error).finally(() => prisma.$disconnect());
