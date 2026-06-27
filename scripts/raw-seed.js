const { Client } = require('pg');
const bcrypt = require('bcryptjs');

const SALT_ROUNDS = 10;

async function hashPassword(password) {
  return bcrypt.hash(password, SALT_ROUNDS);
}

async function main() {
  const connectionString = process.env.DATABASE_URL_US;
  if (!connectionString) {
    console.error("DATABASE_URL_US is required");
    process.exit(1);
  }

  const client = new Client({ connectionString });
  await client.connect();

  const password = "PasswordLess/11";
  const passwordHash = await hashPassword(password);

  const testUsers = [
    { email: "admin@propos.com", name: "Super Admin" },
    { email: "orgadmin.test@propos.com", name: "Org Admin" },
    { email: "admin.test@propos.com", name: "Admin User" },
    { email: "agent.test@propos.com", name: "Agent User" },
    { email: "tenant.test@propos.com", name: "Tenant User" },
    { email: "user.test@propos.com", name: "Regular User" },
    { email: "superadmin.test@propos.com", name: "Super Admin Test" },
  ];

  for (const userData of testUsers) {
    console.log(`Ensuring user: ${userData.email}`);
    
    // UPSERT User
    const userRes = await client.query(
      `INSERT INTO "User" (id, email, name, "updatedAt") 
       VALUES ($1, $2, $3, NOW()) 
       ON CONFLICT (email) DO UPDATE SET name = $3, "updatedAt" = NOW()
       RETURNING id`,
      [`user-${userData.email.split('@')[0]}`, userData.email, userData.name]
    );
    const userId = userRes.rows[0].id;

    // UPSERT Account (Credentials)
    await client.query(
      `INSERT INTO "Account" (id, "userId", type, provider, "providerAccountId", access_token, "updatedAt")
       VALUES ($1, $2, 'CREDENTIALS', 'credentials', $3, $4, NOW())
       ON CONFLICT (provider, "providerAccountId") DO UPDATE SET access_token = $4, "updatedAt" = NOW()`,
      [`acc-${userData.email.split('@')[0]}`, userId, userData.email, passwordHash]
    );
  }

  console.log("Database seeded successfully with pg!");
  await client.end();
}

main().catch(console.error);
