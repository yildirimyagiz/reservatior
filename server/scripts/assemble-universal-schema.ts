import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join } from 'path';

/**
 * BIG BRAIN SCRIPT: Assembles the Universal Master Super-Schema.
 * Combines all country-specific fields and models into ONE typesafe Master Schema.
 */

const PRISMA_DIR = './prisma';
const MASTER_FILE = join(PRISMA_DIR, 'schema.prisma');
const METADATA_FILE = join(PRISMA_DIR, 'metadata.json');

interface Metadata {
  models: Record<string, {
    fields: Record<string, string[]>; // FieldName -> Country[]
  }>;
  enums: Record<string, {
    values: Record<string, string[]>; // ValueName -> Country[]
  }>;
}

interface SchemaBlock {
  type: string;
  name: string;
  body: string;
}

const metadata: Metadata = {
  models: {},
  enums: {}
};

// Count braces in content, skipping comments (// and /* */)
function findMatchingBrace(text: string, start: number): number {
  let depth = 1;
  let inLineComment = false;
  let inBlockComment = false;
  let pos = start;
  while (depth > 0 && pos < text.length) {
    if (!inLineComment && !inBlockComment && text[pos] === '/' && text[pos + 1] === '/') {
      inLineComment = true;
    } else if (!inLineComment && !inBlockComment && text[pos] === '/' && text[pos + 1] === '*') {
      inBlockComment = true;
    } else if (inLineComment && text[pos] === '\n') {
      inLineComment = false;
    } else if (inBlockComment && text[pos] === '*' && text[pos + 1] === '/') {
      inBlockComment = false;
      pos += 2;
      continue;
    } else if (!inLineComment && !inBlockComment) {
      if (text[pos] === '{') depth++;
      else if (text[pos] === '}') depth--;
    }
    pos++;
  }
  return pos;
}

