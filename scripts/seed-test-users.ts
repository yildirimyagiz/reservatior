import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const SALT_ROUNDS = 10;

async function hashPassword(password: string): Promise<string> {
  return Bun.password.hash(password, { algorithm: "bcrypt", cost: SALT_ROUNDS });
}

async function main() {
  const password = "PasswordLess/11";
  const passwordHash = await hashPassword(password);

  const testUsers = [
    { email: "admin@propos.com", name: "Super Admin", role: "SUPER_ADMIN" },
    { email: "orgadmin.test@propos.com", name: "Org Admin", role: "ORG_ADMIN" },
    { email: "admin.test@propos.com", name: "Admin User", role: "ADMIN" },
    { email: "agent.test@propos.com", name: "Agent User", role: "AGENT" },
    { email: "tenant.test@propos.com", name: "Tenant User", role: "TENANT" },
    { email: "user.test@propos.com", name: "Regular User", role: "USER" },
  ];

  for (const userData of testUsers) {
    console.log(`Ensuring user: ${userData.email}`);
    
    let user = await prisma.user.findUnique({
      where: { email: userData.email }
    });

    if (!user) {
      user = await prisma.user.create({
        data: {
          email: userData.email,
          name: userData.name,
        }
      });
      console.log(`Created user: ${user.email}`);
    }

    const account = await prisma.account.findFirst({
      where: { userId: user.id, providerId: "credentials" }
    });

    if (!account) {
      await prisma.account.create({
        data: {
          userId: user.id,
          type: "CREDENTIALS",
          providerId: "credentials",
          accountId: userData.email,
          accessToken: passwordHash,
        }
      });
      console.log(`Created account for: ${user.email}`);
    } else {
      await prisma.account.update({
        where: { id: account.id },
        data: { accessToken: passwordHash }
      });
      console.log(`Updated password for: ${user.email}`);
    }
  }

  console.log("All test users are ready!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
