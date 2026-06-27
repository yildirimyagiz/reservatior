import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const email = "info@reservatior.com";
  // Create a hashed password for "admin12345"
  const passwordHash = await Bun.password.hash("admin12345", { algorithm: "bcrypt" });

  const user = await prisma.user.upsert({
    where: { email },
    update: {},
    create: {
      email,
      name: "Reservatior Admin",
    },
  });

  await prisma.account.upsert({
    where: { 
      providerId_accountId: {
        providerId: "credentials",
        accountId: email
      }
    },
    update: {
      accessToken: passwordHash
    },
    create: {
      userId: user.id,
      type: "CREDENTIALS",
      providerId: "credentials",
      accountId: email,
      accessToken: passwordHash,
    },
  });

  console.log(`User ${email} created/updated with password "admin12345"`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
