#!/usr/bin/env bun

import { readFileSync, writeFileSync } from 'fs'
import { execSync } from 'child_process'

const SEED_FILE = './prisma/seed.ts'
const NUM_RECORDS = 3

// Get Prisma client info
function getPrismaClientInfo() {
  try {
    const result = execSync('npx prisma db pull --print', { encoding: 'utf-8' })
    return result
  } catch (error) {
    console.log('Could not get Prisma info, using fallback method')
    return null
  }
}

// Read schema and extract models with their fields
function extractModelsFromSchema() {
  const schemaContent = readFileSync('./prisma/schema.prisma', 'utf-8')
  
  // Extract models with their fields
  const modelRegex = /model\s+(\w+)\s*\{([^}]+)\}/gs
  const models = []
  let match
  
  while ((match = modelRegex.exec(schemaContent)) !== null) {
    const modelName = match[1]
    const modelBody = match[2]
    
    // Extract fields from model body
    const fieldLines = modelBody.split('\n')
      .map(line => line.trim())
      .filter(line => line && !line.startsWith('//') && !line.startsWith('@'))
      .map(line => line.split(' ')[0])
      .filter(field => field && field !== '}')
    
    models.push({
      name: modelName,
      fields: fieldLines
    })
  }
  
  return models
}

// Generate safe seed data based on field types
function generateSeedData(modelName: string, fields: string[]) {
  const data: any = {}
  
  // Common mappings based on field names
  const fieldMappings: Record<string, any> = {
    // ID fields
    id: 'faker.string.uuid()',
    
    // Foreign key fields
    orgId: 'faker.helpers.arrayElement(orgs).id',
    userId: 'faker.helpers.arrayElement(users).id',
    propertyId: 'faker.helpers.arrayElement(properties).id',
    agentId: 'faker.helpers.arrayElement(agents).id',
    listingId: 'faker.helpers.arrayElement(listings).id',
    dealId: 'faker.helpers.arrayElement(deals).id',
    contractId: 'faker.helpers.arrayElement(contracts).id',
    contactId: 'faker.helpers.arrayElement(contacts).id',
    
    // String fields
    name: 'faker.lorem.words(2)',
    title: 'faker.lorem.words(3)',
    description: 'faker.lorem.sentence()',
    email: 'faker.internet.email()',
    phone: 'faker.phone.number()',
    address: 'faker.location.streetAddress()',
    city: 'faker.location.city()',
    state: 'faker.location.state()',
    country: 'faker.location.country()',
    zip: 'faker.location.zipCode()',
    url: 'faker.internet.url()',
    website: 'faker.internet.url()',
    
    // Number fields
    amount: 'faker.number.float({ min: 100, max: 10000, fractionDigits: 2 })',
    price: 'faker.number.float({ min: 100000, max: 1000000, fractionDigits: 2 })',
    quantity: 'faker.number.int({ min: 1, max: 100 })',
    value: 'faker.number.int({ min: 1, max: 1000 })',
    score: 'faker.number.float({ min: 0, max: 100, fractionDigits: 1 })',
    percentage: 'faker.number.float({ min: 0, max: 100, fractionDigits: 2 })',
    
    // Boolean fields
    isActive: 'faker.datatype.boolean()',
    isPublic: 'faker.datatype.boolean()',
    isVerified: 'faker.datatype.boolean()',
    isDeleted: 'false',
    enabled: 'faker.datatype.boolean()',
    
    // Date fields
    createdAt: 'faker.date.past()',
    updatedAt: 'new Date()',
    expiresAt: 'faker.date.future()',
    startDate: 'faker.date.past()',
    endDate: 'faker.date.future()',
    scheduledAt: 'faker.date.future()',
    completedAt: 'faker.datatype.boolean() ? faker.date.recent() : null',
    
    // Status fields - use generic values
    status: `'ACTIVE'`,
    type: `'STANDARD'`,
    category: `'GENERAL'`,
    priority: `'NORMAL'`,
    level: `'BASIC'`,
  }
  
  // Add fields based on patterns
  fields.forEach(field => {
    if (field === 'id') return // Skip primary key
    if (field.endsWith('Id')) {
      // Foreign key
      const fieldName = fieldMappings[field]
      if (fieldName) data[field] = fieldName
    } else if (fieldMappings[field]) {
      // Known field
      data[field] = fieldMappings[field]
    } else if (field.toLowerCase().includes('status')) {
      data[field] = `'ACTIVE'`
    } else if (field.toLowerCase().includes('type')) {
      data[field] = `'STANDARD'`
    } else if (field.toLowerCase().includes('name') || field.toLowerCase().includes('title')) {
      data[field] = 'faker.lorem.words(2)'
    } else if (field.toLowerCase().includes('description')) {
      data[field] = 'faker.lorem.sentence()'
    } else if (field.toLowerCase().includes('email')) {
      data[field] = 'faker.internet.email()'
    } else if (field.toLowerCase().includes('phone') || field.toLowerCase().includes('mobile')) {
      data[field] = 'faker.phone.number()'
    } else if (field.toLowerCase().includes('amount') || field.toLowerCase().includes('price') || field.toLowerCase().includes('cost')) {
      data[field] = 'faker.number.float({ min: 100, max: 10000, fractionDigits: 2 })'
    } else if (field.toLowerCase().includes('date') || field.toLowerCase().includes('time')) {
      data[field] = 'faker.date.past()'
    } else if (field.toLowerCase().includes('active') || field.toLowerCase().includes('enabled')) {
      data[field] = 'faker.datatype.boolean()'
    }
  })
  
  return data
}

