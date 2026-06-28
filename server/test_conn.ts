import { PrismaClient } from "@prisma/client";

async function testUrl(url: string) {
  console.log(`Testing: ${url}`);
  const prisma = new PrismaClient({
    datasources: {
      db: {
        url: url,
      },
    },
  });
  try {
    await prisma.$connect();
    console.log(`✅ Success: ${url}`);
    await prisma.$disconnect();
    return true;
  } catch (e: any) {
    console.log(`❌ Failed: ${e.message.split('\n').slice(-1)[0]}`);
    await prisma.$disconnect();
    return false;
  }
}

async function run() {
  const urls = [
    "postgresql://postgres:1928@localhost:5432/realestate_us",
    "postgresql://postgres:1928@localhost:5432/postgres",
    "postgresql://os2026:1928@localhost:5432/realestate_us",
    "postgresql://os2026@localhost:5432/realestate_us",
    "postgresql://os2026@localhost:5432/postgres",
    "postgresql://postgres@localhost:5432/postgres"
  ];
  
  for (const url of urls) {
    const success = await testUrl(url);
    if (success) {
      console.log(`\nFound working URL: ${url}`);
      process.exit(0);
    }
  }
  console.log("\nNone of the URLs worked.");
  process.exit(1);
}

run();
