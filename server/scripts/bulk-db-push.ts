import { execSync } from 'child_process';
import fs from 'fs';

const envContent = fs.readFileSync('.env', 'utf8');
const countries = [
  'US', 'UK', 'TR', 'DE', 'FR', 'ES', 'IT', 'NL', 
  'CA', 'MX', 'BR', 'AR', 'AU', 'NZ', 'JP', 'KR', 
  'CN', 'IN', 'SG', 'MY', 'TH', 'AE', 'SA'
];

console.log(`🚀 Starting Bulk Database Push for ${countries.length} countries...`);

for (const country of countries) {
  const envVar = `DATABASE_URL_${country}`;
  const match = envContent.match(new RegExp(`${envVar}="(.*?)"`));
  
  if (match && match[1]) {
    const dbUrl = match[1];
    console.log(`📦 Pushing schema to ${country}...`);
    try {
      execSync(`DATABASE_URL="${dbUrl}" bun x prisma db push --schema prisma/schema_${country.toLowerCase()}.prisma --accept-data-loss --skip-generate`, {
        stdio: 'inherit'
      });
      console.log(`✅ ${country} updateed successfully.`);
    } catch (e) {
      console.error(`❌ ${country} failed to update. Make sure the database exists.`);
    }
  } else {
    console.error(`⚠️ No URL found for ${country} in .env`);
  }
}

console.log('🏁 Bulk Push Completed.');
