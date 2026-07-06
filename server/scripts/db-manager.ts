import { execSync } from 'child_process';
import { config } from 'dotenv';
import { join } from 'path';

// Load .env file
config({ path: join(process.cwd(), '.env') });

const command = process.argv[2]; // 'push' | 'generate' | 'migrate'
const country = process.argv[3]?.toUpperCase(); // 'TR', 'US', 'ALL', etc.

if (!command) {
  console.error('Usage: bun run scripts/db-manager.ts <command> [country]');
  process.exit(1);
}

// Generate doesn't need a specific country database if using the universal schema.
// It just generates the client code based on schema.prisma
if (command === 'generate') {
  console.log('Generating Universal Prisma Client...');
  execSync('npx prisma generate', { stdio: 'inherit' });
  execSync('bun run scripts/assemble-universal-schema.ts', { stdio: 'inherit' });
  process.exit(0);
}

if (!country) {
  console.error('Country code is required for db operations (e.g., TR, US, ALL).');
  process.exit(1);
}

// Function to execute prisma command on a specific country
function executeForCountry(cmd: string, cCode: string) {
  const dbUrlEnvKey = `DATABASE_URL_${cCode}`;
  const dbUrl = process.env[dbUrlEnvKey];

  if (!dbUrl) {
    console.error(`⚠️ Skipping ${cCode}: Environment variable ${dbUrlEnvKey} not found in .env`);
    return false;
  }

  console.log(`📦 Executing prisma ${cmd} on ${cCode} database...`);

  let prismaCmd = '';
  if (cmd === 'push') {
    prismaCmd = 'npx prisma db push --accept-data-loss --skip-generate';
  } else if (cmd === 'migrate') {
    prismaCmd = 'npx prisma migrate dev';
  } else {
    console.error(`Unknown command: ${cmd}`);
    return false;
  }

  try {
    // Execute with the DATABASE_URL overridden for the specific country
    execSync(prismaCmd, { 
      stdio: 'inherit',
      env: { ...process.env, DATABASE_URL: dbUrl }
    });
    console.log(`✅ Successfully executed ${cmd} on ${cCode} database.`);
    return true;
  } catch (error) {
    console.error(`❌ Failed to execute ${cmd} on ${cCode} database.`);
    return false;
  }
}

// Run for ALL or Single
if (country === 'ALL') {
  console.log(`🚀 Starting Bulk Database Operation (${command}) for ALL countries...`);
  const allEnvKeys = Object.keys(process.env).filter(k => k.startsWith('DATABASE_URL_') && k !== 'DATABASE_URL_BASE');
  
  let successCount = 0;
  for (const key of allEnvKeys) {
    const cCode = key.replace('DATABASE_URL_', '');
    const success = executeForCountry(command, cCode);
    if (success) successCount++;
  }
  
  console.log(`\n🏁 Bulk Operation Completed. ${successCount}/${allEnvKeys.length} databases updated successfully.`);
  if (command === 'push' || command === 'migrate') {
    console.log('Running final generator pass...');
    execSync('npx prisma generate', { stdio: 'inherit' });
  }
} else {
  executeForCountry(command, country);
}
