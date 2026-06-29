import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/financial/Mortgages.tsx");

// Ensure imports
const importDecls = sourceFile.getImportDeclarations();
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@tanstack/react-query' && imp.getText().includes('useMutation'))) {
  const reactQueryImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@tanstack/react-query');
  if (reactQueryImport) {
    if (!reactQueryImport.getText().includes('useMutation')) {
      reactQueryImport.addNamedImport('useMutation');
    }
  } else {
    sourceFile.addImportDeclaration({
      moduleSpecifier: '@tanstack/react-query',
      namedImports: ['useMutation']
    });
  }
}

const selectImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@/components/ui/select');
if (!selectImport) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/components/ui/select',
    namedImports: ['Select', 'SelectContent', 'SelectItem', 'SelectTrigger', 'SelectValue']
  });
}

const toastImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@/hooks/use-toast');
if (!toastImport) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/hooks/use-toast',
    namedImports: ['useToast']
  });
}

const component = sourceFile.getFunction('Mortgages');
if (component) {
  const block = component.getBody();
  if (block && block.getKind() === SyntaxKind.Block) {
    // Check if toast is already destructured
    if (!block.getText().includes('const { toast }')) {
      block.insertStatements(1, `const { toast } = useToast();`);
    }

    // Add mutation and state
    block.insertStatements(3, `
      const [newMortgage, setNewMortgage] = useState({
        propertyId: '',
        lender: '',
        principal: '',
        interestRate: '',
        startDate: '',
        status: 'ACTIVE'
      });

      const createMutation = useMutation({
        mutationFn: async (data: any) => {
          return financialsApi.createMortgage({
            ...data,
            principal: parseFloat(data.principal),
            interestRate: parseFloat(data.interestRate),
            startDate: new Date(data.startDate).toISOString()
          });
        },
        onSuccess: () => {
          setIsAddOpen(false);
          fetchData();
          toast({ title: "Success", description: "Mortgage created successfully" });
        },
        onError: (err: any) => {
          toast({ title: "Error", description: err.message || "Failed to create mortgage", variant: "destructive" });
        }
      });
    `);
  }

  // Replace DialogContent with real form
  const jsxElements = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  for (const element of jsxElements) {
    const opening = element.getOpeningElement();
    if (opening.getTagNameNode().getText() === 'DialogContent') {
      const newJsx = `
<DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
  <DialogHeader>
    <DialogTitle>Add New Mortgage</DialogTitle>
    <DialogDescription>
      Register a new mortgage for a property mapping to the backend.
    </DialogDescription>
  </DialogHeader>
  <div className="grid gap-4 py-4">
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="propertyId" className="text-right text-xs">Property</Label>
      <Select value={newMortgage.propertyId} onValueChange={(v) => setNewMortgage({...newMortgage, propertyId: v})}>
        <SelectTrigger className="col-span-3 h-10">
          <SelectValue placeholder="Select Property" />
        </SelectTrigger>
        <SelectContent>
          {properties.map(p => (
            <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="lender" className="text-right text-xs">Lender Bank</Label>
      <Input id="lender" className="col-span-3 h-10" value={newMortgage.lender} onChange={e => setNewMortgage({...newMortgage, lender: e.target.value})} placeholder="e.g. Chase Bank" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="principal" className="text-right text-xs">Principal ($)</Label>
      <Input id="principal" type="number" className="col-span-3 h-10" value={newMortgage.principal} onChange={e => setNewMortgage({...newMortgage, principal: e.target.value})} placeholder="450000" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="interestRate" className="text-right text-xs">Interest Rate (%)</Label>
      <Input id="interestRate" type="number" step="0.1" className="col-span-3 h-10" value={newMortgage.interestRate} onChange={e => setNewMortgage({...newMortgage, interestRate: e.target.value})} placeholder="4.5" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="startDate" className="text-right text-xs">Start Date</Label>
      <Input id="startDate" type="date" className="col-span-3 h-10" value={newMortgage.startDate} onChange={e => setNewMortgage({...newMortgage, startDate: e.target.value})} />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="status" className="text-right text-xs">Status</Label>
      <Select value={newMortgage.status} onValueChange={(v) => setNewMortgage({...newMortgage, status: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Status" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="ACTIVE">Active</SelectItem>
          <SelectItem value="PAID_OFF">Paid Off</SelectItem>
          <SelectItem value="REFINANCED">Refinanced</SelectItem>
        </SelectContent>
      </Select>
    </div>
  </div>
  <DialogFooter>
    <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
    <Button onClick={() => createMutation.mutate(newMortgage)} disabled={createMutation.isPending}>
      {createMutation.isPending ? "Saving..." : "Add Mortgage"}
    </Button>
  </DialogFooter>
</DialogContent>
      `;
      element.replaceWithText(newJsx);
      break;
    }
  }

  // Remove onClick from the Button inside DialogTrigger
  const dialogTriggers = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  for (const trigger of dialogTriggers) {
    if (trigger.getOpeningElement().getTagNameNode().getText() === 'DialogTrigger') {
      const button = trigger.getFirstDescendantByKind(SyntaxKind.JsxElement);
      if (button && button.getOpeningElement().getTagNameNode().getText() === 'Button') {
         const onClickAttr = button.getOpeningElement().getAttribute('onClick');
         if (onClickAttr) {
            onClickAttr.remove();
         }
      }
    }
  }
}

sourceFile.saveSync();
console.log("Mortgages Rewrite successful.");
