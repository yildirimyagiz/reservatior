const fs = require('fs');
const path = require('path');

const schemaContent = fs.readFileSync(path.join(__dirname, 'prisma/schema.prisma'), 'utf8');
const routesDir = path.join(__dirname, 'src/routes');

// Parse schema models
const models = {};
let currentModel = null;
const lines = schemaContent.split('\n');

for (const line of lines) {
  const modelMatch = line.match(/^model\s+(\w+)\s+\{/);
  if (modelMatch) {
    currentModel = modelMatch[1];
    models[currentModel] = { fields: [] };
  } else if (currentModel && line.trim() === '}') {
    currentModel = null;
  } else if (currentModel && line.trim() !== '') {
    const fieldMatch = line.trim().match(/^(\w+)\s+/);
    if (fieldMatch) {
      models[currentModel].fields.push(fieldMatch[1]);
    }
  }
}

const getBestSortField = (modelName) => {
  if (!models[modelName]) return 'id'; // fallback
  const fields = models[modelName].fields;
  if (fields.includes('createdAt')) return 'createdAt';
  if (fields.includes('changedAt')) return 'changedAt';
  if (fields.includes('recordedAt')) return 'recordedAt';
  if (fields.includes('created_at')) return 'created_at';
  if (fields.includes('timestamp')) return 'timestamp';
  if (fields.includes('date')) return 'date';
  if (fields.includes('id')) return 'id';
  return fields[0]; // super fallback
};

const routeFiles = fs.readdirSync(routesDir).filter(f => f.endsWith('.ts'));

let fixedCount = 0;

for (const file of routeFiles) {
  const filePath = path.join(routesDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Extract model name from imports like: import { ... } from "../../generated/prismabox/ModelName";
  const modelMatch = content.match(/from\s+"(?:..\/)+generated\/prismabox\/([^"]+)"/);
  if (modelMatch) {
    const modelName = modelMatch[1];
    const bestField = getBestSortField(modelName);
    
    if (bestField !== 'createdAt') {
      const originalContent = content;
      content = content.replace(/orderBy:\s*\{\s*createdAt:\s*"desc"\s*\}/g, `orderBy: { ${bestField}: "desc" }`);
      if (content !== originalContent) {
        fs.writeFileSync(filePath, content, 'utf8');
        fixedCount++;
        console.log(`Fixed ${file}: createdAt -> ${bestField}`);
      }
    }
  }
}

console.log(`Fixed ${fixedCount} files.`);
