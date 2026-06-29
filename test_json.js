const fs = require('fs');
const path = require('path');
const dir = 'mobile/assets/translations';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.json'));
files.forEach(file => {
  const p = path.join(dir, file);
  try {
    JSON.parse(fs.readFileSync(p, 'utf8'));
  } catch(e) {
    console.error(`Failed parsing ${p}:`, e.message);
  }
});