// Helper to extract blocks (model, enum)
function extractBlocks(content: string, countryCode: string = 'MASTER') {
  const blocks: Record<string, SchemaBlock> = {};

  function extract(pattern: RegExp, type: string, nameExtractor: (m: RegExpExecArray) => string) {
    const re = new RegExp(pattern.source, 'g');
    let match;
    while ((match = re.exec(content)) !== null) {
      const blockName = nameExtractor(match);
      const startIdx = match.index + match[0].length;
      const endIdx = findMatchingBrace(content, startIdx);
      const body = content.slice(startIdx, endIdx - 1);

      blocks[`${type}_${blockName}`] = { type, name: blockName, body };

      if (type === 'model') {
        if (!metadata.models[blockName]) metadata.models[blockName] = { fields: {} };
        const fieldRegex = /^\s+([a-zA-Z0-9_]+)\s+(.*)$/gm;
        let fieldMatch;
        while ((fieldMatch = fieldRegex.exec(body)) !== null) {
          const fieldName = fieldMatch[1];
          if (!metadata.models[blockName].fields[fieldName]) metadata.models[blockName].fields[fieldName] = [];
          if (!metadata.models[blockName].fields[fieldName].includes(countryCode)) {
            metadata.models[blockName].fields[fieldName].push(countryCode);
          }
        }
      } else if (type === 'enum') {
        if (!metadata.enums[blockName]) metadata.enums[blockName] = { values: {} };
        const valueRegex = /^\s+([a-zA-Z0-9_]+)/gm;
        let valueMatch;
        while ((valueMatch = valueRegex.exec(body)) !== null) {
          const valueName = valueMatch[1];
          if (!metadata.enums[blockName].values[valueName]) metadata.enums[blockName].values[valueName] = [];
          if (!metadata.enums[blockName].values[valueName].includes(countryCode)) {
            metadata.enums[blockName].values[valueName].push(countryCode);
          }
        }
      }
    }
  }

  extract(/model\s+([a-zA-Z0-9_]+)\s+{/, 'model', (m) => m[1]);
  extract(/enum\s+([a-zA-Z0-9_]+)\s+{/, 'enum', (m) => m[1]);

  return blocks;
}

function mergeModels(masterBlocks: Record<string, SchemaBlock>, countryBlocks: Record<string, SchemaBlock>) {
  Object.values(countryBlocks).forEach((block) => {
    const key = `${block.type}_${block.name}`;
    
    if (!masterBlocks[key]) {
      masterBlocks[key] = block;
    } else if (block.type === 'model') {
      const existingBody = masterBlocks[key].body;
      const countryBody = block.body;

      const fieldRegex = /^\s+([a-zA-Z0-9_]+)\s+(.*)$/gm;
      let fieldMatch;
      while ((fieldMatch = fieldRegex.exec(countryBody)) !== null) {
        const fieldName = fieldMatch[1];
        const fieldDef = fieldMatch[2];

        // Skip prisma attributes like @@index or @@unique when merging fields
        if (fieldName.startsWith('@')) continue;

        if (!existingBody.includes(` ${fieldName} `) && !existingBody.includes(`\n  ${fieldName} `)) {
          masterBlocks[key].body += `\n  ${fieldName}  ${fieldDef} // Managed field`;
        }
      }
    }
  });
}

async function main() {
  console.log('👷 Assembling Universal Master Super-Schema & Metadata...');
  
  const files = readdirSync(PRISMA_DIR)
    .filter((f: string) => f.startsWith('schema_') && f.endsWith('.prisma'));

  // First pass: extract existing Master
  const masterContent = readFileSync(MASTER_FILE, 'utf8');
  const masterBlocks = extractBlocks(masterContent, 'BASE');

  // Second pass: merge countries and collect metadata
  files.forEach((file: string) => {
    const countryCode = file.split('_')[1].split('.')[0].toUpperCase();
    console.log(`📦 Merging ${countryCode} (${file})...`);
    const countryContent = readFileSync(join(PRISMA_DIR, file), 'utf8');
    const countryBlocks = extractBlocks(countryContent, countryCode);
    mergeModels(masterBlocks, countryBlocks);
  });

  // Assemble the Master Schema
  let newMasterContent = `// 🌍 UNIVERSAL MASTER SUPER-SCHEMA (AUTO-ASSEMBLED)
generator client {
  provider = "prisma-client-js"
}

generator prismabox {
  provider                    = "prismabox"
  output                      = "../generated/prismabox"
  inputModel                  = "true"
  typeboxImportDependencyName = "elysia"
  typeboxImportVariableName   = "t"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

`;

  console.log(`📊 Master blocks count: ${Object.keys(masterBlocks).length}`);
  const blockCounts: Record<string, number> = {};
  Object.values(masterBlocks).forEach((block) => {
    newMasterContent += `${block.type} ${block.name} {\n${block.body}\n}\n\n`;
    const key = `${block.type}_${block.name}`;
    blockCounts[key] = (blockCounts[key] || 0) + 1;
  });
  const dupes = Object.entries(blockCounts).filter(([, c]) => c > 1);
  if (dupes.length > 0) {
    console.log(`⚠️  Warning: ${dupes.length} blocks have duplicates:`);
    dupes.slice(0, 10).forEach(([name, count]) => console.log(`  ${name}: ${count}x`));
  }
  if (Object.keys(blockCounts).length !== Object.keys(masterBlocks).length) {
    console.log(`⚠️  MISMATCH: blockCounts has ${Object.keys(blockCounts).length} keys vs masterBlocks ${Object.keys(masterBlocks).length} keys`);
  }

  const blockStartCount = (newMasterContent.match(/^(model|enum) /gm) || []).length;
  console.log(`📊 Blocks in output string: ${blockStartCount}`);
  writeFileSync(MASTER_FILE, newMasterContent);
  writeFileSync(METADATA_FILE, JSON.stringify(metadata, null, 2));
  
  // Generate optimized country rules for the Prisma Extension
  const countryRules: any = { models: {} };
  for (const [modelName, modelData] of Object.entries(metadata.models)) {
    const restrictedFields: Record<string, string[]> = {};
    for (const [fieldName, countries] of Object.entries(modelData.fields)) {
      if (!countries.includes('BASE')) {
        restrictedFields[fieldName] = countries;
      }
    }
    if (Object.keys(restrictedFields).length > 0) {
      countryRules.models[modelName] = restrictedFields;
    }
  }
  writeFileSync(join(PRISMA_DIR, 'country-rules.json'), JSON.stringify(countryRules, null, 2));

  console.log('🎉 Universal Master Super-Schema successfully assembled.');
  console.log(`📊 Metadata generated: ${Object.keys(metadata.models).length} models tracked.`);
  console.log(`🛡️ Generated optimized country rules for Runtime Extension.`);
}

main().catch(console.error);
