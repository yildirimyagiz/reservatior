import { PrismaClient } from "@prisma/client";

async function main() {
  console.log("Testing connection...");
  const prisma = new PrismaClient({
    datasourceUrl: "postgresql://postgres:1928@localhost:5432/elysia_realestate"
  });
  
  try {
    await prisma.$connect();
    console.log("Connected successfully to TR database!");
    const count = await prisma.user.count();
    console.log("User count:", count);
  } catch (err) {
    console.error("Connection error:", err);
  } finally {
    await prisma.$disconnect();
  }
}

main();
