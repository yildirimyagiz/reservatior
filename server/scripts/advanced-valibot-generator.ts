#!/usr/bin/env bun
// Gelişmiş Prisma → Valibot generator
// Bu script schema.prisma dosyasını okuyarak Valibot schema'ları üretir.
// Ayrıca metadata.json'u okuyarak ÜLKELERE ÖZEL (Country-Specific) şemalar da üretir.

import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { join } from 'path';

interface PrismaField {
  name: string;
  type: string;
  kind: 'scalar' | 'object' | 'enum';
  isOptional: boolean;
  hasDefaultValue: boolean;
  isList: boolean;
}

interface PrismaModel {
  name: string;
  fields: PrismaField[];
}

function mapPrismaTypeToValibot(field: PrismaField, enums: string[]): string {
  const { name, type, isOptional, hasDefaultValue } = field;
  const optional = isOptional || hasDefaultValue;
  const prefix = optional ? 'v.optional(' : '';
  const suffix = optional ? ')' : '';
  
  if (name.includes('email')) {
    return `${prefix}v.pipe(v.string(), v.email())${suffix}`;
  }
  
  if (enums.includes(type)) {
    return `${prefix}v.enum_(${type})${suffix}`;
  }
  
  switch (type) {
    case 'String':
      return `${prefix}v.string()${suffix}`;
    case 'Int':
    case 'Float':
    case 'Decimal':
      return `${prefix}v.number()${suffix}`;
    case 'Boolean':
      return `${prefix}v.boolean()${suffix}`;
    case 'DateTime':
      return `${prefix}v.string()${suffix}`;
    case 'Json':
      return `${prefix}v.unknown()${suffix}`;
    default:
      return `${prefix}v.unknown()${suffix}`;
  }
}

// metadata.json'u yükle
let metadata: any = { models: {}, enums: {} };
try {
  metadata = JSON.parse(readFileSync('./prisma/metadata.json', 'utf8'));
} catch (e) {
  console.warn('⚠️ metadata.json bulunamadı. Base schema üretilecek.');
}

function getCountriesForField(modelName: string, fieldName: string): string[] | null {
  if (metadata.models[modelName]?.fields[fieldName]) {
    return metadata.models[modelName].fields[fieldName];
  }
  return null;
}

function getCountriesForEnumValue(enumName: string, valueName: string): string[] | null {
  if (metadata.enums[enumName]?.values[valueName]) {
    return metadata.enums[enumName].values[valueName];
  }
  return null;
}

function generateModelSchema(model: PrismaModel, enums: string[], targetCountry: string): string {
  const { name, fields } = model;
  const modelName = name.charAt(0).toLowerCase() + name.slice(1);
  
  const scalarFields = fields.filter(f => f.kind === 'scalar' || f.kind === 'enum');
  
  // Ülkeye göre filtrele
  const filteredFields = scalarFields.filter(f => {
    const countries = getCountriesForField(name, f.name);
    if (!countries) return true; // Metadata'da yoksa hepsine ekle
    return countries.includes(targetCountry);
  });
  
  const createFields = filteredFields
    .filter(f => !f.hasDefaultValue && !f.isOptional && f.name !== 'id' && f.name !== 'createdAt' && f.name !== 'updatedAt' && f.name !== 'deletedAt')
    .map(f => `  ${f.name}: ${mapPrismaTypeToValibot(f, enums)}`)
    .join(',\n');
  
  const updateFields = filteredFields
    .filter(f => f.name !== 'id' && f.name !== 'createdAt' && f.name !== 'updatedAt' && f.name !== 'deletedAt')
    .map(f => `  ${f.name}: v.optional(${mapPrismaTypeToValibot({ ...f, isOptional: false, hasDefaultValue: false }, enums)})`)
    .join(',\n');
  
  return `// ${name} Schemas (${targetCountry})
export const ${modelName}CreateSchema = v.object({
${createFields || '  // No required fields'}
});

export const ${modelName}UpdateSchema = v.partial(v.object({
${updateFields || '  // No updatable fields'}
}));

export type ${name}Create = v.InferOutput<typeof ${modelName}CreateSchema>;
export type ${name}Update = v.InferOutput<typeof ${modelName}UpdateSchema>;

`;
}

function parseEnums(content: string): { name: string, values: string[] }[] {
  const enums: { name: string, values: string[] }[] = [];
  const enumRegex = /enum\s+(\w+)\s+{([\s\S]*?)}/g;
  let match;

  while ((match = enumRegex.exec(content)) !== null) {
    const enumName = match[1];
    const valuesContent = match[2];
    const values = valuesContent
      .split('\n')
      .map(line => line.trim())
      .filter(line => line && !line.startsWith('//'))
      .map(line => line.split(/\s+/)[0]);
    
    enums.push({ name: enumName, values });
  }
  
  return enums;
}

