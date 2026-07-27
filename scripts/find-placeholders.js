#!/usr/bin/env node

/**
 * Script to find all placeholder patterns in the codebase
 * Usage: node scripts/find-placeholders.js
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const searchDir = path.join(__dirname, '../client-seo/src/app/[locale]');

console.log('🔍 Searching for placeholder patterns...\n');

const patterns = [
  'will be available',
  'Coming Soon',
  'will be rendered here',
  'TODO',
  'placeholder',
  'Not implemented',
  'under construction'
];

const results = {};

patterns.forEach(pattern => {
  try {
    const cmd = `grep -r "${pattern}" "${searchDir}" --include="*.tsx" --include="*.ts" -l`;
    const output = execSync(cmd, { encoding: 'utf8' });
    const files = output.trim().split('\n').filter(f => f);
    if (files.length > 0) {
      results[pattern] = files;
    }
  } catch (error) {
    // No matches found for this pattern
  }
});

console.log('📊 Results:\n');

Object.entries(results).forEach(([pattern, files]) => {
  console.log(`\n🔹 Pattern: "${pattern}"`);
  console.log(`   Found in ${files.length} file(s):`);
  files.forEach(file => {
    const relativePath = file.replace(searchDir, '');
    console.log(`   - ${relativePath}`);
  });
});

const totalFiles = new Set(Object.values(results).flat()).size;
console.log(`\n\n📈 Summary: ${totalFiles} unique file(s) with placeholders`);
