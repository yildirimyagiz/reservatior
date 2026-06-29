const fs = require('fs');
const path = require('path');
const glob = require('glob');

// Use the local glob if available or just a simple recursive readdir
function walk(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach(function(file) {
    file = dir + '/' + file;
    const stat = fs.statSync(file);
    if (stat && stat.isDirectory()) { 
      results = results.concat(walk(file));
    } else { 
      if (file.endsWith('.tsx')) results.push(file);
    }
  });
  return results;
}

const files = walk('client/src/pages/admin');
let missingDialogs = 0;
let filesToUpdate = [];

files.forEach(file => {
  const content = fs.readFileSync(file, 'utf8');
  // Check if it has a Button with Add/Create/New but no Dialog
  if (content.includes('<Button') && /(Add |Create |Invite |New |Ekle|Oluştur)/i.test(content)) {
    if (!content.includes('<Dialog') && !content.includes('DialogTrigger')) {
      missingDialogs++;
      filesToUpdate.push(file);
    }
  }
});

console.log(`Found ${missingDialogs} files that have Add/Create buttons but no Dialog component.`);
filesToUpdate.slice(0, 10).forEach(f => console.log(f));
if (filesToUpdate.length > 10) console.log('...and more');
