#!/usr/bin/env bun
/**
 * TR Schema Sync Script
 * Ana schema.prisma'dan eksik model ve enum'ları schema_tr.prisma'ya ekler.
 * TR'ye özgü mevcut alanları korur, sadece eksikleri tamamlar.
 */

import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

const PRISMA_DIR = join(__dirname, '../prisma');
const MAIN_SCHEMA = join(PRISMA_DIR, 'schema.prisma');
const TR_SCHEMA = join(PRISMA_DIR, 'schema_tr.prisma');

interface Block {
  type: 'model' | 'enum';
  name: string;
  fullText: string;
  body: string;
}

function extractBlocks(content: string): Block[] {
  const blocks: Block[] = [];
  
  // Match model and enum blocks
  const blockRegex = /(model|enum)\s+(\w+)\s+\{([\s\S]*?)\}/g;
  let match;
  
  while ((match = blockRegex.exec(content)) !== null) {
    blocks.push({
      type: match[1] as 'model' | 'enum',
      name: match[2],
      fullText: match[0],
      body: match[3]
    });
  }
  
  return blocks;
}

function extractFieldNames(body: string): Set<string> {
  const fields = new Set<string>();
  const lines = body.split('\n');
  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('//') || trimmed.startsWith('@@')) continue;
    const fieldName = trimmed.split(/\s+/)[0];
    if (fieldName && !fieldName.startsWith('@')) {
      fields.add(fieldName);
    }
  }
  return fields;
}

function extractEnumValues(body: string): Set<string> {
  const values = new Set<string>();
  const lines = body.split('\n');
  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith('//')) continue;
    const valueName = trimmed.split(/\s+/)[0];
    if (valueName) {
      values.add(valueName);
    }
  }
  return values;
}

