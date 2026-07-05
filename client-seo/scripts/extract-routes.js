const fs = require('fs');

function extractRoutes() {
  const content = fs.readFileSync('src/router/index.tsx', 'utf-8');

  // React Router often uses path: "...", element: <Component />
  const routeRegex = /path:\s*['"](.*?)['"],\s*element:\s*<([a-zA-Z0-9_]+)/g;
  const routes = [];
  let match;
  while ((match = routeRegex.exec(content)) !== null) {
    if (match[1] === '*') continue;
    if (match[1] === '') continue;
    routes.push({ path: match[1], element: match[2] });
  }

  // Also check nested routes, sometimes element: <Suspense><Component /></Suspense>
  const suspRegex = /path:\s*['"](.*?)['"],\s*element:\s*<[^>]+>\s*<([a-zA-Z0-9_]+)/g;
  while ((match = suspRegex.exec(content)) !== null) {
    if (match[1] === '*') continue;
    if (match[1] === '') continue;
    routes.push({ path: match[1], element: match[2] });
  }

  // Find all lazy imports to map component names to file paths
  const importRegex = /const\s+([a-zA-Z0-9_]+)\s*=\s*lazy\(\(\)\s*=>\s*import\(['"]@\/(pages-spa\/.*?)['"]\)\)/g;
  const imports = {};
  while ((match = importRegex.exec(content)) !== null) {
    imports[match[1]] = match[2];
  }

  // Also check standard imports
  const stdImportRegex = /import\s+([a-zA-Z0-9_]+)\s+from\s+['"]@\/(pages-spa\/.*?)['"]/g;
  while ((match = stdImportRegex.exec(content)) !== null) {
    imports[match[1]] = match[2];
  }

  const mapping = routes.map(r => ({
    path: r.path,
    element: r.element,
    file: imports[r.element] || 'UNKNOWN'
  }));

  fs.writeFileSync('route-mapping.json', JSON.stringify(mapping, null, 2));
  console.log(`Extracted ${mapping.length} routes.`);
}

extractRoutes();