// Generate seed function for a model
function generateSeedFunction(model: { name: string, fields: string[] }) {
  const lowerModelName = model.name.charAt(0).toLowerCase() + model.name.slice(1)
  const seedData = generateSeedData(model.name, model.fields)
  
  // Convert to code
  const dataCode = Object.entries(seedData)
    .map(([key, value]) => `        ${key}: ${value},`)
    .join('\n')
  
  return `
export async function seed${model.name}() {
  const { faker } = await import("@faker-js/faker");
  
  // Get related entities
  const orgs = await prisma.organization.findMany({ select: { id: true } });
  const users = await prisma.user.findMany({ select: { id: true } });
  const properties = await prisma.property.findMany({ select: { id: true } });
  const agents = await prisma.agent.findMany({ select: { id: true } });
  const listings = await prisma.listing.findMany({ select: { id: true } });
  const deals = await prisma.deal.findMany({ select: { id: true } });
  const contracts = await prisma.contract.findMany({ select: { id: true } });
  const contacts = await prisma.contact.findMany({ select: { id: true } });

  for (let i = 0; i < NUM_RECORDS_PER_MODEL; i++) {
    try {
      await prisma.${lowerModelName}.create({
        data: {
${dataCode}
        },
      });
    } catch (error) {
      console.warn(\`Warning: Could not seed ${lowerModelName}: \${error.message}\`);
    }
  }
  console.log(\`Seeded \${NUM_RECORDS_PER_MODEL} ${lowerModelName}s.\`);
}`
}

// Main generation
const models = extractModelsFromSchema()
console.log(`Found ${models.length} models`)

// Filter out enum-only models and system models
const validModels = models.filter(model => 
  !model.name.includes('Type') && 
  !model.name.includes('Status') && 
  !model.name.includes('Category') &&
  model.fields.length > 2 // Has actual fields
)

console.log(`Valid models: ${validModels.length}`)

// Generate seed functions
const seedFunctions = validModels.map(generateSeedFunction).join('\n\n')

// Generate main function calls
const mainCalls = validModels.map(model => {
  return `  await seed${model.name}();`
}).join('\n')

// Generate complete seed file
const seedContent = `import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

// ─────────────────────────────────────────────
// CONFIGURATION
// ─────────────────────────────────────────────

const NUM_RECORDS_PER_MODEL = ${NUM_RECORDS}

// ─────────────────────────────────────────────
// SMART AUTO-GENERATED SEED FUNCTIONS
// ─────────────────────────────────────────────

${seedFunctions}

// ─────────────────────────────────────────────
// MAIN FUNCTION
// ─────────────────────────────────────────────

async function main() {
  console.log('🌱 Starting smart auto-generated database seed...')
  console.log(\`📊 Seeding \${${validModels.length}} valid models with \${NUM_RECORDS_PER_MODEL} records each\`)
  
  try {
    // Create base entities first
    console.log('Creating base entities...')
    const baseOrg = await prisma.organization.create({
      data: {
        name: 'Demo Organization',
        type: 'REAL_ESTATE',
        status: 'ACTIVE',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
    
    const baseUser = await prisma.user.create({
      data: {
        orgId: baseOrg.id,
        email: 'demo@example.com',
        firstName: 'Demo',
        lastName: 'User',
        status: 'ACTIVE',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });
    
    console.log('Base entities created, starting model seeding...')
    
${mainCalls}
    
    console.log('✅ Smart auto-seed completed successfully!')
    console.log(\`📈 Total records created: \${${validModels.length} * NUM_RECORDS_PER_MODEL + 2}\`)
  } catch (error) {
    console.error('❌ Smart auto-seed failed:', error)
    process.exit(1)
  }
}

main()
  .catch((e) => {
    console.error('❌ Seed failed:', e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
`

// Write the seed file
writeFileSync(SEED_FILE, seedContent)

console.log(`✅ Generated smart seed file with ${validModels.length} valid models`)
console.log(`📁 Seed file saved to: ${SEED_FILE}`)
console.log(`🚀 Run 'npm run db:seed' to test`)
