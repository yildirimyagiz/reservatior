import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { join } from 'path';

const SERVER_RULES_PATH = join(process.cwd(), '../server/prisma/country-rules.json');
const CLIENT_HOOK_DIR = join(process.cwd(), 'src/lib/hooks');
const CLIENT_RULES_PATH = join(CLIENT_HOOK_DIR, 'country-rules.json');

console.log('🔄 Syncing country rules from backend...');

try {
  if (!existsSync(SERVER_RULES_PATH)) {
    console.error('❌ Server country-rules.json not found! Run db:generate on server first.');
    process.exit(1);
  }

  const rawData = readFileSync(SERVER_RULES_PATH, 'utf-8');
  const rules = JSON.parse(rawData);

  if (!existsSync(CLIENT_HOOK_DIR)) {
    mkdirSync(CLIENT_HOOK_DIR, { recursive: true });
  }

  writeFileSync(CLIENT_RULES_PATH, JSON.stringify(rules, null, 2));
  console.log(`✅ Successfully synced country rules to ${CLIENT_RULES_PATH}`);
} catch (error) {
  console.error('❌ Failed to sync country rules:', error);
  process.exit(1);
}
