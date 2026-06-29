const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/organization/Organizations.tsx');
let code = fs.readFileSync(file, 'utf8');

// Ensure we don't have duplicated useMutation imports
code = code.replace(/import { useMutation, useQueryClient } from "@tanstack\/react-query";\nimport { apiClient } from "@\/lib\/api";\nimport { useToast } from "@\/hooks\/use-toast";\nimport { MoreHorizontal, Edit, Trash2 } from "lucide-react";\nimport { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@\/components\/ui\/dropdown-menu";\n/, '');

// Delete the injected generic mutations
code = code.replace(/const updateMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const deleteMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const \[editingId, setEditingId\] = React\.useState<string \| null>\(null\);\n/, '');

// Inject real update/delete into Organizations component
const realMutations = `
  const queryClient = useQueryClient();
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const [editingOrg, setEditingOrg] = useState<any>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(\`/organization/\${data.id}\`, data),
    onSuccess: () => { 
      toast({ title: "Updated", description: "Organization updated successfully" }); 
      queryClient.invalidateQueries({ queryKey: ['admin-organizations'] }); 
      setIsEditDialogOpen(false); 
      setEditingOrg(null);
      fetchOrganizations();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(\`/organization/\${id}\`),
    onSuccess: () => { 
      toast({ title: "Deleted", description: "Organization deleted successfully" }); 
      fetchOrganizations();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const handleEdit = (org: any) => {
    setEditingOrg(org);
    setIsEditDialogOpen(true);
  };
`;

code = code.replace('const [searchTerm, setSearchTerm] = useState(\'\');', realMutations + '\n  const [searchTerm, setSearchTerm] = useState(\'\');');

// In DropdownMenuContent, replace the Edit and Delete buttons to use these
code = code.replace(/<DropdownMenuItem>\s*<Edit className="h-4 w-4 mr-2" \/>[^<]+<\/DropdownMenuItem>/, 
  `<DropdownMenuItem onClick={() => handleEdit(org)}><Edit className="h-4 w-4 mr-2" />{t("admin.organization.edit_organization")}</DropdownMenuItem>`);

code = code.replace(/<DropdownMenuItem className="text-red-600">\s*<Trash2 className="h-4 w-4 mr-2" \/>[^<]+<\/DropdownMenuItem>/, 
  `<DropdownMenuItem onClick={() => deleteMutation.mutate(org.id)} className="text-red-600"><Trash2 className="h-4 w-4 mr-2" />{t("admin.organization.delete_organization")}</DropdownMenuItem>`);

// Add Edit Dialog at the bottom of the component
const editDialog = `
          {/* Edit Dialog */}
          <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
            <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
              <DialogHeader>
                <DialogTitle>{t("admin.organization.edit_organization", "Edit Organization")}</DialogTitle>
              </DialogHeader>
              {editingOrg && (
                <div className="grid gap-4 py-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="grid gap-2">
                      <Label htmlFor="edit-name">{t("admin.organization.organization_name")}</Label>
                      <Input id="edit-name" value={editingOrg.name || ''} onChange={e => setEditingOrg({...editingOrg, name: e.target.value})} required />
                    </div>
                    <div className="grid gap-2">
                      <Label htmlFor="edit-domain">{t("admin.organization.domain")}</Label>
                      <Input id="edit-domain" value={editingOrg.domain || ''} onChange={e => setEditingOrg({...editingOrg, domain: e.target.value})} />
                    </div>
                  </div>
                  <div className="grid gap-2">
                    <Label htmlFor="edit-description">{t("admin.organization.description")}</Label>
                    <Input id="edit-description" value={editingOrg.description || ''} onChange={e => setEditingOrg({...editingOrg, description: e.target.value})} />
                  </div>
                </div>
              )}
              <DialogFooter>
                <Button onClick={() => updateMutation.mutate(editingOrg)} disabled={updateMutation.isPending}>{t("admin.organization.update_organization", "Update Organization")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
`;

code = code.replace('</PageShell>;', editDialog + '\n    </PageShell>;');

fs.writeFileSync(file, code);
