/**
 * Bulk Database Push — pushes the universal master schema to ALL country databases
 * 
 * Uses the master schema.prisma (which contains ALL country-specific models combined)
 * for every database. Country-guard extensions handle runtime enforcement at the app level.
 */
import { execSync } from 'child_process';
import fs from 'fs';

const envContent = fs.readFileSync('.env', 'utf8');
const countries = [
  'US', 'UK', 'TR', 'DE', 'FR', 'ES', 'IT', 'NL', 
  'CA', 'MX', 'BR', 'AR', 'AU', 'NZ', 'JP', 'KR', 
  'CN', 'IN', 'SG', 'MY', 'TH', 'AE', 'SA'
];

console.log(`🚀 Starting Bulk Database Push for ${countries.length} countries (using universal master schema)...`);

for (const country of countries) {
  const envVar = `DATABASE_URL_${country}`;
  const match = envContent.match(new RegExp(`${envVar}="(.*?)"`));
  
  if (match && match[1]) {
    const dbUrl = match[1];
    console.log(`📦 Pushing universal schema to ${country}...`);
    try {
      execSync(`DATABASE_URL="${dbUrl}" bun x prisma db push --schema prisma/schema.prisma --accept-data-loss --skip-generate`, {
        stdio: 'inherit'
      });
      console.log(`✅ ${country} updated successfully.`);
    } catch (e) {
      console.error(`❌ ${country} failed to update. Make sure the database exists.`);
    }
  } else {
    console.error(`⚠️ No URL found for ${country} in .env`);
  }
}

console.log('🏁 Bulk Push Completed.');
