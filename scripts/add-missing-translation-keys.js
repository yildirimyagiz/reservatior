#!/usr/bin/env node

/**
 * Script to add missing translation keys to en.json
 * Usage: node scripts/add-missing-translation-keys.js
 */

const fs = require('fs');
const path = require('path');

// Paths
const enJsonPath = path.join(__dirname, '../client-seo/public/locales/en.json');
const missingKeysPath = '/tmp/missing_translation_keys.txt';

// Read existing en.json
let enJson;
try {
  const enJsonContent = fs.readFileSync(enJsonPath, 'utf8');
  enJson = JSON.parse(enJsonContent);
  console.log(`Loaded ${Object.keys(enJson).length} existing keys from en.json`);
} catch (error) {
  console.error('Error loading en.json:', error);
  process.exit(1);
}

// Read missing keys
let missingKeys;
try {
  const missingKeysContent = fs.readFileSync(missingKeysPath, 'utf8');
  missingKeys = missingKeysContent.split('\n').filter(key => key.trim() !== '');
  console.log(`Found ${missingKeys.length} missing translation keys`);
} catch (error) {
  console.error('Error loading missing keys file:', error);
  process.exit(1);
}

// Add missing keys to en.json
let addedCount = 0;
let skippedCount = 0;

missingKeys.forEach(key => {
  if (!enJson[key]) {
    // Convert key to readable format
    const readableText = key
      .split('_')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase())
      .join(' ');
    
    enJson[key] = readableText;
    addedCount++;
  } else {
    skippedCount++;
  }
});

// Write updated en.json
try {
  fs.writeFileSync(enJsonPath, JSON.stringify(enJson, null, 2));
  console.log(`✅ Added ${addedCount} new translation keys`);
  console.log(`⏭️  Skipped ${skippedCount} already existing keys`);
  console.log(`📝 Total keys in en.json: ${Object.keys(enJson).length}`);
} catch (error) {
  console.error('Error writing en.json:', error);
  process.exit(1);
}
