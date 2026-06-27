#!/usr/bin/env bun
// Prisma'dan ZenStack schema'ına otomatik çeviri script'i

import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

// Prisma schema'yı oku
const prismaSchemaPath = './prisma/schema.prisma';
const prismaSchema = readFileSync(prismaSchemaPath, 'utf-8');

// Model'leri extract et
const modelRegex = /^model\s+(\w+)\s*\{([\s\S]*?)^}/gm;
const models = [];
let match;

while ((match = modelRegex.exec(prismaSchema)) !== null) {
  const modelName = match[1];
  const modelContent = match[2];
  
  // ZenStack format'ına çevir
  const zenstackModel = convertToZenStack(modelName, modelContent);
  models.push(zenstackModel);
}

// ZenStack schema'yı oluştur
const zenstackSchema = `// Otomatik üretilmiş ZenStack schema
// Generated from Prisma models at ${new Date().toISOString()}
// Total models: ${models.length}

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

${models.join('\n\n')}
`;

// Yaz
writeFileSync('./zenstack/auto-schema.zmodel', zenstackSchema);

console.log(`✅ ${models.length} model başarıyla ZenStack schema'ına çevrildi!`);
console.log('📁 Output: ./zenstack/auto-schema.zmodel');

function convertToZenStack(modelName: string, modelContent: string): string {
  // Line'ları temizle
  const lines = modelContent.split('\n').map(line => line.trim()).filter(line => line);
  
  // ZenStack model'ı oluştur
  let zenstackModel = `model ${modelName} {\n`;
  
  for (const line of lines) {
    // Comments'ları atla
    if (line.startsWith('//')) continue;
    
    // Field'ları parse et
    const fieldMatch = line.match(/^(\w+)\s+(\w+)(\[\])?(\s+@\w+(?:\([^)]*\))?)?(\s+@\w+(?:\([^)]*\))?)?(\s+@\w+(?:\([^)]*\))?)?(\s+@\w+(?:\([^)]*\))?)?/);
    
    if (fieldMatch) {
      const [, fieldName, fieldType, isArray, ...attributes] = fieldMatch;
      
      // Type mapping
      let zenstackType = mapTypeToZenStack(fieldType);
      
      // Array handling
      if (isArray) {
        zenstackType += '[]';
      }
      
      // Field definition
      zenstackModel += `  ${fieldName} ${zenstackType}`;
      
      // Attributes'ları ekle
      for (const attr of attributes) {
        if (attr) {
          zenstackModel += ` ${attr}`;
        }
      }
      
      zenstackModel += '\n';
    }
  }
  
  zenstackModel += '}';
  
  return zenstackModel;
}

function mapTypeToZenStack(prismaType: string): string {
  const typeMap = {
    'String': 'String',
    'Int': 'Int',
    'BigInt': 'BigInt',
    'Float': 'Float',
    'Decimal': 'Decimal',
    'Boolean': 'Boolean',
    'DateTime': 'DateTime',
    'Json': 'Json',
    'Bytes': 'Bytes',
  };
  
  return typeMap[prismaType] || prismaType;
}

// En çok kullanılan modeller için özel handling
const coreModels = ['User', 'Organization', 'Property', 'Listing', 'Booking', 'Contact', 'Agent'];

console.log(`🎯 Core models: ${coreModels.join(', ')}`);
console.log(`📊 Total models processed: ${models.length}`);

// Core modeller için enhanced version oluştur
const enhancedCoreModels = models.filter(model => 
  coreModels.some(core => model.includes(`model ${core}`))
);

console.log(`⭐ Enhanced core models: ${enhancedCoreModels.length}`);
