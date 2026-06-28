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
    
    try {
      await prisma.$executeRawUnsafe(`CREATE DATABASE realestate_us;`);
      console.log("Created database realestate_us");
    } catch (e: any) {
      if (e.message.includes("already exists")) {
        console.log("Database realestate_us already exists.");
      } else {
        console.error(e);
      }
    }

    try {
      await prisma.$executeRawUnsafe(`CREATE DATABASE realestate_tr;`);
      console.log("Created database realestate_tr");
    } catch (e: any) {
      if (e.message.includes("already exists")) {
        console.log("Database realestate_tr already exists.");
      } else {
        console.error(e);
      }
    }

  } catch (e: any) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}

run();
