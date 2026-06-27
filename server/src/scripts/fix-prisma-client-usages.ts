/**
 * Script to replace all `new PrismaClient()` with PrismaManager
 */
import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
project.addSourceFilesAtPaths("src/**/*.ts");

console.log("🚀 Fixing PrismaClient usages...");

const filesToFix = [
  "src/middleware/auth.ts",
  "src/routes/listing-tag.ts",
  "src/routes/listing.ts",
  "src/routes/subscription.ts",
  "src/lib/intelligence/CategoryService.ts",
  "src/lib/intelligence/MLBridgeService.ts",
  "src/lib/intelligence/MarketIntelligenceService.ts",
  "src/services/openbanking.ts",
  "src/services/ai-arbitrage.ts",
  "src/services/eviction-enforcement.ts",
  "src/services/b2b-hotel-aggregator.ts",
];

for (const filePath of filesToFix) {
  const sourceFile = project.getSourceFile(filePath);
  if (!sourceFile) {
    console.log(`  ❌ File not found: ${filePath}`);
    continue;
  }

  console.log(`  ✏️  Processing: ${filePath}`);

  // Remove direct PrismaClient import
  const prismaClientImport = sourceFile.getImportDeclarations().find(
    i => i.getModuleSpecifierValue() === "@prisma/client" && 
    i.getNamedImports().some(n => n.getName() === "PrismaClient")
  );
  
  if (prismaClientImport) {
    const namedImports = prismaClientImport.getNamedImports();
    if (namedImports.length === 1 && namedImports[0].getName() === "PrismaClient") {
      // Remove entire import if only PrismaClient
      if (namedImports.length === 1) {
        prismaClientImport.remove();
      } else {
        // Just remove PrismaClient from named imports
        prismaClientImport.removeNamedImport("PrismaClient");
      }
    }
  }

  // Check if there's already a prisma import from lib
  const hasPrismaImport = sourceFile.getImportDeclarations().some(
    i => i.getModuleSpecifierValue() === "../lib/prisma" || 
         i.getModuleSpecifierValue() === "../../lib/prisma" ||
         i.getModuleSpecifierValue() === "../../../lib/prisma"
  );

  // Replace `new PrismaClient()` with `prismaManager.getDefault()`
  const prismaClientExpressions = sourceFile.getDescendantsOfKind(SyntaxKind.NewExpression)
    .filter(e => e.getText() === "new PrismaClient()");

  for (const expr of prismaClientExpressions) {
    expr.replaceWithText("prismaManager.getDefault()");
  }

  // Add proper import for prismaManager
  if (prismaClientExpressions.length > 0 && !hasPrismaImport) {
    // Calculate relative path
    const depth = (filePath.match(/\//g) || []).length - 1; // number of dirs deep
    const prefix = depth === 1 ? "." : Array(depth - 1).fill("..").join("/");
    
    sourceFile.addImportDeclaration({
      namedImports: ["prismaManager"],
      moduleSpecifier: `${prefix}/lib/prisma`
    });
  }
}

project.saveSync();
console.log("✅ Done! All PrismaClient usages replaced.");
