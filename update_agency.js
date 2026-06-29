const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/agencies/AgenciesManagement.tsx');
let code = fs.readFileSync(file, 'utf8');

// 1. Add Select imports
if (!code.includes('SelectContent')) {
  code = `import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";\n` + code;
}
if (!code.includes('useToast')) {
  code = `import { useToast } from "@/hooks/use-toast";\n` + code;
}

// 2. Add update mutation and edit state
const stateToInject = `
  const { toast } = useToast();
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => {
      return api.put(\`/agency/\${editingId}\`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
      setIsEditModalOpen(false);
      setEditingId(null);
      setNewAgency({ name: '', email: '', phoneNumber: '', status: 'ACTIVE', website: '' });
      toast({ title: "Success", description: "Agency updated successfully" });
    }
  });

  const handleEditClick = (agency: any) => {
    setEditingId(agency.id);
    setNewAgency({
      name: agency.name || '',
      email: agency.email || '',
      phoneNumber: agency.phoneNumber || '',
      status: agency.status || 'ACTIVE',
      website: agency.website || ''
    });
    setIsEditModalOpen(true);
  };
`;

code = code.replace(/const \[newAgency, setNewAgency\] = useState\([^)]+\);/, `const [newAgency, setNewAgency] = useState<any>({ name: '', email: '', phoneNumber: '', status: 'ACTIVE', website: '' });` + stateToInject);

// 3. Update the form to include Status and Website
const additionalFields = `
                <div className="space-y-2">
                  <Label htmlFor="website">Website</Label>
                  <Input 
                    id="website" 
                    className="bg-white/5 border-white/10" 
                    value={newAgency.website || ''}
                    onChange={e => setNewAgency({...newAgency, website: e.target.value})}
                  />
                </div>
                <div className="space-y-2">
                  <Label>Status</Label>
                  <Select value={newAgency.status} onValueChange={v => setNewAgency({...newAgency, status: v})}>
                    <SelectTrigger className="bg-white/5 border-white/10">
                      <SelectValue placeholder="Select status" />
                    </SelectTrigger>
                    <SelectContent className="bg-slate-900 border-white/10 text-white">
                      <SelectItem value="PENDING">Pending</SelectItem>
                      <SelectItem value="ACTIVE">Active</SelectItem>
                      <SelectItem value="INACTIVE">Inactive</SelectItem>
                      <SelectItem value="SUSPENDED">Suspended</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
`;
code = code.replace(/<div className="pt-4 flex justify-end gap-2">/, additionalFields + '\n                <div className="pt-4 flex justify-end gap-2">');

// 4. Also use the same form for Edit
const editModal = `
          <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
            <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>{t("admin.agencies.edit", "Edit Agency")}</DialogTitle>
              </DialogHeader>
              <form onSubmit={(e) => { e.preventDefault(); updateMutation.mutate(newAgency); }} className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label htmlFor="edit-name">Agency Name</Label>
                  <Input id="edit-name" className="bg-white/5 border-white/10" value={newAgency.name} onChange={e => setNewAgency({...newAgency, name: e.target.value})} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="edit-email">Email</Label>
                  <Input id="edit-email" type="email" className="bg-white/5 border-white/10" value={newAgency.email} onChange={e => setNewAgency({...newAgency, email: e.target.value})} />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="edit-phoneNumber">Phone Number</Label>
                  <Input id="edit-phoneNumber" className="bg-white/5 border-white/10" value={newAgency.phoneNumber} onChange={e => setNewAgency({...newAgency, phoneNumber: e.target.value})} />
                </div>
                <div className="space-y-2">
                  <Label>Status</Label>
                  <Select value={newAgency.status} onValueChange={v => setNewAgency({...newAgency, status: v})}>
                    <SelectTrigger className="bg-white/5 border-white/10"><SelectValue placeholder="Select status" /></SelectTrigger>
                    <SelectContent className="bg-slate-900 border-white/10 text-white">
                      <SelectItem value="PENDING">Pending</SelectItem>
                      <SelectItem value="ACTIVE">Active</SelectItem>
                      <SelectItem value="INACTIVE">Inactive</SelectItem>
                      <SelectItem value="SUSPENDED">Suspended</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="pt-4 flex justify-end gap-2">
                  <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>Cancel</Button>
                  <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={updateMutation.isPending}>
                    {updateMutation.isPending ? "Saving..." : "Update Agency"}
                  </Button>
                </div>
              </form>
            </DialogContent>
          </Dialog>
`;

code = code.replace('</Dialog>', '</Dialog>\n' + editModal);

// 5. Connect Edit Button
code = code.replace(/<Button variant="ghost" size="icon" className="text-slate-400 hover:text-white">\s*<Edit className="w-4 h-4" \/>\s*<\/Button>/, 
  `<Button variant="ghost" size="icon" className="text-slate-400 hover:text-white" onClick={() => handleEditClick(a)}><Edit className="w-4 h-4" /></Button>`);

fs.writeFileSync(file, code);
