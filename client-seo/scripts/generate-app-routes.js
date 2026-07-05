const fs = require('fs');
const path = require('path');

const mappings = JSON.parse(fs.readFileSync('route-mapping.json', 'utf8'));

// Filter out invalid or Navigate entries, or UNKNOWN
const validRoutes = mappings.filter(r => r.file !== 'UNKNOWN' && !r.path.includes('*'));

const appDir = path.join(__dirname, '../src/app/[locale]/(spa)');

validRoutes.forEach(route => {
  // Convert react-router path to next.js path
  // e.g. /properties/:id -> properties/[id]
  let nextPath = route.path;
  if (nextPath.startsWith('/')) nextPath = nextPath.slice(1);
  if (!nextPath) nextPath = ''; // Root is handled below

  nextPath = nextPath.split('/').map(segment => {
    if (segment.startsWith(':')) {
      return `[${segment.slice(1)}]`;
    }
    return segment;
  }).join('/');

  const routeDir = path.join(appDir, nextPath);
  fs.mkdirSync(routeDir, { recursive: true });

  const pagePath = path.join(routeDir, 'page.tsx');
  
  // Content of page.tsx
  const content = `"use client";
import Component from "@/${route.file}";

export default function Page(props: any) {
  return <Component {...props} />;
}
`;

  fs.writeFileSync(pagePath, content);
  console.log(`Created route: /${nextPath} -> ${route.file}`);
});

console.log('Finished generating Next.js App routes.');
