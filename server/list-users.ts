import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function list() {
  const users = await prisma.user.findMany();
  console.log("USERS:", JSON.stringify(users, null, 2));
  
  const accounts = await prisma.account.findMany();
  console.log("ACCOUNTS:", JSON.stringify(accounts, null, 2));
  
  process.exit(0);
}

list().catch(console.error);
