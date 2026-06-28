import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function hashPassword(password: string): Promise<string> {
  return Bun.password.hash(password, { algorithm: "bcrypt", cost: 10 });
}

async function run() {
  const email = "info@reservatior.com";
  const password = "Parola341";
  
  let user = await prisma.user.findUnique({ where: { email } });
  const passwordHash = await hashPassword(password);

  if (!user) {
    user = await prisma.user.create({
      data: { email, name: "Admin", originRegion: "US" },
    });
    console.log("Created user.");
  } else {
    console.log("User already exists.");
  }

  const account = await prisma.account.findFirst({
    where: { userId: user.id, providerId: "credentials" },
  });

  if (!account) {
    await prisma.account.create({
      data: {
        userId: user.id,
        type: "CREDENTIALS",
        providerId: "credentials",
        accountId: email,
        accessToken: passwordHash,
      },
    });
    console.log("Created credentials account.");
  } else {
    await prisma.account.update({
      where: { id: account.id },
      data: { accessToken: passwordHash },
    });
    console.log("Updated credentials password.");
  }

  console.log("Admin account setup complete.");
  process.exit(0);
}

run().catch(console.error);
