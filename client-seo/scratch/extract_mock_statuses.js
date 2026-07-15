const fs = require('fs');
const path = require('path');

const adminPath = path.join(__dirname, '../src/app/[locale]/admin');

function traverse(dir, cb) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const fullPath = path.join(dir, file);
    if (fs.statSync(fullPath).isDirectory()) {
      traverse(fullPath, cb);
    } else if (fullPath.endsWith('.tsx')) {
      cb(fullPath);
    }
  }
}

const statuses = new Set();
traverse(adminPath, (file) => {
  const content = fs.readFileSync(file, 'utf-8');
  if (content.includes('const mock')) {
    const matches = content.match(/status:\s*["']([A-Z_]+)["']/g);
    if (matches) {
      matches.forEach(m => {
        const status = m.replace(/status:\s*["']|["']/g, '');
        statuses.add(status);
      });
    }
  }
});
console.log(Array.from(statuses));
