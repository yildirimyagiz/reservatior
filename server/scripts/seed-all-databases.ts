import { execSync } from "child_process";
import { config } from "dotenv";
import { join } from "path";

// Load .env file
config({ path: join(process.cwd(), ".env") });

async function run() {
  console.log("🚀 ==================================================");
  console.log("🏁 --- MULTI-REGION DATABASE SEEDING ENGINE ---");
  console.log("🚀 ==================================================\n");

  const envKeys = Object.keys(process.env).filter(
    (k) => k.startsWith("DATABASE_URL_") && k !== "DATABASE_URL_BASE"
  );

  console.log(`Found ${envKeys.length} country databases in environment.\n`);

  for (const envKey of envKeys) {
    const countryCode = envKey.replace("DATABASE_URL_", "");
    const dbUrl = process.env[envKey];

    if (!dbUrl) {
      console.warn(`⚠️ Skipping ${countryCode}: URL is empty.`);
      continue;
    }

    console.log(`\n📦 Seeding database for country: ${countryCode}`);
    console.log(`🔗 URL: ${dbUrl}`);

    try {
      // 1. Sync the schema using prisma db push. We use --force-reset to cleanly clear any schema conflicts.
      console.log(`   Syncing database schema (force-reset)...`);
      execSync("npx prisma db push --force-reset --accept-data-loss", {
        stdio: "inherit",
        env: { ...process.env, DATABASE_URL: dbUrl }
      });
      console.log(`   ✅ Schema synchronized.`);

      // 2. Run the seed script
      console.log(`   Running seed script...`);
      execSync("bun run prisma/seed.ts", {
        stdio: "inherit",
        env: { ...process.env, DATABASE_URL: dbUrl }
      });
      console.log(`   ✅ Seeding completed successfully for ${countryCode}.`);
    } catch (error: any) {
      console.error(`   ❌ Failed to seed database for ${countryCode}: ${error.message}`);
    }
  }

  console.log("\n🏁 All databases have been processed. 🚀");
}

run().catch(console.error);
