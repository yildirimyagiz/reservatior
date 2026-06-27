import { Project, SyntaxKind, CallExpression } from "ts-morph";
import * as path from "path";

const project = new Project();
project.addSourceFilesAtPaths("src/services/**/*.ts");
project.addSourceFilesAtPaths("src/routes/**/*.ts");

console.log("Starting AST Transformation...");

// STEP 1: Update Services
const serviceFiles = project.getSourceFiles("src/services/**/*.ts");
for (const sourceFile of serviceFiles) {
  const classes = sourceFile.getClasses();
  for (const cls of classes) {
    const baseClass = cls.getBaseClass();
    if (baseClass && baseClass.getName() === "BaseService") {
      const constructor = cls.getConstructors()[0];
      if (constructor) {
        const superCall = constructor.getStatements().find(
          s => s.getKind() === SyntaxKind.ExpressionStatement &&
               s.getFirstChildByKind(SyntaxKind.CallExpression)?.getExpression().getText() === "super"
        );
        if (superCall) {
          const callExpr = superCall.getFirstChildByKind(SyntaxKind.CallExpression) as CallExpression;
          const args = callExpr.getArguments();
          if (args.length === 1 && args[0].getText().startsWith("prisma.")) {
            const modelName = args[0].getText().split(".")[1];
            callExpr.addArgument(`"${modelName}"`);
            console.log(`Updated Service: ${cls.getName()} -> Added modelName "${modelName}"`);
          }
        }
      }
    }
  }
}

// STEP 2: Update Target Routes
const TARGET_ROUTES = [
  "tenant.ts", "lease.ts", "booking.ts", "invoice.ts", "payment.ts", 
  "maintenance-work-order.ts", "lead.ts", "deal.ts", "contract.ts", "reservation.ts", "review.ts",
  "document.ts", "photo.ts", "amenity.ts", "facility.ts", "project.ts"
];

const routeFiles = project.getSourceFiles("src/routes/**/*.ts").filter(f => TARGET_ROUTES.includes(f.getBaseName()));

for (const sourceFile of routeFiles) {
  let modified = false;

  // 1. Add regionMiddleware import
  const hasRegionImport = sourceFile.getImportDeclarations().some(i => i.getModuleSpecifierValue().includes("region"));
  if (!hasRegionImport) {
    sourceFile.addImportDeclaration({
      namedImports: ["regionMiddleware"],
      moduleSpecifier: "../middleware/region"
    });
    modified = true;
  }

  // Find the Elysia instantiation chain
  const elysiaDecls = sourceFile.getVariableDeclarations().filter(d => 
    d.getInitializer()?.getKind() === SyntaxKind.CallExpression || 
    d.getInitializer()?.getKind() === SyntaxKind.NewExpression
  );

  for (const decl of elysiaDecls) {
    const initializer = decl.getInitializer();
    if (!initializer) continue;

    // Traverse CallExpressions (the builder pattern chain)
    let currentExpr = initializer;
    let addedUse = false;

    // To add `.use(regionMiddleware)`, we'll just rewrite the initialization chain textually for simplicity if it doesn't have it.
    const text = initializer.getText();
    if (!text.includes(".use(regionMiddleware)")) {
      // Find the first .use(authMiddleware) and insert after, or just append
      // Due to AST complexity of nested CallExpressions, we will replace the text.
      if (text.includes(".use(authMiddleware)")) {
        initializer.replaceWithText(text.replace(".use(authMiddleware)", ".use(authMiddleware)\n  .use(regionMiddleware)"));
      } else {
        // Just append to new Elysia({ prefix: ... })
        initializer.replaceWithText(text.replace("({ prefix:", "({ prefix:").replace("})", "})\n  .use(regionMiddleware)"));
      }
      modified = true;
    }

    // Now look for handler arrow functions: async ({ ... }) => { ... }
    // These are usually arguments to .get, .post, .patch, .delete, .put
    const callExprs = sourceFile.getDescendantsOfKind(SyntaxKind.CallExpression);
    for (const callExpr of callExprs) {
      const propAccess = callExpr.getExpressionIfKind(SyntaxKind.PropertyAccessExpression);
      if (propAccess) {
        const methodName = propAccess.getName();
        if (["get", "post", "patch", "delete", "put"].includes(methodName)) {
          const args = callExpr.getArguments();
          const handlerArg = args.find(a => a.getKind() === SyntaxKind.ArrowFunction);
          if (handlerArg) {
            const arrowFunc = handlerArg.asKind(SyntaxKind.ArrowFunction);
            if (arrowFunc) {
              const params = arrowFunc.getParameters();
              if (params.length > 0) {
                const param = params[0];
                if (param.getKind() === SyntaxKind.Parameter && param.getNameNode().getKind() === SyntaxKind.ObjectBindingPattern) {
                  const objBinding = param.getNameNode().asKind(SyntaxKind.ObjectBindingPattern);
                  if (objBinding) {
                    const elements = objBinding.getElements().map(e => e.getText());
                    let newText = objBinding.getText(); // e.g. "{ query }"
                    let paramModified = false;
                    
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
                      modified = true;
                    }

                    // Inside the body, replace service calls
                    const body = arrowFunc.getBody();
                    if (body.getKind() === SyntaxKind.Block) {
                      const block = body.asKind(SyntaxKind.Block);
                      if (block) {
                        // Insert `if (orgId) where.orgId = orgId;` for GET lists if `where` is defined
                        if (methodName === "get" && block.getText().includes("...where")) {
                          if (!block.getText().includes("where.orgId")) {
                            // Find the statement that declares `where`
                            const stmts = block.getStatements();
                            const whereStmtIdx = stmts.findIndex(s => s.getText().includes("...where"));
                            if (whereStmtIdx !== -1) {
                              block.insertStatements(whereStmtIdx + 1, "if (orgId) where.orgId = orgId;");
                              modified = true;
                            }
                          }
                        }

                        // Replace service.xxx calls
                        const serviceCalls = block.getDescendantsOfKind(SyntaxKind.PropertyAccessExpression)
                          .filter(p => p.getExpression().getText().endsWith("Service"));
                        
                        for (const serviceCall of serviceCalls) {
                          const serviceName = serviceCall.getExpression().getText();
                          // Ensure we aren't replacing already `.withDB` ones
                          if (!serviceCall.getText().includes(".withDB")) {
                            serviceCall.getExpression().replaceWithText(`${serviceName}.withDB(db as any)`);
                            modified = true;
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  if (modified) {
    console.log(`Updated Route: ${sourceFile.getBaseName()}`);
  }
}

project.saveSync();
console.log("Transformation Complete!");
