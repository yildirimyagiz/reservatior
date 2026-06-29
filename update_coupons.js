const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/financial/CouponsManagement.tsx');
let code = fs.readFileSync(file, 'utf8');

// Remove previously injected generic mutations
code = code.replace(/const updateMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const deleteMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const \[editingId, setEditingId\] = React\.useState<string \| null>\(null\);\n/, '');
code = code.replace(/import { useMutation, useQueryClient } from "@tanstack\/react-query";\nimport { apiClient } from "@\/lib\/api";\nimport { useToast } from "@\/hooks\/use-toast";\nimport { MoreHorizontal, Edit, Trash2 } from "lucide-react";\nimport { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@\/components\/ui\/dropdown-menu";\n/, '');

const realHooks = `
  const queryClient = useQueryClient();
  const { toast } = useToast();
  
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [editingCoupon, setEditingCoupon] = useState<any>(null);
  
  // Form State matches Discount Model
  const [formData, setFormData] = useState({
    name: '',
    code: '',
    value: 0,
    type: 'PERCENTAGE', // or FIXED
    maxUsage: 100,
    propertyId: '', // Ideally linked to a property
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => apiClient.post('/discount', data),
    onSuccess: () => {
      toast({ title: "Success", description: "Discount created successfully" });
      queryClient.invalidateQueries({ queryKey: ['admin-discounts'] });
      setCreateOpen(false);
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(\`/discount/\${data.id}\`, data),
    onSuccess: () => {
      toast({ title: "Updated", description: "Discount updated successfully" });
      queryClient.invalidateQueries({ queryKey: ['admin-discounts'] });
      setIsEditOpen(false);
      setEditingCoupon(null);
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(\`/discount/\${id}\`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Discount deleted successfully" });
      queryClient.invalidateQueries({ queryKey: ['admin-discounts'] });
    }
  });

  const handleEdit = (coupon: any) => {
    setEditingCoupon(coupon);
    setFormData({
      name: coupon.name || '',
      code: coupon.code || '',
      value: coupon.value || 0,
      type: coupon.type || 'PERCENTAGE',
      maxUsage: coupon.maxUsage || 100,
      propertyId: coupon.propertyId || ''
    });
    setIsEditOpen(true);
  };
`;

code = code.replace('const [createOpen, setCreateOpen] = useState(false);', 'const [createOpen, setCreateOpen] = useState(false);\n' + realHooks);

// The Dropdown menu replacement
code = code.replace(/<DropdownMenuItem>\s*<Edit className="w-4 h-4 mr-2" \/>[^<]+<\/DropdownMenuItem>/, 
  `<DropdownMenuItem onClick={() => handleEdit(c)}><Edit className="w-4 h-4 mr-2" />{t("admin.financial.edit", "Edit")}</DropdownMenuItem>`);

code = code.replace(/<DropdownMenuItem className="text-red-600">\s*<Trash2 className="w-4 h-4 mr-2" \/>[^<]+<\/DropdownMenuItem>/, 
  `<DropdownMenuItem onClick={() => deleteMutation.mutate(c.id)} className="text-red-600"><Trash2 className="w-4 h-4 mr-2" />{t("admin.financial.delete", "Delete")}</DropdownMenuItem>`);

// Add Edit Dialog at the end
const editDialog = `
      <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>{t("admin.financial.edit_coupon", "Edit Discount/Coupon")}</DialogTitle>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            <div className="grid gap-2">
              <Label htmlFor="edit-name">Name</Label>
              <Input id="edit-name" value={formData.name} onChange={e => setFormData({...formData, name: e.target.value})} />
            </div>
            <div className="grid gap-2">
              <Label htmlFor="edit-code">Code</Label>
              <Input id="edit-code" value={formData.code} onChange={e => setFormData({...formData, code: e.target.value})} />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="grid gap-2">
                <Label htmlFor="edit-value">Value</Label>
                <Input id="edit-value" type="number" value={formData.value} onChange={e => setFormData({...formData, value: parseFloat(e.target.value)})} />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="edit-type">Type</Label>
                <Select value={formData.type} onValueChange={v => setFormData({...formData, type: v})}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="PERCENTAGE">Percentage</SelectItem>
                    <SelectItem value="FIXED">Fixed Amount</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsEditOpen(false)}>{t("common.cancel", "Cancel")}</Button>
            <Button onClick={() => updateMutation.mutate({...formData, id: editingCoupon?.id})} disabled={updateMutation.isPending}>{t("common.save", "Save Changes")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
`;

code = code.replace('</PageShell>', editDialog + '\n    </PageShell>');

fs.writeFileSync(file, code);