async function main() {
  console.log('🔄 TR Schema Sync başlatılıyor...');
  
  const mainContent = readFileSync(MAIN_SCHEMA, 'utf8');
  const trContent = readFileSync(TR_SCHEMA, 'utf8');
  
  const mainBlocks = extractBlocks(mainContent);
  const trBlocks = extractBlocks(trContent);
  
  const trModelNames = new Set(trBlocks.filter(b => b.type === 'model').map(b => b.name));
  const trEnumNames = new Set(trBlocks.filter(b => b.type === 'enum').map(b => b.name));
  const trBlockMap = new Map(trBlocks.map(b => [`${b.type}_${b.name}`, b]));
  
  let addedModels = 0;
  let addedEnums = 0;
  let updatedModels = 0;
  let updatedEnums = 0;
  
  const newBlocks: string[] = [];
  const fieldUpdates: { modelName: string; newFields: string[] }[] = [];
  const enumUpdates: { enumName: string; newValues: string[] }[] = [];
  
  for (const mainBlock of mainBlocks) {
    if (mainBlock.type === 'model') {
      if (!trModelNames.has(mainBlock.name)) {
        // Model tamamen eksik - ekle
        // "Managed field" yorumlarını temizle (diğer ülkelere ait)
        let cleanBody = mainBlock.body;
        // Keep managed fields but remove the comment marker for TR
        newBlocks.push(mainBlock.fullText);
        addedModels++;
      } else {
        // Model var ama alanları eksik olabilir
        const trBlock = trBlockMap.get(`model_${mainBlock.name}`)!;
        const mainFields = extractFieldNames(mainBlock.body);
        const trFields = extractFieldNames(trBlock.body);
        
        const missingFields: string[] = [];
        const mainLines = mainBlock.body.split('\n');
        
        for (const line of mainLines) {
          const trimmed = line.trim();
          if (!trimmed || trimmed.startsWith('//') || trimmed.startsWith('@@')) continue;
          const fieldName = trimmed.split(/\s+/)[0];
          if (fieldName && !fieldName.startsWith('@') && !trFields.has(fieldName)) {
            missingFields.push(`  ${trimmed}`);
          }
        }
        
        if (missingFields.length > 0) {
          fieldUpdates.push({ modelName: mainBlock.name, newFields: missingFields });
          updatedModels++;
        }
      }
    } else if (mainBlock.type === 'enum') {
      if (!trEnumNames.has(mainBlock.name)) {
        // Enum tamamen eksik - ekle
        newBlocks.push(mainBlock.fullText);
        addedEnums++;
      } else {
        // Enum var ama değerleri eksik olabilir
        const trBlock = trBlockMap.get(`enum_${mainBlock.name}`)!;
        const mainValues = extractEnumValues(mainBlock.body);
        const trValues = extractEnumValues(trBlock.body);
        
        const missingValues: string[] = [];
        const mainLines = mainBlock.body.split('\n');
        
        for (const line of mainLines) {
          const trimmed = line.trim();
          if (!trimmed || trimmed.startsWith('//')) continue;
          const valueName = trimmed.split(/\s+/)[0];
          if (valueName && !trValues.has(valueName)) {
            missingValues.push(`  ${trimmed}`);
          }
        }
        
        if (missingValues.length > 0) {
          enumUpdates.push({ enumName: mainBlock.name, newValues: missingValues });
          updatedEnums++;
        }
      }
    }
  }
  
  // Apply updates to existing TR schema
  let updatedTrContent = trContent;
  
  // Update existing models with missing fields
  for (const update of fieldUpdates) {
    const modelRegex = new RegExp(`(model\\s+${update.modelName}\\s+\\{[\\s\\S]*?)(\\n\\s*@@|\\n\\})`, 'm');
    const match = modelRegex.exec(updatedTrContent);
    if (match) {
      const insertPoint = match.index + match[1].length;
      const newFieldsStr = '\n' + update.newFields.join('\n');
      updatedTrContent = updatedTrContent.slice(0, insertPoint) + newFieldsStr + updatedTrContent.slice(insertPoint);
      console.log(`  📝 ${update.modelName}: +${update.newFields.length} alan eklendi`);
    }
  }
  
  // Update existing enums with missing values
  for (const update of enumUpdates) {
    const enumRegex = new RegExp(`(enum\\s+${update.enumName}\\s+\\{[\\s\\S]*?)(\\n\\})`, 'm');
    const match = enumRegex.exec(updatedTrContent);
    if (match) {
      const insertPoint = match.index + match[1].length;
      const newValuesStr = '\n' + update.newValues.join('\n');
      updatedTrContent = updatedTrContent.slice(0, insertPoint) + newValuesStr + updatedTrContent.slice(insertPoint);
      console.log(`  📝 ${update.enumName}: +${update.newValues.length} değer eklendi`);
    }
  }
  
  // Append completely new blocks at the end
  if (newBlocks.length > 0) {
    updatedTrContent += '\n\n// ========================================\n';
    updatedTrContent += '// Eksik model ve enum\'lar (sync from main schema)\n';
    updatedTrContent += '// ========================================\n\n';
    updatedTrContent += newBlocks.join('\n\n');
    updatedTrContent += '\n';
  }
  
  writeFileSync(TR_SCHEMA, updatedTrContent);
  
  console.log('\n🎉 TR Schema Sync tamamlandı!');
  console.log(`   ✅ ${addedModels} yeni model eklendi`);
  console.log(`   ✅ ${addedEnums} yeni enum eklendi`);
  console.log(`   📝 ${updatedModels} mevcut modele eksik alanlar eklendi`);
  console.log(`   📝 ${updatedEnums} mevcut enum'a eksik değerler eklendi`);
  
  // Verify
  const finalContent = readFileSync(TR_SCHEMA, 'utf8');
  const finalBlocks = extractBlocks(finalContent);
  const finalModels = finalBlocks.filter(b => b.type === 'model').length;
  const finalEnums = finalBlocks.filter(b => b.type === 'enum').length;
  const finalLines = finalContent.split('\n').length;
  
  console.log(`\n📊 Final TR Schema istatistikleri:`);
  console.log(`   Satır: ${finalLines}`);
  console.log(`   Model: ${finalModels}`);
  console.log(`   Enum: ${finalEnums}`);
}

main().catch(console.error);
