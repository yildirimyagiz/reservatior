const fs = require('fs');
const path = require('path');

const targetFiles = [
  "agencies/AgenciesManagement.tsx",
  "agencies/PartnerAgreements.tsx",
  "agents/AgentsManagement.tsx",
  "company/CompanyManagement.tsx",
  "documents/DocumentManagement.tsx",
  "financial/CouponsManagement.tsx",
  "financial/EscrowManagement.tsx",
  "financial/ExtraCharges.tsx",
  "financial/Invoices.tsx",
  "financial/Mortgages.tsx",
  "financial/Payments.tsx",
  "financial/Transactions.tsx",
  "invoices/CustomerInvoices.tsx",
  "marketing/MarketingAutomation.tsx",
  "membership/MembershipManagement.tsx",
  "organization/Organizations.tsx",
  "organization/SubscriptionManagement.tsx",
  "organization/UserManagement.tsx",
  "projects/ProjectDashboard.tsx",
  "property/AdminProperties.tsx",
  "property/PropertyPromotions.tsx",
  "reports/CustomReports.tsx",
  "reports/Reports.tsx",
  "reservations/Reservations.tsx",
  "security/AuditLogs.tsx",
  "security/SecurityEvents.tsx",
  "system/NotificationTemplates.tsx",
  "system/SystemManagement.tsx",
  "users/Organizations.tsx",
  "users/UserManagement.tsx",
  "users/Users.tsx",
  "vendors/VendorsManagement.tsx"
];

const workspacePath = path.join(__dirname, 'client/src/pages/admin');

targetFiles.forEach(target => {
  const fullPath = path.join(workspacePath, target);
  if (!fs.existsSync(fullPath)) return;

  let code = fs.readFileSync(fullPath, 'utf8');
  
  // 1. Add generic Imports if missing
  const requiredImports = `import { useMutation, useQueryClient } from "@tanstack/react-query";\nimport { apiClient } from "@/lib/api";\nimport { useToast } from "@/hooks/use-toast";\nimport { MoreHorizontal, Edit, Trash2 } from "lucide-react";\nimport { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";\n`;
  
  if (!code.includes('DropdownMenuTrigger')) {
    // find last import
    const lastImportIndex = code.lastIndexOf('import ');
    const endOfImport = code.indexOf('\n', lastImportIndex);
    code = code.slice(0, endOfImport + 1) + requiredImports + code.slice(endOfImport + 1);
  }

  // 2. Identify the Component
  const match = code.match(/export (?:default )?(?:function|const) (\w+)(?:.*?)\s*({|=>\s*{)/);
  if (!match) return;

  const bracketIndex = match.index + match[0].length;
  const endpointName = target.split('/').pop().replace('.tsx', '').toLowerCase();

  // 3. Inject State & Mutations
  const mutationsBlock = `
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [editingId, setEditingId] = React.useState<string | null>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(\`/api/v1/admin/\${endpointName}/\${data.id}\`, data),
    onSuccess: () => { toast({ title: "Updated", description: "Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(\`/api/v1/admin/\${endpointName}/\${id}\`),
    onSuccess: () => { toast({ title: "Deleted", description: "Record deleted successfully" }); queryClient.invalidateQueries(); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  `;

  if (!code.includes('updateMutation = useMutation')) {
    code = code.slice(0, bracketIndex) + mutationsBlock + code.slice(bracketIndex);
  }

  // 4. Inject Dropdown in TableCell
  // We look for </TableRow> inside <TableBody> and try to insert an Actions cell.
  // This is generic and might require manual fixing, but it sets up the structure.
  
  // We'll just replace </TableRow> inside map function with the DropdownMenu Cell
  const actionCell = `
    <TableCell>
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="ghost" className="h-8 w-8 p-0"><span className="sr-only">Open menu</span><MoreHorizontal className="h-4 w-4" /></Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end" className="bg-slate-900 border-white/10 text-white">
          <DropdownMenuItem onClick={() => setEditingId("generic_id_replace_me")} className="cursor-pointer hover:bg-white/10"><Edit className="mr-2 h-4 w-4" /> Edit</DropdownMenuItem>
          <DropdownMenuItem onClick={() => deleteMutation.mutate("generic_id_replace_me")} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </TableCell>
  </TableRow>`;

  // Only apply if it doesn't already have DropdownMenuTrigger
  if (!code.includes('<DropdownMenuTrigger') && code.includes('</TableRow>')) {
     // A simple regex to replace the last TableCell's closing or just before TableRow closing in the map
     // It's dangerous so we just do a simplistic replace on the first </TableRow> after <TableBody> map
     code = code.replace(/<\/TableRow>/g, (match, offset, string) => {
         // Only replace if it's likely inside the map (e.g., occurs after <TableBody>)
         if (offset > string.indexOf('<TableBody>')) {
             return actionCell;
         }
         return match;
     });
  }

  fs.writeFileSync(fullPath, code);
  console.log("Processed:", target);
});
console.log("Done");
