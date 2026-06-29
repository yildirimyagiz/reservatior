import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/ai/FraudDetection.tsx");

// Ensure react-query mutation
const importDecls = sourceFile.getImportDeclarations();
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@tanstack/react-query' && imp.getText().includes('useMutation'))) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@tanstack/react-query',
    namedImports: ['useMutation']
  });
}

const component = sourceFile.getFunction('FraudDetection');
if (component) {
  const block = component.getBody();
  if (block && block.getKind() === SyntaxKind.Block) {
    if (!block.getText().includes('const createMutation = useMutation')) {
      block.insertStatements(2, `
        const [newAlert, setNewAlert] = useState({
          entityType: 'USER',
          entityId: 'USR-1234',
          riskScore: 85,
          riskCategory: 'HIGH',
          riskFactors: { "ip_mismatch": true },
          recommendedActions: ["Block IP"]
        });

        const createMutation = useMutation({
          mutationFn: async (data: any) => {
            const res = await fetch('/api/v1/ai-fraud-detections', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': \`Bearer \${localStorage.getItem('token')}\`
              },
              body: JSON.stringify({
                ...data,
                detectedAt: new Date().toISOString()
              })
            });
            if (!res.ok) throw new Error("Failed to create alert");
            return res.json();
          },
          onSuccess: () => {
            setIsAddOpen(false);
            toast({ title: "Success", description: "Simulated Alert created" });
            fetchFraudAlerts();
          },
          onError: (err: any) => {
            toast({ title: "Error", description: err.message, variant: "destructive" });
          }
        });
      `);
    }
  }

  // Find PageShell children to insert the Add button header
  const jsxElements = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  for (const element of jsxElements) {
    if (element.getOpeningElement().getTagNameNode().getText() === 'PageShell') {
      // Find the first div inside PageShell
      const firstDiv = element.getFirstDescendantByKind(SyntaxKind.JsxElement);
      if (firstDiv && firstDiv.getOpeningElement().getTagNameNode().getText() === 'div' && firstDiv.getOpeningElement().getAttribute('className')?.getText().includes('space-y-6')) {
        const headerJsx = `
<div className="flex justify-between items-center mb-6">
  <div>
    <h2 className="text-2xl font-bold tracking-tight">Fraud Alerts</h2>
    <p className="text-muted-foreground">Manage and review AI-detected anomalies.</p>
  </div>
  <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
    <DialogTrigger asChild>
      <Button className="bg-red-600 hover:bg-red-700 text-white">Simulate Alert</Button>
    </DialogTrigger>
    <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
      <DialogHeader>
        <DialogTitle>Simulate Fraud Alert</DialogTitle>
        <DialogDescription>
          Manually trigger a fraud detection alert for testing or manual logging.
        </DialogDescription>
      </DialogHeader>
      <div className="grid gap-4 py-4">
        <div className="grid grid-cols-4 items-center gap-4">
          <Label className="text-right text-xs">Entity Type</Label>
          <Input className="col-span-3 h-10" value={newAlert.entityType} onChange={e => setNewAlert({...newAlert, entityType: e.target.value})} placeholder="USER" />
        </div>
        <div className="grid grid-cols-4 items-center gap-4">
          <Label className="text-right text-xs">Entity ID</Label>
          <Input className="col-span-3 h-10" value={newAlert.entityId} onChange={e => setNewAlert({...newAlert, entityId: e.target.value})} placeholder="USR-1234" />
        </div>
        <div className="grid grid-cols-4 items-center gap-4">
          <Label className="text-right text-xs">Risk Score</Label>
          <Input type="number" className="col-span-3 h-10" value={newAlert.riskScore} onChange={e => setNewAlert({...newAlert, riskScore: parseInt(e.target.value)})} placeholder="85" />
        </div>
        <div className="grid grid-cols-4 items-center gap-4">
          <Label className="text-right text-xs">Category</Label>
          <Input className="col-span-3 h-10" value={newAlert.riskCategory} onChange={e => setNewAlert({...newAlert, riskCategory: e.target.value})} placeholder="HIGH" />
        </div>
      </div>
      <DialogFooter>
        <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
        <Button onClick={() => createMutation.mutate(newAlert)} disabled={createMutation.isPending}>
          {createMutation.isPending ? "Running..." : "Trigger"}
        </Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</div>
        `;
        firstDiv.insertChildText(0, headerJsx);
        break;
      }
    }
  }
}

sourceFile.saveSync();
console.log("FraudDetection Rewrite successful.");
