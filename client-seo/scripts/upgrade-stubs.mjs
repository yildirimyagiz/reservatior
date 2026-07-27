#!/usr/bin/env node

/**
 * Upgrade Stub Pages & Generate Translation Keys
 * 
 * This script finds all placeholder/stub pages in the codebase,
 * upgrades them to use `react-i18next` for translations,
 * and adds the corresponding keys to the locale files.
 * 
 * Usage: node scripts/upgrade-stubs.mjs
 */

import { readFileSync, writeFileSync, readdirSync, statSync } from 'fs';
import { join, basename, dirname } from 'path';

const APP_DIR = join(process.cwd(), 'src/app');
const LOCALES_DIR = join(process.cwd(), 'public/locales');

// Common placeholder texts to look for
const PLACEHOLDER_PHRASES = [
  'will be available here',
  'coming soon',
  'Placeholder',
  'is under construction',
  'management will be available'
];

function findStubFiles(dir, fileList = []) {
  const files = readdirSync(dir);
  for (const file of files) {
    const filePath = join(dir, file);
    if (statSync(filePath).isDirectory()) {
      findStubFiles(filePath, fileList);
    } else if (filePath.endsWith('.tsx')) {
      const content = readFileSync(filePath, 'utf-8');
      if (PLACEHOLDER_PHRASES.some(phrase => content.toLowerCase().includes(phrase.toLowerCase()))) {
        fileList.push(filePath);
      }
    }
  }
  return fileList;
}

function toSnakeCase(str) {
  return str.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`).replace(/^_/, '').replace(/[\s-]/g, '_');
}

function processStubFiles() {
  const stubFiles = findStubFiles(APP_DIR);
  console.log(`🔍 Found ${stubFiles.length} placeholder/stub files.`);

  const newTranslations = {};

  for (const filePath of stubFiles) {
    let content = readFileSync(filePath, 'utf-8');
    
    // Attempt to extract title and description from simple stubs
    // Matches: <h1 className="...">Title</h1>
    const titleMatch = content.match(/<h[1-3][^>]*>([^<]+)<\/h[1-3]>/);
    // Matches: <p className="...">Description</p>
    const descMatch = content.match(/<p[^>]*>([^<]+(?:available|soon|under construction|management)[^<]*)<\/p>/i);

    if (titleMatch && descMatch) {
      const titleText = titleMatch[1].trim();
      const descText = descMatch[1].trim();
      
      const componentNameMatch = content.match(/export\s+(?:default\s+)?function\s+([A-Za-z0-9_]+)/);
      const componentName = componentNameMatch ? componentNameMatch[1] : basename(dirname(filePath));
      const baseKey = toSnakeCase(componentName).replace(/_page$/, '').replace(/_dashboard$/, '');

      const titleKey = `${baseKey}.title`;
      const descKey = `${baseKey}.description`;

      newTranslations[titleKey] = titleText;
      newTranslations[descKey] = descText;

      // Add import if missing
      if (!content.includes('react-i18next')) {
        // Insert after "use client" if present, otherwise at top
        if (content.includes('"use client"')) {
          content = content.replace(/"use client";\s*/, `"use client";\nimport { useTranslation } from "react-i18next";\n`);
        } else {
          content = `import { useTranslation } from "react-i18next";\n` + content;
        }
      }

      // Add hook inside component if missing
      if (!content.includes('const { t } = useTranslation()')) {
        content = content.replace(/(export\s+(?:default\s+)?function\s+[A-Za-z0-9_]+\s*\([^)]*\)\s*\{)/, `$1\n  const { t } = useTranslation();`);
      }

      // Replace text with t() calls
      content = content.replace(titleMatch[0], titleMatch[0].replace(titleText, `{t("${titleKey}")}`));
      content = content.replace(descMatch[0], descMatch[0].replace(descText, `{t("${descKey}")}`));

      writeFileSync(filePath, content, 'utf-8');
      console.log(`✅ Upgraded: ${filePath.replace(process.cwd(), '')}`);
    } else {
      console.log(`⚠️  Skipped (complex structure): ${filePath.replace(process.cwd(), '')}`);
    }
  }

  return newTranslations;
}

function updateLocales(newTranslations) {
  if (Object.keys(newTranslations).length === 0) {
    console.log('\nNo new translations to add.');
    return;
  }

  const localeFiles = readdirSync(LOCALES_DIR).filter(f => f.endsWith('.json'));
  console.log(`\n📝 Adding ${Object.keys(newTranslations).length} keys to ${localeFiles.length} locales...`);

  for (const file of localeFiles) {
    const filePath = join(LOCALES_DIR, file);
    try {
      const content = JSON.parse(readFileSync(filePath, 'utf-8'));
      let added = 0;
      
      for (const [key, value] of Object.entries(newTranslations)) {
        if (!content[key]) {
          content[key] = value;
          added++;
        }
      }

      if (added > 0) {
        writeFileSync(filePath, JSON.stringify(content, null, 2) + '\n', 'utf-8');
        console.log(`  ✅ ${file}: +${added} keys`);
      }
    } catch (err) {
      console.error(`  ❌ ${file}: ${err.message}`);
    }
  }
}

function main() {
  console.log('🚀 Starting Stub Upgrade Process...\n');
  const extractedTranslations = processStubFiles();
  updateLocales(extractedTranslations);
  console.log('\n✨ Done! You can review the changes before committing.');
}

main();
