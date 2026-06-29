const fs = require('fs');

const en = JSON.parse(fs.readFileSync('client/src/locales/en.json', 'utf8'));
const tr = JSON.parse(fs.readFileSync('client/src/locales/tr.json', 'utf8'));

let enIssues = 0;
let trIssues = 0;

for (const [key, value] of Object.entries(en)) {
  if (key.startsWith('admin.') && (value === 'Title' || value === 'Subtitle' || value === 'Alt Başlık' || value === 'Başlık')) {
    enIssues++;
  }
}

for (const [key, value] of Object.entries(tr)) {
  if (key.startsWith('admin.') && (value === 'Başlık' || value === 'Alt Başlık' || value === 'Title' || value === 'Subtitle')) {
    trIssues++;
  }
}

console.log(`en.json has ${enIssues} generic admin keys`);
console.log(`tr.json has ${trIssues} generic admin keys`);
