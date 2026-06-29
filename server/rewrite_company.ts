import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/company/CompanyManagement.tsx");

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

if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/lib/api/client')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/lib/api/client',
    namedImports: ['apiClient']
  });
}

const component = sourceFile.getFunction('CompanyManagement') || sourceFile.getVariableDeclaration('CompanyManagement')?.getInitializer();
if (component) {
  const block = component.getBody ? component.getBody() : component;
  if (block && block.getKind() === SyntaxKind.Block) {
    // Check if mutation already exists
    if (!block.getText().includes('const createMutation = useMutation')) {
      block.insertStatements(2, `
        const [newOrg, setNewOrg] = useState({
          name: '',
          type: 'OWNER_PORTFOLIO',
          region: 'GLOBAL'
        });

        const createMutation = useMutation({
          mutationFn: async (data: any) => {
            return apiClient.post('/api/v1/organization', data);
          },
          onSuccess: () => {
            setIsAddOpen(false);
            toast({ title: "Success", description: "Organization created successfully" });
          },
          onError: (err: any) => {
            toast({ title: "Error", description: err.message || "Failed to create organization", variant: "destructive" });
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
    <DialogTitle>Create New Organization</DialogTitle>
    <DialogDescription>
      Register a new organization (company, agency, vendor) mapped to the backend.
    </DialogDescription>
  </DialogHeader>
  <div className="grid gap-4 py-4">
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="name" className="text-right text-xs">Org Name</Label>
      <Input id="name" className="col-span-3 h-10" value={newOrg.name} onChange={e => setNewOrg({...newOrg, name: e.target.value})} placeholder="Acme Corporation" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="type" className="text-right text-xs">Org Type</Label>
      <Select value={newOrg.type} onValueChange={(v) => setNewOrg({...newOrg, type: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Type" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="OWNER_PORTFOLIO">Owner Portfolio</SelectItem>
          <SelectItem value="VENDOR_PM">Vendor PM</SelectItem>
          <SelectItem value="AGENCY">Agency</SelectItem>
          <SelectItem value="ACCOUNTING_FIRM">Accounting Firm</SelectItem>
          <SelectItem value="PUBLIC_ENTITY">Public Entity</SelectItem>
        </SelectContent>
      </Select>
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="region" className="text-right text-xs">Region</Label>
      <Select value={newOrg.region} onValueChange={(v) => setNewOrg({...newOrg, region: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Region" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="GLOBAL">Global</SelectItem>
          <SelectItem value="TR">Turkey</SelectItem>
          <SelectItem value="USA">USA</SelectItem>
          <SelectItem value="UK">UK</SelectItem>
          <SelectItem value="UAE">UAE</SelectItem>
          <SelectItem value="FR">France</SelectItem>
          <SelectItem value="DE">Germany</SelectItem>
        </SelectContent>
      </Select>
    </div>
  </div>
  <DialogFooter>
    <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
    <Button onClick={() => createMutation.mutate(newOrg)} disabled={createMutation.isPending || !newOrg.name}>
      {createMutation.isPending ? "Saving..." : "Create Organization"}
    </Button>
  </DialogFooter>
</DialogContent>
      `;
      element.replaceWithText(newJsx);
      break; // Only replace the first one
    }
  }
}

sourceFile.saveSync();
console.log("CompanyManagement Rewrite successful.");
