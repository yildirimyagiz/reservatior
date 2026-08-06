import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const hash = await Bun.password.hash("Parola/341", { algorithm: "bcrypt", cost: 10 });

  const user = await prisma.user.upsert({
    where: { email: "info@reservatior.com" },
    update: {
      name: "Admin",
    },
    create: {
      email: "info@reservatior.com",
      name: "Admin",
      emailVerified: true,
    }
  });

  await prisma.account.deleteMany({
    where: { userId: user.id, providerId: "credentials" }
  });

  await prisma.account.create({
    data: {
      userId: user.id,
      providerId: "credentials",
      accountId: "info@reservatior.com",
      type: "CREDENTIALS",
      accessToken: hash,
    }
  });
  console.log("✅ Admin user created/updated:", user.id);
  
  await prisma.$disconnect();
}

main().catch(e => { console.error(e); process.exit(1); });
