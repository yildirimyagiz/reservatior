const fs = require("fs");
const path = require("path");

const overviewPath = "../mobile/lib/features/navigation/presentation/screens/features_overview_screen.dart";
let overviewContent = fs.readFileSync(overviewPath, "utf8");

const routesPath = "../mobile/lib/core/navigation/feature_routes.dart";
const routesContent = fs.readFileSync(routesPath, "utf8");

const routesRegex = /GoRoute\(path:\s*'(\/admin\/[^']+)'/g;
const validRoutes = new Set();
let match;
while ((match = routesRegex.exec(routesContent)) !== null) {
  validRoutes.add(match[1]);
}

const overviewRegex = /'route':\s*'(\/admin\/[^']+)'/g;
const mismatches = [];

// Try to auto-fix hyphen vs underscore, or missing 's'
overviewContent = overviewContent.replace(overviewRegex, (fullMatch, route) => {
  if (validRoutes.has(route)) {
    return fullMatch; // It's valid, do nothing
  }
  
  // Try replacing hyphens with underscores
  const withUnderscore = route.replace(/-/g, "_");
  if (validRoutes.has(withUnderscore)) {
    console.log(`Fixing: ${route} -> ${withUnderscore}`);
    return `'route': '${withUnderscore}'`;
  }
  
  // Try adding 's'
  const withS = route + "s";
  if (validRoutes.has(withS)) {
    console.log(`Fixing: ${route} -> ${withS}`);
    return `'route': '${withS}'`;
  }

  // Try removing 's'
  if (route.endsWith("s")) {
    const withoutS = route.slice(0, -1);
    if (validRoutes.has(withoutS)) {
      console.log(`Fixing: ${route} -> ${withoutS}`);
      return `'route': '${withoutS}'`;
    }
  }

  mismatches.push(route);
  return fullMatch;
});

fs.writeFileSync(overviewPath, overviewContent, "utf8");

console.log(`Fixed some routes. Remaining mismatches that couldn't be auto-fixed: ${mismatches.length}`);
if (mismatches.length > 0) {
  console.log(mismatches.join(", "));
}
