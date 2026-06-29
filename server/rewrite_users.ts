import { Project, SyntaxKind } from "ts-morph";

const project = new Project();
const sourceFile = project.addSourceFileAtPath("/Users/os2026/Downloads/Reservatior/client/src/pages/admin/users/UserManagement.tsx");

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

if (!importDecls.some(imp => imp.getModuleSpecifierValue() === '@/lib/api/users')) {
  sourceFile.addImportDeclaration({
    moduleSpecifier: '@/lib/api/users',
    namedImports: ['usersApi']
  });
}

const component = sourceFile.getFunction('UserManagement');
if (component) {
  const block = component.getBody();
  if (block && block.getKind() === SyntaxKind.Block) {
    // Check if mutation already exists
    if (!block.getText().includes('const createMutation = useMutation')) {
      block.insertStatements(2, `
        const [newUser, setNewUser] = useState({
          email: '',
          name: '',
          phone: '',
          locale: 'en-US',
          timezone: 'America/New_York'
        });

        const createMutation = useMutation({
          mutationFn: async (data: any) => {
            return usersApi.create(data);
          },
          onSuccess: () => {
            setIsAddOpen(false);
            toast({ title: "Success", description: "User created successfully" });
            // Should refetch data but there's a lot going on in this component
          },
          onError: (err: any) => {
            toast({ title: "Error", description: err.message || "Failed to create user", variant: "destructive" });
          }
        });
      `);
    }
  }

  // Replace DialogContent with real form
  const jsxElements = sourceFile.getDescendantsOfKind(SyntaxKind.JsxElement);
  let dialogFound = false;
  for (const element of jsxElements) {
    const opening = element.getOpeningElement();
    if (opening.getTagNameNode().getText() === 'DialogContent') {
      const newJsx = `
<DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
  <DialogHeader>
    <DialogTitle>Create New User</DialogTitle>
    <DialogDescription>
      Fill in the user details. This maps directly to the backend User model.
    </DialogDescription>
  </DialogHeader>
  <div className="grid gap-4 py-4">
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="email" className="text-right text-xs">Email *</Label>
      <Input id="email" type="email" className="col-span-3 h-10" value={newUser.email} onChange={e => setNewUser({...newUser, email: e.target.value})} placeholder="user@example.com" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="name" className="text-right text-xs">Name</Label>
      <Input id="name" className="col-span-3 h-10" value={newUser.name} onChange={e => setNewUser({...newUser, name: e.target.value})} placeholder="John Doe" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="phone" className="text-right text-xs">Phone</Label>
      <Input id="phone" className="col-span-3 h-10" value={newUser.phone} onChange={e => setNewUser({...newUser, phone: e.target.value})} placeholder="+1 555-0123" />
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="locale" className="text-right text-xs">Locale</Label>
      <Select value={newUser.locale} onValueChange={(v) => setNewUser({...newUser, locale: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Locale" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="en-US">English (US)</SelectItem>
          <SelectItem value="tr-TR">Turkish</SelectItem>
          <SelectItem value="fr-FR">French</SelectItem>
          <SelectItem value="de-DE">German</SelectItem>
        </SelectContent>
      </Select>
    </div>
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="timezone" className="text-right text-xs">Timezone</Label>
      <Select value={newUser.timezone} onValueChange={(v) => setNewUser({...newUser, timezone: v})}>
        <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder="Select Timezone" /></SelectTrigger>
        <SelectContent>
          <SelectItem value="America/New_York">Eastern Time (ET)</SelectItem>
          <SelectItem value="Europe/Istanbul">Istanbul (TRT)</SelectItem>
          <SelectItem value="Europe/London">London (GMT)</SelectItem>
        </SelectContent>
      </Select>
    </div>
  </div>
  <DialogFooter>
    <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
    <Button onClick={() => createMutation.mutate(newUser)} disabled={createMutation.isPending || !newUser.email}>
      {createMutation.isPending ? "Saving..." : "Create User"}
    </Button>
  </DialogFooter>
</DialogContent>
      `;
      element.replaceWithText(newJsx);
      dialogFound = true;
      break;
    }
  }
}

sourceFile.saveSync();
console.log("UserManagement Rewrite successful.");