function parseSchema(content: string, enumNames: string[]): PrismaModel[] {
  const models: PrismaModel[] = [];
  const modelRegex = /model\s+(\w+)\s+{([\s\S]*?)}/g;
  let match;

  while ((match = modelRegex.exec(content)) !== null) {
    const modelName = match[1];
    const fieldsContent = match[2];
    const fields: PrismaField[] = [];
    
    const lines = fieldsContent.split('\n');
    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed || trimmed.startsWith('//') || trimmed.startsWith('@@')) continue;
      
      const parts = trimmed.split(/\s+/);
      if (parts.length < 2) continue;
      
      const name = parts[0];
      let type = parts[1];
      const isOptional = type.endsWith('?');
      const isList = type.endsWith('[]');
      if (isOptional) type = type.slice(0, -1);
      if (isList) type = type.slice(0, -2);
      
      const hasDefaultValue = trimmed.includes('@default');
      const isEnum = enumNames.includes(type);
      const isScalar = ['String', 'Int', 'Float', 'Boolean', 'DateTime', 'Json', 'Decimal', 'BigInt', 'Bytes'].includes(type);
      
      fields.push({
        name,
        type,
        kind: isEnum ? 'enum' : (isScalar ? 'scalar' : 'object'),
        isOptional,
        hasDefaultValue,
        isList
      });
    }
    
    models.push({ name: modelName, fields });
  }
  
  return models;
}

function getAllCountries(): string[] {
  const countrySet = new Set<string>();
  countrySet.add('BASE'); // Her zaman BASE ekle
  
  if (metadata.models) {
    for (const model of Object.values(metadata.models) as any) {
      if (model.fields) {
        for (const countries of Object.values(model.fields) as any) {
          for (const c of (countries as string[])) {
            countrySet.add(c);
          }
        }
      }
    }
  }
  return Array.from(countrySet);
}

// Bir ülke için hangi enum'ların gerekli olduğunu hesapla:
// Ülkeye dahil edilen modellerin kullandığı tüm enum'ları bul.
function getRequiredEnumsForCountry(models: PrismaModel[], enumNames: string[], country: string): Set<string> {
  const requiredEnums = new Set<string>();
  
  for (const model of models) {
    const scalarFields = model.fields.filter(f => f.kind === 'scalar' || f.kind === 'enum');
    
    // Bu model bu ülke için alan içeriyor mu kontrol et
    const filteredFields = scalarFields.filter(f => {
      const countries = getCountriesForField(model.name, f.name);
      if (!countries) return true;
      return countries.includes(country);
    });
    
    // Bu modelin bu ülkede kullandığı enum'ları topla
    for (const field of filteredFields) {
      if (enumNames.includes(field.type)) {
        requiredEnums.add(field.type);
      }
    }
  }
  
  return requiredEnums;
}

async function main() {
  const schemaPath = './prisma/schema.prisma';
  const generatedDir = './src/schemas/generated';
  const sharedTypesDir = join(__dirname, '../../shared/types/src');
  
  console.log('🚀 Loading Prisma schema...');
  const content = readFileSync(schemaPath, 'utf8');
  const enums = parseEnums(content);
  const enumNames = enums.map(e => e.name);
  const models = parseSchema(content, enumNames);
  
  const allCountries = getAllCountries();
  console.log(`✅ Parsed ${models.length} models and ${enums.length} enums.`);
  console.log(`🌍 Found ${allCountries.length} countries to generate schemas for.`);
  
  // Dizinleri oluştur
  mkdirSync(join(generatedDir, 'countries'), { recursive: true });
  mkdirSync(sharedTypesDir, { recursive: true });

  for (const country of allCountries) {
    // Önce bu ülke için hangi enum'lar gerekli hesapla
    const requiredEnums = getRequiredEnumsForCountry(models, enumNames, country);
    
    let output = `// Otomatik üretilmiş Valibot schema'ları (${country})\n// Generated: ${new Date().toISOString()}\n\nimport * as v from 'valibot';\n\n// --- ENUMS ---\n`;

    // Enum'ları ülkeye göre filtrele, ama modellerin bağımlılıklarını da dahil et
    for (const e of enums) {
      const filteredValues = e.values.filter(val => {
        const countries = getCountriesForEnumValue(e.name, val);
        if (!countries) return true;
        return countries.includes(country);
      });
      
      // Eğer enum metadata'ya göre bu ülkede yok AMA bir model tarafından kullanılıyorsa,
      // tüm değerleri dahil et (bağımlılık çözümleme)
      if (filteredValues.length === 0 && requiredEnums.has(e.name)) {
        // Model bu enum'u kullanıyor ama metadata'da ülke yok → tüm değerleri dahil et
        const allValues = e.values;
        if (allValues.length > 0) {
          output += `export enum ${e.name} {\n${allValues.map(v => `  ${v} = "${v}"`).join(',\n')}\n}\n`;
          output += `export const ${e.name}Schema = v.enum_(${e.name});\n\n`;
        }
      } else if (filteredValues.length > 0) {
        output += `export enum ${e.name} {\n${filteredValues.map(v => `  ${v} = "${v}"`).join(',\n')}\n}\n`;
        output += `export const ${e.name}Schema = v.enum_(${e.name});\n\n`;
      }
    }

    output += `// --- MODELS ---\n`;
    for (const model of models) {
      output += generateModelSchema(model, enumNames, country);
    }
    
    // Server için dosyayı yaz
    const isBase = country === 'BASE';
    const serverFilePath = isBase ? join(generatedDir, 'index.ts') : join(generatedDir, 'countries', `${country}.ts`);
    writeFileSync(serverFilePath, output);
    
    // Shared Types için dosyayı yaz
    const sharedFilePath = isBase ? join(sharedTypesDir, 'index.ts') : join(sharedTypesDir, `${country}.ts`);
    writeFileSync(sharedFilePath, output);
  }
  
  console.log(`✅ Generated all country schemas successfully. Check shared/types/src.`);
}

main().catch(console.error);
