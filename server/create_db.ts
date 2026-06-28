import { PrismaClient } from "@prisma/client";

async function run() {
  const prisma = new PrismaClient({
    datasources: {
      db: {
        url: "postgresql://os2026@localhost:5432/postgres",
      },
    },
  });

  try {
    await prisma.$connect();
    console.log("Connected to default postgres db");
    // We can't use executeRaw for CREATE DATABASE. 
    // Wait, executeRawUnsafe might work if it's not in a transaction.
    // Let's try it.
    await prisma.$executeRawUnsafe(`CREATE DATABASE realestate_us;`);
    console.log("Created database realestate_us");
  } catch (e: any) {
    if (e.message.includes("already exists")) {
      console.log("Database already exists.");
    } else {
      console.error(e);
    }
  } finally {
    await prisma.$disconnect();
  }
}

run();
