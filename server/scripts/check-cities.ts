import { PrismaClient } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const prisma = prismaManager.getClient("US");

async function main() {
  const cities = await prisma.property.findMany({
    where: { country: "US" },
    select: { city: true, state: true },
    distinct: ['city', 'state'],
    take: 50
  });
  
  console.log("Cities in US database:");
  cities.forEach(c => console.log(`- ${c.city}, ${c.state}`));
  
  await prisma.$disconnect();
}

main();
