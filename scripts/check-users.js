const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function check() {
  const users = await prisma.user.findMany({
    select: { email: true, name: true }
  });
  console.log("Current users:", users);
  await prisma.$disconnect();
}

check();
