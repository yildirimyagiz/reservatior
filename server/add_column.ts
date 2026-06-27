import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient({
  datasources: {
    db: {
      url: "postgresql://postgres:1928@localhost:5432/elysia_realestate"
    }
  }
});
async function run() {
  try {
    await prisma.$executeRawUnsafe(`ALTER TABLE "public"."Property" ADD COLUMN "currency" TEXT DEFAULT 'USD';`);
    console.log("Column added");
  } catch (e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}
run();
