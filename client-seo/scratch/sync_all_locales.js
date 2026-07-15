const fs = require('fs');
const path = require('path');

const localesDir = path.join(__dirname, '../public/locales');
const newKeys1 = JSON.parse(fs.readFileSync(path.join(__dirname, 'new_keys.json'), 'utf8'));
const newKeys2 = JSON.parse(fs.readFileSync(path.join(__dirname, 'app_new_keys.json'), 'utf8'));

const allNewKeys = { ...newKeys1, ...newKeys2 };
const files = fs.readdirSync(localesDir).filter(f => f.endsWith('.json'));

for (const file of files) {
    if (file === 'en.json') continue; // English already has them
    
    const filePath = path.join(localesDir, file);
    const dict = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    
    let added = 0;
    for (const [key, val] of Object.entries(allNewKeys)) {
        if (!dict[key]) {
            dict[key] = val; // fallback to english string
            added++;
        }
    }
    
    if (added > 0) {
        fs.writeFileSync(filePath, JSON.stringify(dict, null, 2));
        console.log(`Added ${added} missing keys to ${file}`);
    } else {
        console.log(`${file} is already up to date.`);
    }
}
