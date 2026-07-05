import { prisma } from "./src/lib/prisma";

async function hashPassword(password: string): Promise<string> {
  return Bun.password.hash(password, { algorithm: "bcrypt", cost: 10 });
}

async function createAdminUser() {
  const email = "info@reservatior.com";
  const password = "Parola341";
  const name = "Admin User";
  
  // Check if user exists
  let user = await prisma.user.findUnique({ where: { email } });
  
  if (!user) {
    const passwordHash = await hashPassword(password);
    
    user = await prisma.user.create({
      data: { 
        email, 
        name, 
        originRegion: "TR" 
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
    
    console.log("✅ User created:", user.email, user.id);
  } else {
    console.log("ℹ️ User already exists:", user.email, user.id);
    
    // Check if account exists
    const account = await prisma.account.findFirst({
      where: { userId: user.id, providerId: "credentials" },
    });
    
    if (!account) {
      const passwordHash = await hashPassword(password);
      await prisma.account.create({
        data: {
          userId: user.id,
          type: "CREDENTIALS",
          providerId: "credentials",
          accountId: email,
          accessToken: passwordHash,
        },
      });
      console.log("✅ Account created for existing user");
    } else {
      // Reset password
      const passwordHash = await hashPassword(password);
      await prisma.account.update({
        where: { id: account.id },
        data: { accessToken: passwordHash },
      });
      console.log("✅ Password reset for existing account");
    }
  }
}

createAdminUser()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Error:", error);
    process.exit(1);
  });
