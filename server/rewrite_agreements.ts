import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/agencies/PartnerAgreements.tsx");

// Ensure imports
const importDecls = sourceFile.getImportDeclarations();
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@tanstack/react-query' && imp.getText().includes('useMutation'))) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@tanstack/react-query',
    namedImports: ['useMutation']
  });
}
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/hooks/use-toast')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/hooks/use-toast',
    namedImports: ['useToast']
  });
}
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/components/ui/dialog')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/components/ui/dialog',
    namedImports: ['Dialog', 'DialogContent', 'DialogHeader', 'DialogTitle', 'DialogTrigger', 'DialogFooter', 'DialogDescription']
  });
}
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/components/ui/button')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/components/ui/button',
    namedImports: ['Button']
  });
}
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/components/ui/input')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/components/ui/input',
    namedImports: ['Input']
  });
}
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/components/ui/label')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/components/ui/label',
    namedImports: ['Label']
  });
}

const component = sourceFile.getVariableDeclaration('PartnerAgreements');
if (component) {
  const func = component.getInitializer();
  if (func && (func.getKind() === SyntaxKind.ArrowFunction || func.getKind() === SyntaxKind.FunctionExpression)) {
    const block = func.getBody();
    if (block && block.getKind() === SyntaxKind.Block) {
      if (!block.getText().includes('const createMutation = useMutation')) {
        block.insertStatements(2, `const { toast } = useToast();`);
        block.insertStatements(3, `const [isAddOpen, setIsAddOpen] = useState(false);`);
        block.insertStatements(4, `
          const [newAgreement, setNewAgreement] = useState({
            baseCommission: '0.10',
            loyaltyYield: '5.0',
            portfolioHealthScore: '0.90'
          });

          const createMutation = useMutation({
            mutationFn: async (data: any) => {
              const res = await fetch('/api/v1/partner-agreement', {
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': \`Bearer \${localStorage.getItem('token')}\`
                },
                body: JSON.stringify({
                  terms: {
                    baseCommission: parseFloat(data.baseCommission),
                    loyaltyYield: parseFloat(data.loyaltyYield),
                    portfolioHealthScore: parseFloat(data.portfolioHealthScore),
                    currentMultiplier: 1.0
                  }
                })
              });
              if (!res.ok) throw new Error("Failed to create partner agreement");
              return res.json();
            },
            onSuccess: () => {
              setIsAddOpen(false);
              toast({ title: "Success", description: "Agreement created successfully" });
              // In a real app we would refetch
            },
            onError: (err: any) => {
              toast({ title: "Error", description: err.message || "Failed to create agreement", variant: "destructive" });
            }
          });
        `);
      }
    }
  }

  // Find the header section to insert the Add button
  const jsxElements = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  for (const element of jsxElements) {
    if (element.getOpeningElement().getTagNameNode().getText() === 'div' && element.getText().includes('Dynamic Contracts Dashboard')) {
      // It's the wrapper div for the header. Let's add the Dialog here.
      // Wait, let's just find the flex container for the header.
      const headerDiv = element.getParentIfKind(SyntaxKind.JsxElement);
      if (headerDiv && headerDiv.getOpeningElement().getAttribute('className')?.getText().includes('max-w-7xl')) {
        // Find the title div
        const titleDiv = headerDiv.getFirstDescendantByKind(SyntaxKind.JsxElement);
        if (titleDiv && titleDiv.getOpeningElement().getTagNameNode().getText() === 'div' && titleDiv.getText().includes('Dynamic Contracts')) {
           const newTitleDivJsx = `
<div className="flex justify-between items-start">
  <div>
    <h1 className="text-3xl font-bold text-gray-900 flex items-center gap-3">
      <Shield className="w-8 h-8 text-indigo-600" />
      Dynamic Contracts Dashboard
    </h1>
    <p className="mt-2 text-gray-600">
      Monitor the live mutations and performance metrics of agency partner agreements.
    </p>
  </div>
  <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
    <DialogTrigger asChild>
      <Button className="bg-indigo-600 hover:bg-indigo-700 text-white">Create Agreement</Button>
    </DialogTrigger>
    <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
      <DialogHeader>
        <DialogTitle>Create Partner Agreement</DialogTitle>
        <DialogDescription>
          Create a new dynamic contract mapping to the backend terms structure.
        </DialogDescription>
      </DialogHeader>
      <div className="grid gap-4 py-4">
        <div className="grid grid-cols-4 items-center gap-4">
          <Label htmlFor="baseCommission" className="text-right text-xs">Base Commission</Label>
          <Input id="baseCommission" type="number" step="0.01" className="col-span-3 h-10" value={newAgreement.baseCommission} onChange={e => setNewAgreement({...newAgreement, baseCommission: e.target.value})} placeholder="0.10" />
        </div>
        <div className="grid grid-cols-4 items-center gap-4">
          <Label htmlFor="loyaltyYield" className="text-right text-xs">Loyalty Yield</Label>
          <Input id="loyaltyYield" type="number" step="0.1" className="col-span-3 h-10" value={newAgreement.loyaltyYield} onChange={e => setNewAgreement({...newAgreement, loyaltyYield: e.target.value})} placeholder="5.0" />
        </div>
        <div className="grid grid-cols-4 items-center gap-4">
          <Label htmlFor="portfolioHealthScore" className="text-right text-xs">Health Score</Label>
          <Input id="portfolioHealthScore" type="number" step="0.01" className="col-span-3 h-10" value={newAgreement.portfolioHealthScore} onChange={e => setNewAgreement({...newAgreement, portfolioHealthScore: e.target.value})} placeholder="0.90" />
        </div>
      </div>
      <DialogFooter>
        <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
        <Button onClick={() => createMutation.mutate(newAgreement)} disabled={createMutation.isPending}>
          {createMutation.isPending ? "Saving..." : "Create"}
        </Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</div>
           `;
           titleDiv.replaceWithText(newTitleDivJsx);
           break;
        }
      }
    }
  }
}

sourceFile.saveSync();
console.log("PartnerAgreements Rewrite successful.");
