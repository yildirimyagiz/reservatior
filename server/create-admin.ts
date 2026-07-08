import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // List existing users
  const users = await prisma.user.findMany({ 
    select: { email: true, id: true, name: true }, 
    take: 10 
  });
  console.log("Existing users:", JSON.stringify(users, null, 2));
  
  // Check if info@reservatior.com exists
  const existing = users.find(u => u.email === "info@reservatior.com");
  if (existing) {
    console.log("User already exists:", existing);
    
    // Check account
    const account = await prisma.account.findFirst({
      where: { userId: existing.id, providerId: "credentials" }
    });
    console.log("Account:", account ? "Found" : "Not found (no credentials account)");
  } else {
    console.log("User info@reservatior.com NOT found in local DB.");
    console.log("Creating user...");
    
    const hash = await Bun.password.hash("Parola341", { algorithm: "bcrypt", cost: 10 });
    
    const user = await prisma.user.create({
      data: {
        email: "info@reservatior.com",
        name: "Admin",
        emailVerified: true,
        role: "OWNER",
        accounts: {
          create: {
            providerId: "credentials",
            accountId: "info@reservatior.com",
            accessToken: hash,
          }
        }
      }
    });
    console.log("✅ User created:", user.id);
  }
  
  await prisma.$disconnect();
}

main().catch(e => { console.error(e); process.exit(1); });
