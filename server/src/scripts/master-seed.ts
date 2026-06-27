import prismaManager from "../lib/prisma";
import { execSync } from "child_process";
import { config } from "dotenv";
import { join } from "path";

// Load .env file
config({ path: join(process.cwd(), ".env") });

const REGIONS_TO_SEED = ["US", "TR", "UK", "FR", "NL", "DE", "ES", "IT", "AU", "TH"];

async function runMasterSeed() {
  console.log("🌟 ==================================================");
  console.log("🏆 --- RESERVATOR MODULAR MASTER SEED ORCHESTRATOR ---");
  console.log("🌟 ==================================================\n");

  for (const region of REGIONS_TO_SEED) {
    const envKey = `DATABASE_URL_${region}`;
    const dbUrl = process.env[envKey];

    if (!dbUrl) {
      console.warn(`⚠️ Skipping region ${region}: Environment variable ${envKey} not found.`);
      continue;
    }

    console.log(`\n==================================================`);
    console.log(`🚀 Seeding Region [${region}]...`);
    console.log(`==================================================`);

    try {
      // 1. Sync Schema using db push with force-reset to resolve any migrations conflicts
      console.log(`📦 Syncing schema for ${region}...`);
      execSync("npx prisma db push --force-reset --accept-data-loss", {
        stdio: "inherit",
        env: { ...process.env, DATABASE_URL: dbUrl }
      });

      // 2. Execute regional conditional seeding
      if (region === "US") {
        console.log(`🇺🇸 Executing USA specific seed...`);
        execSync("bun run prisma/seed-seattle.ts", {
          stdio: "inherit",
          env: { ...process.env, DATABASE_URL: dbUrl }
        });
      } else if (region === "TR") {
        console.log(`🇹🇷 Executing Turkey specific seed...`);
        execSync("bun run prisma/seed-turkey-full.ts", {
          stdio: "inherit",
          env: { ...process.env, DATABASE_URL: dbUrl }
        });
        
        // Import local Turkey real estate assets (Bomonti Residences etc.) if excel exists
        const rotanaExcel = "/Users/os2026/Downloads/ROTANA-BOMONTİ son.xlsx";
        if (require("fs").existsSync(rotanaExcel)) {
          console.log(`🏢 Ingesting Bomonti Residences by Rotana Excel...`);
          execSync("bun run src/scripts/import-rotana-bomonti.ts", {
            stdio: "inherit",
            env: { ...process.env, DATABASE_URL: dbUrl }
          });
        }
      } else {
        // Generic seed for other countries (creates core users & default configurations)
        console.log(`🇪🇺 Executing Generic Seed for ${region}...`);
        execSync("bun run prisma/seed_test_users.ts", {
          stdio: "inherit",
          env: { ...process.env, DATABASE_URL: dbUrl }
        });
      }

      // 3. Import Airbnb listings as BOOKING type
      console.log(`📥 Ingesting organized Airbnb listings for ${region}...`);
      execSync("bun run src/scripts/import-all-airbnb-booking.ts", {
        stdio: "inherit",
        env: { ...process.env, DATABASE_URL: dbUrl }
      });

      console.log(`✅ Region [${region}] successfully seeded and populated!`);

    } catch (error: any) {
      console.error(`❌ Region [${region}] failed: ${error.message}`);
    }
  }

  console.log("\n🏁 Master Seeding process complete! 🚀");
}

runMasterSeed().catch(console.error);
