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

// Helper to extract blocks (model, enum)
function extractBlocks(content: string, countryCode: string = 'MASTER') {
  const blocks: Record<string, SchemaBlock> = {};
  
  // Model regex
  const modelRegex = /model\s+([a-zA-Z0-9_]+)\s+{([\s\S]*?)}/g;
  let match;
  while ((match = modelRegex.exec(content)) !== null) {
    const modelName = match[1];
    const body = match[2];
    blocks[`model_${modelName}`] = { type: 'model', name: modelName, body };
    
    // Track metadata for models
    if (!metadata.models[modelName]) metadata.models[modelName] = { fields: {} };
    
    const fieldRegex = /^\s+([a-zA-Z0-9_]+)\s+(.*)$/gm;
    let fieldMatch;
    while ((fieldMatch = fieldRegex.exec(body)) !== null) {
      const fieldName = fieldMatch[1];
      if (!metadata.models[modelName].fields[fieldName]) metadata.models[modelName].fields[fieldName] = [];
      if (!metadata.models[modelName].fields[fieldName].includes(countryCode)) {
        metadata.models[modelName].fields[fieldName].push(countryCode);
      }
    }
  }

  // Enum regex
  const enumRegex = /enum\s+([a-zA-Z0-9_]+)\s+{([\s\S]*?)}/g;
  while ((match = enumRegex.exec(content)) !== null) {
    const enumName = match[1];
    const body = match[2];
    blocks[`enum_${enumName}`] = { type: 'enum', name: enumName, body };
    
    // Track metadata for enums
    if (!metadata.enums[enumName]) metadata.enums[enumName] = { values: {} };
    
    const valueRegex = /^\s+([a-zA-Z0-9_]+)/gm;
    let valueMatch;
    while ((valueMatch = valueRegex.exec(body)) !== null) {
      const valueName = valueMatch[1];
      if (!metadata.enums[enumName].values[valueName]) metadata.enums[enumName].values[valueName] = [];
      if (!metadata.enums[enumName].values[valueName].includes(countryCode)) {
        metadata.enums[enumName].values[valueName].push(countryCode);
      }
    }
  }

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

  Object.values(masterBlocks).forEach((block) => {
    newMasterContent += `${block.type} ${block.name} {\n${block.body}\n}\n\n`;
  });

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
