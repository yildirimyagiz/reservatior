import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/vendors/VendorsManagement.tsx");

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

if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/hooks/use-toast')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/hooks/use-toast',
    namedImports: ['useToast']
  });
}

if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/lib/api/client')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/lib/api/client',
    namedImports: ['apiClient']
  });
}

const component = sourceFile.getFunction('VendorsManagement') || sourceFile.getVariableDeclaration('VendorsManagement')?.getInitializer();
if (component) {
  const block = component.getBody ? component.getBody() : component;
  if (block && block.getKind() === SyntaxKind.Block) {
    // Check if mutation already exists
    if (!block.getText().includes('const createMutation = useMutation')) {
      block.insertStatements(1, `const { toast } = useToast();`);
      block.insertStatements(3, `
        const [newVendor, setNewVendor] = useState({
          legalName: '',
          orgId: 'org_1', // Temporary default
          serviceAreas: '',
          defaultCommissionBps: 1000
        });

        const createMutation = useMutation({
          mutationFn: async (data: any) => {
            return apiClient.post('/api/v1/vendor-profiles', {
               ...data,
               defaultCommissionBps: parseInt(data.defaultCommissionBps)
            });
          },
          onSuccess: () => {
            setIsAddOpen(false);
            toast({ title: "Success", description: "Vendor created successfully" });
          },
          onError: (err: any) => {
            toast({ title: "Error", description: err.message || "Failed to create vendor", variant: "destructive" });
          }
        });
      `);
    }
  }

  // Replace DialogContent with real form
  const jsxElements = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  for (const element of jsxElements) {
    const opening = element.getOpeningElement();
    if (opening.getTagNameNode().getText() === 'DialogContent') {
      const newJsx = `
<DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
  <DialogHeader>
    <DialogTitle>Add New Vendor</DialogTitle>
    <DialogDescription>
      Register a new vendor in the system mapped to the backend.
    </DialogDescription>
  </DialogHeader>
  <div className="grid gap-4 py-4">
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="legalName" className="text-right text-xs">Legal Name</Label>
      <Input id="legalName" className="col-span-3 h-10" value={newVendor.legalName} onChange={e => setNewVendor({...newVendor, legalName: e.target.value})} placeholder="Acme Services LLC" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="orgId" className="text-right text-xs">Org ID</Label>
      <Input id="orgId" className="col-span-3 h-10" value={newVendor.orgId} onChange={e => setNewVendor({...newVendor, orgId: e.target.value})} placeholder="org_1" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="serviceAreas" className="text-right text-xs">Service Areas</Label>
      <Input id="serviceAreas" className="col-span-3 h-10" value={newVendor.serviceAreas} onChange={e => setNewVendor({...newVendor, serviceAreas: e.target.value})} placeholder="Plumbing, Electrical" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="defaultCommissionBps" className="text-right text-xs">Commission (BPS)</Label>
      <Input id="defaultCommissionBps" type="number" className="col-span-3 h-10" value={newVendor.defaultCommissionBps} onChange={e => setNewVendor({...newVendor, defaultCommissionBps: parseInt(e.target.value) || 0})} placeholder="1000 (10%)" />
    </div>
  </div>
  <DialogFooter>
    <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
    <Button onClick={() => createMutation.mutate(newVendor)} disabled={createMutation.isPending || !newVendor.legalName}>
      {createMutation.isPending ? "Saving..." : "Add Vendor"}
    </Button>
  </DialogFooter>
</DialogContent>
      `;
      element.replaceWithText(newJsx);
      break;
    }
  }
}

sourceFile.saveSync();
console.log("VendorsManagement Rewrite successful.");
