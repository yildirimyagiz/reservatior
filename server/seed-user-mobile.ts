import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  const email = "info@reservatior.com";
  // The mobile app uses "Parola341" as default
  const passwordHash = await Bun.password.hash("Parola341", { algorithm: "bcrypt" });

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

  console.log(`User ${email} updated with password "Parola341"`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
