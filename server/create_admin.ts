import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  const email = "info@reservatior.com";
  const password = "Parola341";

  const passwordHash = await Bun.password.hash(password, { algorithm: "bcrypt", cost: 10 });

  let user = await prisma.user.findUnique({ where: { email } });

  if (user) {
    console.log(`User ${email} already exists, updating password...`);
    // update password
    const account = await prisma.account.findFirst({
      where: { userId: user.id, providerId: "credentials" },
    });
    if (account) {
      await prisma.account.update({
        where: { id: account.id },
        data: { accessToken: passwordHash },
      });
    } else {
      await prisma.account.create({
        data: {
          userId: user.id,
          type: "CREDENTIALS",
          providerId: "credentials",
          accountId: email,
          accessToken: passwordHash,
        },
      });
    }
  } else {
    console.log(`Creating new user ${email}...`);
    user = await prisma.user.create({
      data: { 
        email, 
        name: "Super Admin", 
      },
    });

    await prisma.account.create({
      data: {
        userId: user.id,
        type: "CREDENTIALS",
        providerId: "credentials",
        accountId: email,
        accessToken: passwordHash,
      },
    });
  }
  
  console.log("Done! Super admin user has been successfully created/updated.");
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
