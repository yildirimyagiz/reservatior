const fs = require('fs');
const path = require('path');
const schemaPath = path.join(__dirname, '../prisma/schema.prisma');
let content = fs.readFileSync(schemaPath, 'utf-8');
const lines = content.split('\n');

const cleanedLines = lines.filter(line => {
  if (line.match(/^\s*kiras\s+Kira\[\]/)) return false;
  if (line.match(/^\s*agencyProfiles\s+AgencyProfile\[\]/)) return false;
  if (line.match(/^\s*katMulkiyeti\s+Boolean/)) return false;
  if (line.match(/^\s*kira\s+Kira\?\s*@relation/)) return false;
  if (line.match(/^\s*kiraId\s+String\?/)) return false;
  if (line.match(/^\s*organizasyon\s+Organizasyon\?\s*@relation/)) return false;
  if (line.match(/^\s*organizasyonId\s+String\?/)) return false;
  if (line.match(/^\s*mulk\s+Mulk\?\s*@relation/)) return false;
  if (line.match(/^\s*mulkId\s+String\?/)) return false;
  if (line.match(/^\s*ilan\s+Ilan\?\s*@relation/)) return false;
  if (line.match(/^\s*ilanId\s+String\?/)) return false;
  if (line.match(/^\s*iletisim\s+Iletisim\?\s*@relation/)) return false;
  if (line.match(/^\s*iletisimId\s+String\?/)) return false;
  
  return true;
});

fs.writeFileSync(schemaPath, cleanedLines.join('\n'));
console.log("Schema cleaned");
