import { Project, SyntaxKind, JsxElement, JsxSelfClosingElement } from "ts-morph";
import * as fs from 'fs';

const filesToUpdate = JSON.parse(fs.readFileSync('/Users/os2026/Downloads/Reservatior/scratch/files_to_update.json', 'utf8'));

const project = new Project();

filesToUpdate.forEach((filePath: string) => {
  console.log(`Processing ${filePath}...`);
  const sourceFile = project.addSourceFileAtPath(filePath);
  let changed = false;

  // Add useState import if missing
  const importDecls = sourceFile.getImportDeclarations();
  const reactImport = importDecls.find(imp => imp.getModuleSpecifierValue() === 'react');
  if (reactImport) {
    const namedImports = reactImport.getNamedImports();
    if (!namedImports.some(ni => ni.getName() === 'useState')) {
      reactImport.addNamedImport('useState');
      changed = true;
    }
  } else {
    sourceFile.addImportDeclaration({
      moduleSpecifier: 'react',
      namedImports: ['useState']
    });
    changed = true;
  }

  // Add dialog imports
  const dialogImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@/components/ui/dialog');
  if (!dialogImport) {
    sourceFile.addImportDeclaration({
      moduleSpecifier: '@/components/ui/dialog',
      namedImports: ['Dialog', 'DialogContent', 'DialogHeader', 'DialogTitle', 'DialogTrigger', 'DialogFooter', 'DialogDescription']
    });
    changed = true;
  }

  // Add Input/Label imports
  const inputImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@/components/ui/input');
  if (!inputImport) {
    sourceFile.addImportDeclaration({
      moduleSpecifier: '@/components/ui/input',
      namedImports: ['Input']
    });
    changed = true;
  }
  const labelImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@/components/ui/label');
  if (!labelImport) {
    sourceFile.addImportDeclaration({
      moduleSpecifier: '@/components/ui/label',
      namedImports: ['Label']
    });
    changed = true;
  }

  // Find the main component function
  const componentFuncs = sourceFile.getFunctions().filter(f => f.isExported());
  const arrowFuncs = sourceFile.getVariableDeclarations().filter(v => {
    const init = v.getInitializer();
    return init && init.getKind() === SyntaxKind.ArrowFunction && v.getName().charAt(0) === v.getName().charAt(0).toUpperCase();
  });

  let mainComponent = null;
  if (componentFuncs.length > 0) mainComponent = componentFuncs[0];
  else if (arrowFuncs.length > 0) mainComponent = arrowFuncs[0].getInitializerIfKind(SyntaxKind.ArrowFunction);

  if (!mainComponent) {
    console.log(`Could not find main component in ${filePath}`);
    return;
  }

  // Add useState hook
  const body = mainComponent.getBody();
  if (body && body.getKind() === SyntaxKind.Block) {
    const block = body;
    if (!block.getText().includes('const [isAddOpen, setIsAddOpen] = useState(false)')) {
      block.insertStatements(0, 'const [isAddOpen, setIsAddOpen] = useState(false);');
      changed = true;
    }
  }

  // Replace button with Dialog
  const jsxElements = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  for (const element of jsxElements) {
    const opening = element.getOpeningElement();
    if (opening.getTagNameNode().getText() === 'Button') {
      const text = element.getText();
      if (/(<Plus|Add |Create |Invite |New |Ekle|Oluştur)/i.test(text) && !text.includes('DialogTrigger')) {
        const title = "Create New Record";
        const newJsx = `
          <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
            <DialogTrigger asChild>
              ${text}
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-card text-card-foreground">
              <DialogHeader>
                <DialogTitle>${title}</DialogTitle>
                <DialogDescription>
                  Enter the required details below to add a new record.
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="name" className="text-right">Name</Label>
                  <Input id="name" className="col-span-3" placeholder="Enter name" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="desc" className="text-right">Description</Label>
                  <Input id="desc" className="col-span-3" placeholder="Enter description" />
                </div>
              </div>
              <DialogFooter>
                <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                <Button onClick={() => setIsAddOpen(false)}>Save Changes</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        `;
        try {
          element.replaceWithText(newJsx);
          changed = true;
          break; // only replace the first matching button
        } catch(e) {
          console.error("Error replacing element:", e);
        }
      }
    }
  }

  if (changed) {
    sourceFile.saveSync();
    console.log(`Saved ${filePath}`);
  }
});
console.log("Done.");
