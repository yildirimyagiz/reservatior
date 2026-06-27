const fs = require('fs');

const overviewFile = '/Users/os2026/Downloads/Reservatior/mobile/lib/features/navigation/presentation/screens/features_overview_screen.dart';

const routerFiles = [
  '/Users/os2026/Downloads/Reservatior/mobile/lib/core/navigation/role_based_router.dart',
  '/Users/os2026/Downloads/Reservatior/mobile/lib/core/navigation/app_routes.dart',
  '/Users/os2026/Downloads/Reservatior/mobile/lib/core/navigation/feature_routes.dart',
  '/Users/os2026/Downloads/Reservatior/mobile/lib/core/routing/feature_router.dart'
];

const overviewContent = fs.readFileSync(overviewFile, 'utf8');
let allRouterCode = '';

for (const file of routerFiles) {
  if (fs.existsSync(file)) {
    allRouterCode += fs.readFileSync(file, 'utf8') + '\n';
  }
}

const routeRegex = /'route':\s*'([^']+)'/g;
let match;
const definedRoutes = [];

while ((match = routeRegex.exec(overviewContent)) !== null) {
  definedRoutes.push(match[1]);
}

console.log(`Found ${definedRoutes.length} routes in features_overview_screen.dart`);

const missingRoutes = [];

for (const route of definedRoutes) {
  const absolutePathStr = `'${route}'`;
  const relativePathStr = `'${route.startsWith('/') ? route.substring(1) : route}'`;
  
  if (!allRouterCode.includes(absolutePathStr) && !allRouterCode.includes(relativePathStr) && !allRouterCode.includes(`"${route}"`)) {
    const parts = route.split('/').filter(p => p);
    let foundParts = true;
    for (const p of parts) {
      if (!allRouterCode.includes(`'${p}'`) && !allRouterCode.includes(`"${p}"`) && !allRouterCode.includes(`'/${p}'`)) {
        foundParts = false;
        break;
      }
    }
    
    if (!foundParts) {
       missingRoutes.push(route);
    }
  }
}

if (missingRoutes.length === 0) {
  console.log("All routes appear to be defined in the router!");
} else {
  console.log(`\nFound ${missingRoutes.length} missing or broken routes:`);
  missingRoutes.forEach(r => console.log(r));
}
