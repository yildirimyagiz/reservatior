const fs = require('fs');
const path = require('path');

function scan(dirPath) {
  if (!fs.statSync(dirPath).isDirectory()) return;
  for (const f of fs.readdirSync(dirPath)) {
    const p = path.join(dirPath, f);
    if (fs.statSync(p).isDirectory()) {
      scan(p);
    } else if (p.endsWith('.dart')) {
      const content = fs.readFileSync(p, 'utf8');
      const lines = content.split('\n');
      for (let i=0; i<lines.length; i++) {
        // Find strings in quotes that are NOT followed by .tr()
        let match;
        const regex = /['"]([^'"]+)['"](?!\.tr\(\))/g;
        while ((match = regex.exec(lines[i])) !== null) {
          const txt = match[1];
          if (txt.length > 2 && !txt.match(/^[a-zA-Z0-9_\/.]*$/) && !txt.includes('package:') && !txt.includes('${') && !txt.includes('=>')) {
            console.log(`settings/${path.basename(p)}:${i+1}: ${txt}`);
          }
        }
      }
    }
  }
}
scan('/Users/os2026/Downloads/Reservatior/mobile/lib/features/settings');
