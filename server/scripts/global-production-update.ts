import { execSync } from 'child_process';

/**
 * 🚀 GLOBAL PRODUCTION SYNC SCRIPT
 * This script automates the full update and seeding of the 23-country database fleet.
 * 
 * Workflow:
 * 1. Assemble Universal Schema (scripts/assemble-universal-schema.ts)
 * 2. Generate Prisma Client
 * 3. Bulk DB Push (scripts/bulk-db-push.ts)
 * 4. Multi-Region Seed (prisma/seed.ts)
 */

function run(command: string, description: string) {
  console.log(`\n\n---------------------------------------------------------`);
  console.log(`📍 STEP: ${description}`);
  // console.log(`💻 ${command}`);
  console.log(`---------------------------------------------------------\n`);
  
  try {
    execSync(command, { stdio: 'inherit' });
  } catch (e) {
    console.error(`❌ FAILED: ${description}`);
    const error = e instanceof Error ? e : new Error(String(e));
    console.error(`Error message: ${error.message}`);
    process.exit(1);
  }
}

async function main() {
  const start = Date.now();
  console.log(`🌎 INITIALIZING GLOBAL PRODUCTION SYNC 🌍`);
  console.log(`Started at: ${new Date().toISOString()}\n`);

  // 1. ASSEMBLE
  // Note: assemble-universal-schema.ts merges everything into prisma/schema.prisma
  run(`bun run scripts/assemble-universal-schema.ts`, 'Assembling Universal Master Schema');

  // 2. GENERATE
  run(`bun x prisma generate`, 'Generating Prisma Client');

  // 3. BULK DB PUSH
  run(`bun run scripts/bulk-db-push.ts`, 'Updating Schema to 23 Databases');

  // 4. GLOBAL SEED
  // seed.ts now iterates through all available regions if SEED_COUNTRY is not set.
  run(`bun run prisma/seed.ts`, 'Seeding 23 Regional Databases');

  const duration = ((Date.now() - start) / 1000 / 60).toFixed(2);
  console.log(`\n\n✅ GLOBAL SYNC COMPLETED SUCCESSFULLY in ${duration} minutes.`);
  console.log(`🏁 All 23 regions are now updated and seeded.`);
}

main().catch(console.error);
