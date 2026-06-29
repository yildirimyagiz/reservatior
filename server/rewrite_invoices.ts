import { Project, SyntaxKind } from "ts-morph";
import * as fs from 'fs';

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/financial/Invoices.tsx");

// Ensure imports
const importDecls = sourceFile.getImportDeclarations();
if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@tanstack/react-query' && imp.getText().includes('useMutation'))) {
  const reactQueryImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@tanstack/react-query');
  if (reactQueryImport) {
    if (!reactQueryImport.getText().includes('useMutation')) {
      reactQueryImport.addNamedImport('useMutation');
    }
  }
}

const selectImport = importDecls.find(imp => imp.getModuleSpecifierValue() === '@/components/ui/select');
if (!selectImport) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/components/ui/select',
    namedImports: ['Select', 'SelectContent', 'SelectItem', 'SelectTrigger', 'SelectValue']
  });
}

const component = sourceFile.getFunction('FinancialInvoices');
if (component) {
  const block = component.getBody();
  if (block && block.getKind() === SyntaxKind.Block) {
    // Add mutation and state
    block.insertStatements(2, `
      const [newInvoice, setNewInvoice] = useState({
        customerId: '',
        customerName: '',
        customerEmail: '',
        amount: '',
        currency: 'USD',
        dueDate: '',
        status: 'DRAFT'
      });

      const createMutation = useMutation({
        mutationFn: async (data: any) => {
          return financialsApi.createInvoice({
            ...data,
            amount: parseFloat(data.amount),
            items: [{ description: "General Services", quantity: 1, unitPrice: parseFloat(data.amount), totalPrice: parseFloat(data.amount), itemType: "SERVICE" }]
          });
        },
        onSuccess: () => {
          setIsAddOpen(false);
          refetchRecords();
          toast({ title: "Success", description: "Invoice created successfully" });
        },
        onError: (err: any) => {
          toast({ title: "Error", description: err.message || "Failed to create invoice", variant: "destructive" });
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
    <DialogTitle>Create New Invoice</DialogTitle>
    <DialogDescription>
      Fill in the invoice details mapped to the backend.
    </DialogDescription>
  </DialogHeader>
  <div className="grid gap-4 py-4">
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="customerName" className="text-right text-xs">Customer Name</Label>
      <Input id="customerName" className="col-span-3 h-10" value={newInvoice.customerName} onChange={e => setNewInvoice({...newInvoice, customerName: e.target.value})} placeholder="John Doe" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="customerEmail" className="text-right text-xs">Email</Label>
      <Input id="customerEmail" type="email" className="col-span-3 h-10" value={newInvoice.customerEmail} onChange={e => setNewInvoice({...newInvoice, customerEmail: e.target.value})} placeholder="john@example.com" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="customerId" className="text-right text-xs">Customer ID</Label>
      <Input id="customerId" className="col-span-3 h-10" value={newInvoice.customerId} onChange={e => setNewInvoice({...newInvoice, customerId: e.target.value})} placeholder="CUST-123" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="amount" className="text-right text-xs">Amount</Label>
      <Input id="amount" type="number" className="col-span-3 h-10" value={newInvoice.amount} onChange={e => setNewInvoice({...newInvoice, amount: e.target.value})} placeholder="1000" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="currency" className="text-right text-xs">Currency</Label>
      <Select value={newInvoice.currency} onValueChange={(v) => setNewInvoice({...newInvoice, currency: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Currency" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="USD">USD ($)</SelectItem>
          <SelectItem value="EUR">EUR (€)</SelectItem>
          <SelectItem value="TRY">TRY (₺)</SelectItem>
          <SelectItem value="GBP">GBP (£)</SelectItem>
        </SelectContent>
      </Select>
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="dueDate" className="text-right text-xs">Due Date</Label>
      <Input id="dueDate" type="date" className="col-span-3 h-10" value={newInvoice.dueDate} onChange={e => setNewInvoice({...newInvoice, dueDate: e.target.value})} />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="status" className="text-right text-xs">Status</Label>
      <Select value={newInvoice.status} onValueChange={(v) => setNewInvoice({...newInvoice, status: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Status" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="DRAFT">Draft</SelectItem>
          <SelectItem value="SENT">Sent</SelectItem>
          <SelectItem value="PAID">Paid</SelectItem>
          <SelectItem value="OVERDUE">Overdue</SelectItem>
        </SelectContent>
      </Select>
    </div>
  </div>
  <DialogFooter>
    <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
    <Button onClick={() => createMutation.mutate(newInvoice)} disabled={createMutation.isPending}>
      {createMutation.isPending ? "Saving..." : "Create Invoice"}
    </Button>
  </DialogFooter>
</DialogContent>
      `;
      element.replaceWithText(newJsx);
      break;
    }
  }

  // Find the button inside the DialogTrigger and remove the toast onClick
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
console.log("Rewrite successful.");
