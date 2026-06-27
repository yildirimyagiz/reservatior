/**
 * Comprehensive script to make ALL routes region-aware
 * - Adds regionMiddleware to every route
 * - Updates all service calls to use withDB(db as any)
 * - Adds db, orgId to handler destructuring
 */
import { Project, SyntaxKind, CallExpression } from "ts-morph";

const project = new Project();
project.addSourceFilesAtPaths("src/services/**/*.ts");
project.addSourceFilesAtPaths("src/routes/**/*.ts");

console.log("🚀 Starting Comprehensive Regional Route Transformation...");

// STEP 1: Update ALL Services to include modelName in super() call
console.log("\n📦 Step 1: Updating services with modelName...");
const serviceFiles = project.getSourceFiles("src/services/**/*.ts");
let svcCount = 0;
for (const sourceFile of serviceFiles) {
  const classes = sourceFile.getClasses();
  for (const cls of classes) {
    const baseClass = cls.getBaseClass();
    if (baseClass && baseClass.getName() === "BaseService") {
      const constructor = cls.getConstructors()[0];
      if (constructor) {
        const superCallStmt = constructor.getStatements().find(s => {
          const callExpr = s.getFirstChildByKind(SyntaxKind.CallExpression);
          return callExpr?.getExpression().getText() === "super";
        });
        if (superCallStmt) {
          const callExpr = superCallStmt.getFirstChildByKind(SyntaxKind.CallExpression) as CallExpression;
          const args = callExpr.getArguments();
          if (args.length === 1 && args[0].getText().startsWith("prisma.")) {
            const modelName = args[0].getText().split(".")[1];
            // Only add modelName if not already present
            if (args.length < 2 || !args[1] || args[1].getText().replace(/['"]/g, '') !== modelName) {
              callExpr.addArgument(`"${modelName}"`);
              svcCount++;
            }
          }
        }
      }
    }
  }
}
console.log(`  ✅ Updated ${svcCount} services with modelName`);

// STEP 2: Update ALL Route files to be region-aware
console.log("\n📦 Step 2: Updating routes to use regionMiddleware...");
const routeFiles = project.getSourceFiles("src/routes/**/*.ts");
let routeCount = 0;
let handlerCount = 0;

for (const sourceFile of routeFiles) {
  const fileName = sourceFile.getBaseName();
  let fileModified = false;

  // Skip auth routes - handled separately
  if (fileName === "auth.ts") continue;

  // 1. Add regionMiddleware import if not present
  const hasRegionImport = sourceFile.getImportDeclarations().some(
    i => i.getModuleSpecifierValue().includes("region")
  );
  if (!hasRegionImport) {
    sourceFile.addImportDeclaration({
      namedImports: ["regionMiddleware"],
      moduleSpecifier: "../middleware/region"
    });
    fileModified = true;
  }

  // Find the Elysia instantiation chain
  const elysiaDecls = sourceFile.getVariableDeclarations().filter(d => 
    d.getInitializer()?.getKind() === SyntaxKind.CallExpression || 
    d.getInitializer()?.getKind() === SyntaxKind.NewExpression
  );

  for (const decl of elysiaDecls) {
    const initializer = decl.getInitializer();
    if (!initializer) continue;

    const text = initializer.getText();

    // 2. Add .use(regionMiddleware) if not already present
    if (!text.includes(".use(regionMiddleware)")) {
      if (text.includes(".use(authMiddleware)")) {
        initializer.replaceWithText(
          text.replace(".use(authMiddleware)", ".use(authMiddleware)\n  .use(regionMiddleware)")
        );
      } else {
        // Insert after the new Elysia({ ... }) constructor
        const match = text.match(/new\s+Elysia\s*\(\s*\{[^}]*\}\s*\)/);
        if (match) {
          const idx = text.indexOf(match[0]) + match[0].length;
          initializer.replaceWithText(
            text.slice(0, idx) + "\n  .use(regionMiddleware)" + text.slice(idx)
          );
        }
      }
      fileModified = true;
    }

    // 3. Update handler functions
    const callExprs = sourceFile.getDescendantsOfKind(SyntaxKind.CallExpression);
    for (const callExpr of callExprs) {
      const propAccess = callExpr.getExpressionIfKind(SyntaxKind.PropertyAccessExpression);
      if (!propAccess) continue;
      
      const methodName = propAccess.getName();
      if (!["get", "post", "patch", "delete", "put"].includes(methodName)) continue;

      const args = callExpr.getArguments();
      const handlerArg = args.find(a => a.getKind() === SyntaxKind.ArrowFunction);
      if (!handlerArg) continue;

      const arrowFunc = handlerArg.asKind(SyntaxKind.ArrowFunction);
      if (!arrowFunc) continue;

      const params = arrowFunc.getParameters();
      if (params.length === 0) continue;

      const param = params[0];
      if (param.getKind() !== SyntaxKind.Parameter) continue;
      
      const nameNode = param.getNameNode();
      if (nameNode.getKind() !== SyntaxKind.ObjectBindingPattern) continue;

      const objBinding = nameNode.asKind(SyntaxKind.ObjectBindingPattern);
      if (!objBinding) continue;

      const elements = objBinding.getElements().map(e => e.getText());
      let paramModified = false;
      let newText = objBinding.getText();

      if (!elements.includes("db")) {
        newText = newText.replace("{", "{ db,");
        paramModified = true;
      }
      if (!elements.includes("orgId")) {
        newText = newText.replace("{", "{ orgId,");
        paramModified = true;
      }

      if (paramModified) {
        objBinding.replaceWithText(newText);
        fileModified = true;
        handlerCount++;
      }

      // 4. Replace service calls to use withDB
      const body = arrowFunc.getBody();
      if (body.getKind() === SyntaxKind.Block) {
        const block = body.asKind(SyntaxKind.Block);
        if (!block) continue;

        // Add orgId filtering for GET list endpoints
        if (methodName === "get" && block.getText().includes("...where")) {
          if (!block.getText().includes("where.orgId")) {
            const stmts = block.getStatements();
            const whereStmtIdx = stmts.findIndex(s => s.getText().includes("...where"));
            if (whereStmtIdx !== -1) {
              block.insertStatements(whereStmtIdx + 1, "if (orgId) where.orgId = orgId;");
              fileModified = true;
            }
          }
        }

        // Replace service.xxx() calls with service.withDB(db as any).xxx()
        const serviceCalls = block.getDescendantsOfKind(SyntaxKind.PropertyAccessExpression)
          .filter(p => {
            const expr = p.getExpression();
            return expr.getText().endsWith("Service") && !expr.getText().includes(".");
          });

        for (const serviceCall of serviceCalls) {
          const fullText = serviceCall.getText();
          if (fullText.includes(".withDB")) continue;

          const serviceName = serviceCall.getExpression().getText();
          serviceCall.getExpression().replaceWithText(`${serviceName}.withDB(db as any)`);
          fileModified = true;
        }
      }
    }
  }

  if (fileModified) {
    routeCount++;
    console.log(`  ✏️  Updated: ${fileName}`);
  }
}

project.saveSync();
console.log(`\n🎉 Transformation Complete!`);
console.log(`  ✅ Services updated: ${svcCount}`);
console.log(`  ✅ Routes updated: ${routeCount}`);
console.log(`  ✅ Handlers updated with db/orgId: ${handlerCount}`);
