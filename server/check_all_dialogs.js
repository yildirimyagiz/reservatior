const fs = require('fs');
const path = require('path');

function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(function(file) {
    const fullPath = path.join(dir, file);
    const stat = fs.statSync(fullPath);
    if (stat && stat.isDirectory()) { 
      results = results.concat(walk(fullPath));
    } else { 
      if (fullPath.endsWith('.tsx')) results.push(fullPath);
    }
  });
  return results;
}

const files = walk(path.join(__dirname, '../client/src/pages/admin'));
let missingDialogs = [];

files.forEach(file => {
  const content = fs.readFileSync(file, 'utf8');
  const hasDialog = content.includes('Dialog') || content.includes('DialogTrigger');
  if (!hasDialog) {
    missingDialogs.push(file);
  }
});

console.log(`Total TSX files: ${files.length}`);
console.log(`Files missing Dialogs: ${missingDialogs.length}`);
fs.writeFileSync(path.join(__dirname, '../scratch/all_missing_dialogs.json'), JSON.stringify(missingDialogs, null, 2));
