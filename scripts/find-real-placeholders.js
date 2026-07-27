#!/usr/bin/env node

/**
 * Script to find real placeholder pages (not just chart placeholders)
 * Usage: node scripts/find-real-placeholders.js
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const searchDir = path.join(__dirname, '../client-seo/src/app/[locale]');

console.log('🔍 Searching for REAL placeholder pages...\n');

// Only search for actual placeholder patterns, not chart placeholders
const patterns = [
  'will be available',
  'Coming Soon',
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
console.log(`\n\n📈 Summary: ${totalFiles} unique file(s) with REAL placeholders`);

// Filter for OS modules only
console.log('\n\n🎯 OS Module Placeholders Only:\n');

const osModules = Object.entries(results).reduce((acc, [pattern, files]) => {
  const osFiles = files.filter(f => f.includes('-os') || f.includes('/agent_os/'));
  if (osFiles.length > 0) {
    acc[pattern] = osFiles;
  }
  return acc;
}, {});

Object.entries(osModules).forEach(([pattern, files]) => {
  console.log(`\n🔹 Pattern: "${pattern}"`);
  console.log(`   Found in ${files.length} OS file(s):`);
  files.forEach(file => {
    const relativePath = file.replace(searchDir, '');
    console.log(`   - ${relativePath}`);
  });
});

const totalOSFiles = new Set(Object.values(osModules).flat()).size;
console.log(`\n\n📈 OS Summary: ${totalOSFiles} unique OS file(s) with placeholders`);
