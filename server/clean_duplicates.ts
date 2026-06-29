import { Project, SyntaxKind } from "ts-morph";
import * as path from "path";

const project = new Project();
project.addSourceFilesAtPaths("../client/src/pages/admin/**/*.tsx");

const sourceFiles = project.getSourceFiles();

let fixedCount = 0;

for (const sourceFile of sourceFiles) {
  let fileChanged = false;

  const importDeclarations = sourceFile.getImportDeclarations();
  const importMap = new Map<string, Set<string>>();

  for (const importDecl of importDeclarations) {
    const moduleSpecifier = importDecl.getModuleSpecifierValue();
    const namedImports = importDecl.getNamedImports();
    
    if (!importMap.has(moduleSpecifier)) {
      importMap.set(moduleSpecifier, new Set());
    }
    
    for (const namedImport of namedImports) {
      const name = namedImport.getName();
      if (importMap.get(moduleSpecifier)!.has(name)) {
        namedImport.remove();
        fileChanged = true;
      } else {
        importMap.get(moduleSpecifier)!.add(name);
      }
    }
  }

  for (const importDecl of sourceFile.getImportDeclarations()) {
      if (importDecl.getNamedImports().length === 0 && !importDecl.getDefaultImport() && !importDecl.getNamespaceImport()) {
          if (importDecl.getText().includes('{')) {
            importDecl.remove();
            fileChanged = true;
          }
      }
  }

  const defaultExport = sourceFile.getDefaultExportSymbol();
  if (defaultExport) {
    const defaultExportDecl = defaultExport.getDeclarations()[0];
    if (defaultExportDecl && defaultExportDecl.getKind() === SyntaxKind.FunctionDeclaration) {
      const funcDecl = defaultExportDecl.asKind(SyntaxKind.FunctionDeclaration);
      if (funcDecl) {
        const body = funcDecl.getBody();
        if (body && body.getKind() === SyntaxKind.Block) {
          const block = body.asKind(SyntaxKind.Block)!;
          const statements = block.getStatements();
          
          let hasToast = false;
          let hasQueryClient = false;
          let hasEditingId = false;

          for (const stmt of statements) {
            if (stmt.getKind() === SyntaxKind.VariableStatement) {
              const varStmt = stmt.asKind(SyntaxKind.VariableStatement)!;
              const text = varStmt.getText();
              
              if (text.includes('useToast()') || text.includes('useToast(')) {
                if (hasToast) {
                  varStmt.remove();
                  fileChanged = true;
                } else {
                  hasToast = true;
                }
              }
              
              if (text.includes('useQueryClient()') || text.includes('useQueryClient(')) {
                if (hasQueryClient) {
                  varStmt.remove();
                  fileChanged = true;
                } else {
                  hasQueryClient = true;
                }
              }

              if (text.includes('const [editingId, setEditingId] =')) {
                if (hasEditingId) {
                  varStmt.remove();
                  fileChanged = true;
                } else {
                  hasEditingId = true;
                }
              }
            }
          }
        }
      }
    }
  }

  if (fileChanged) {
    sourceFile.saveSync();
    fixedCount++;
    console.log(`Fixed duplicates in ${sourceFile.getBaseName()}`);
  }
}

console.log(`Finished fixing ${fixedCount} files.`);
