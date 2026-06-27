const fs = require('fs');

const content = fs.readFileSync('lib/core/navigation/app_routes.dart', 'utf-8');
const lines = content.split('\n');

const adminRoutes = [];

lines.forEach(line => {
  const match = line.match(/static const String (admin[a-zA-Z0-9_]+)\s*=\s*'(\/admin\/[^']+)';/);
  if (match) {
    adminRoutes.push({
      name: match[1],
      route: match[2],
      title: match[1].replace(/^admin/, '').replace(/([A-Z])/g, ' $1').trim()
    });
  }
});

// also handle multi-line cases
const multilineContent = content.replace(/\n/g, ' ');
const multiMatches = [...multilineContent.matchAll(/static const String (admin[a-zA-Z0-9_]+)\s*=\s*'(\/admin\/[^']+)'/g)];
const uniqueRoutes = new Map();
multiMatches.forEach(m => {
  uniqueRoutes.set(m[1], {
    name: m[1],
    route: m[2],
    title: m[1].replace(/^admin/, '').replace(/([A-Z])/g, ' $1').trim()
  });
});

const sortedRoutes = Array.from(uniqueRoutes.values()).sort((a, b) => a.title.localeCompare(b.title));

console.log(JSON.stringify(sortedRoutes, null, 2));
