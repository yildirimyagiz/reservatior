const fs = require('fs');
const path = require('path');

const prismaDir = path.join(__dirname, '../prisma');
const files = fs.readdirSync(prismaDir).filter(f => f.startsWith('schema_') && f.endsWith('.prisma') && f !== 'schema.prisma');

const missingPropertyTypes = ['OFFICE', 'RETAIL', 'COMMERCIAL_SPACE'];
const missingRegions = ["TR", "UAE", "UK", "USA", "RU", "CN", "GLOBAL", "FR", "DE", "SA", "CA", "SG", "ES", "IT", "JP", "KR", "AU", "NZ", "NL", "MX", "BR", "IN", "TH", "MY", "AR"];

let updatedCount = 0;

for (const file of files) {
  const filePath = path.join(prismaDir, file);
  let content = fs.readFileSync(filePath, 'utf-8');
  let changed = false;

  // 1. Fix currency in Property model
  const propCurrencyRegex = /(model Property \{[\s\S]*?)(\bcurrency\s+String\b(?!\?))(.*)/;
  if (propCurrencyRegex.test(content)) {
    content = content.replace(propCurrencyRegex, '$1currency String?$3');
    changed = true;
  }

  // 2. Fix PropertyType enum
  const propTypeRegex = /(enum PropertyType \{[\s\S]*?)(\})/;
  if (propTypeRegex.test(content)) {
    let enumBlock = content.match(propTypeRegex)[1];
    let added = false;
    for (const pt of missingPropertyTypes) {
      if (!enumBlock.includes(pt)) {
        enumBlock += `  ${pt}\n`;
        added = true;
      }
    }
    if (added) {
      content = content.replace(propTypeRegex, enumBlock + '}');
      changed = true;
    }
  }

  // 3. Fix Region enum
  const regionRegex = /(enum Region \{[\s\S]*?)(\})/;
  if (regionRegex.test(content)) {
    let enumBlock = content.match(regionRegex)[1];
    let added = false;
    for (const r of missingRegions) {
      if (!enumBlock.includes(`  ${r}\n`) && !enumBlock.includes(`  ${r}\r`)) {
        enumBlock += `  ${r}\n`;
        added = true;
      }
    }
    if (added) {
      content = content.replace(regionRegex, enumBlock + '}');
      changed = true;
    }
  }

  if (changed) {
    fs.writeFileSync(filePath, content, 'utf-8');
    updatedCount++;
    console.log("Patched Option B fixes for " + file);
  }
}

console.log("\\nDone! Applied Option B backwards compatibility fixes to " + updatedCount + " schema files.");
