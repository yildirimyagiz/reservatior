import { Project, SyntaxKind } from "ts-morph";
import * as path from "path";

const project = new Project();
project.addSourceFilesAtPaths("src/pages/admin/**/*.tsx");

const sourceFiles = project.getSourceFiles();

let fixedCount = 0;

for (const sourceFile of sourceFiles) {
  let fileChanged = false;

  // 1. Fix duplicate imports
  const importDeclarations = sourceFile.getImportDeclarations();
  const importMap = new Map<string, Set<string>>();
  const defaultImportMap = new Map<string, string>();

  for (const importDecl of importDeclarations) {
    const moduleSpecifier = importDecl.getModuleSpecifierValue();
    
    // Collect named imports
    const namedImports = importDecl.getNamedImports();
    if (!importMap.has(moduleSpecifier)) {
      importMap.set(moduleSpecifier, new Set());
    }
    
    for (const namedImport of namedImports) {
      const name = namedImport.getName();
      if (importMap.get(moduleSpecifier)!.has(name)) {
        // It's a duplicate, remove it
        namedImport.remove();
        fileChanged = true;
      } else {
        importMap.get(moduleSpecifier)!.add(name);
      }
    }

    // After removing named imports, if the import declaration is empty and it had no default import, remove it
    if (importDecl.getNamedImports().length === 0 && !importDecl.getDefaultImport() && !importDecl.getNamespaceImport()) {
        // Wait, if it originally had no named imports, we shouldn't remove it (like import "./style.css").
        // But if it originally HAD named imports and we removed them all, we should.
        // For simplicity, just let TS format fix it, or we can leave empty imports.
    }
  }

  // Also remove cross-module duplicates (e.g. `import { Edit } from "lucide-react"` multiple times in different statements)
  // Actually the above logic only groups by moduleSpecifier. It WILL remove duplicate named imports across multiple import declarations from the SAME module!
  // BUT wait, if there are multiple imports from the same module, and one becomes empty, let's remove it:
  for (const importDecl of sourceFile.getImportDeclarations()) {
      if (importDecl.getNamedImports().length === 0 && !importDecl.getDefaultImport() && !importDecl.getNamespaceImport()) {
          // If it's not a side-effect import
          if (importDecl.getText().includes('{')) {
            importDecl.remove();
            fileChanged = true;
          }
      }
  }

  // 2. Fix duplicate `const { toast } = useToast();`
  // We look for VariableStatements inside the main React component
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
              
              if (text.includes('useToast()')) {
                if (hasToast) {
                  varStmt.remove();
                  fileChanged = true;
                } else {
                  hasToast = true;
                }
              }
              
              if (text.includes('useQueryClient()')) {
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
