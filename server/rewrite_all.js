const fs = require('fs');
const path = require('path');

const targetFiles = [
  {
    path: "client/src/pages/admin/membership/MembershipManagement.tsx",
    endpoint: "/api/v1/memberships",
    entity: "Membership",
    fields: [ {name: 'userId', label: 'User ID'}, {name: 'planId', label: 'Plan ID'}, {name: 'status', label: 'Status'} ]
  },
  {
    path: "client/src/pages/admin/marketing/MarketingAutomation.tsx",
    endpoint: "/api/v1/marketing-campaigns",
    entity: "Campaign",
    fields: [ {name: 'name', label: 'Campaign Name'}, {name: 'type', label: 'Type'}, {name: 'status', label: 'Status'} ]
  },
  {
    path: "client/src/pages/admin/inventory/PropertyInventory.tsx",
    endpoint: "/api/v1/inventory",
    entity: "Inventory",
    fields: [ {name: 'propertyId', label: 'Property ID'}, {name: 'type', label: 'Type'}, {name: 'quantity', label: 'Quantity'} ]
  },
  {
    path: "client/src/pages/admin/system/SystemManagement.tsx",
    endpoint: "/api/v1/system-settings",
    entity: "Setting",
    fields: [ {name: 'key', label: 'Setting Key'}, {name: 'value', label: 'Setting Value'} ]
  },
  {
    path: "client/src/pages/admin/projects/ProjectDashboard.tsx",
    endpoint: "/api/v1/projects",
    entity: "Project",
    fields: [ {name: 'name', label: 'Project Name'}, {name: 'status', label: 'Status'}, {name: 'budget', label: 'Budget'} ]
  },
  {
    path: "client/src/pages/admin/financial/CommissionRules.tsx",
    endpoint: "/api/v1/commission-rules",
    entity: "Rule",
    fields: [ {name: 'name', label: 'Rule Name'}, {name: 'rate', label: 'Rate'}, {name: 'type', label: 'Type'} ]
  },
  {
    path: "client/src/pages/admin/invoices/CustomerInvoices.tsx",
    endpoint: "/api/v1/customer-invoices",
    entity: "Customer Invoice",
    fields: [ {name: 'customerId', label: 'Customer ID'}, {name: 'amount', label: 'Amount'}, {name: 'status', label: 'Status'} ]
  },
  {
    path: "client/src/pages/admin/financial/EscrowManagement.tsx",
    endpoint: "/api/v1/escrow",
    entity: "Escrow",
    fields: [ {name: 'transactionId', label: 'Transaction ID'}, {name: 'amount', label: 'Amount'}, {name: 'status', label: 'Status'} ]
  },
  {
    path: "client/src/pages/admin/financial/Commissions.tsx",
    endpoint: "/api/v1/commissions",
    entity: "Commission",
    fields: [ {name: 'agentId', label: 'Agent ID'}, {name: 'amount', label: 'Amount'}, {name: 'status', label: 'Status'} ]
  },
  {
    path: "client/src/pages/admin/property/AdminProperties.tsx",
    endpoint: "/api/v1/properties",
    entity: "Property",
    fields: [ {name: 'title', label: 'Title'}, {name: 'type', label: 'Property Type'}, {name: 'price', label: 'Price'} ]
  },
  {
    path: "client/src/pages/admin/dynamic/DynamicAdminPage.tsx",
    endpoint: "/api/v1/dynamic",
    entity: "Dynamic Record",
    fields: [ {name: 'name', label: 'Name'}, {name: 'type', label: 'Type'} ]
  }
];

const workspacePath = "/Users/os2026/Downloads/Reservatior";

targetFiles.forEach(target => {
  const fullPath = path.join(workspacePath, target.path);
  if (!fs.existsSync(fullPath)) {
    console.log("Not found:", fullPath);
    return;
  }

  let code = fs.readFileSync(fullPath, 'utf-8');

  // Inject imports if not present
  if (!code.includes('useMutation')) {
    code = `import { useMutation } from "@tanstack/react-query";\n` + code;
  }
  if (!code.includes('apiClient')) {
    code = `import { apiClient } from "@/lib/api";\n` + code;
  }
  if (!code.includes('useToast')) {
    code = `import { useToast } from "@/hooks/use-toast";\n` + code;
  }

  // Find the component function
  const match = code.match(/export (?:default )?(?:function|const) (\w+)(?:.*?)\s*({|=>\s*{)/);
  if (!match) {
    console.log("Could not find component in", target.path);
    return;
  }
  
  const componentName = match[1];
  const bracketIndex = match.index + match[0].length;

  // Insert mutation and state
  const defaultState = Object.fromEntries(target.fields.map(f => [f.name, '']));
  
  const stateAndMutation = `
  const { toast } = useToast();
  const [formData, setFormData] = React.useState(${JSON.stringify(defaultState)});

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await apiClient.post('${target.endpoint}', data);
      return res;
    },
    onSuccess: () => {
      setIsAddOpen(false);
      toast({ title: "Success", description: "${target.entity} created successfully" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });
  `;

  if (!code.includes('const createMutation = useMutation')) {
    code = code.slice(0, bracketIndex) + stateAndMutation + code.slice(bracketIndex);
  }

  // Replace DialogContent
  const dialogContentRegex = /<DialogContent[\s\S]*?<\/DialogContent>/g;
  
  const newDialogContent = `
<DialogContent className="sm:max-w-[425px] bg-card text-card-foreground">
  <DialogHeader>
    <DialogTitle>Create New ${target.entity}</DialogTitle>
    <DialogDescription>
      Enter the details for the new ${target.entity.toLowerCase()}.
    </DialogDescription>
  </DialogHeader>
  <div className="grid gap-4 py-4">
    ${target.fields.map(f => `
    <div className="grid grid-cols-4 items-center gap-4">
      <Label htmlFor="${f.name}" className="text-right text-xs">${f.label}</Label>
      <Input 
        id="${f.name}" 
        className="col-span-3 h-10" 
        value={formData.${f.name}} 
        onChange={e => setFormData({...formData, ${f.name}: e.target.value})} 
        placeholder="Enter ${f.label.toLowerCase()}" 
      />
    </div>`).join('')}
  </div>
  <DialogFooter>
    <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
    <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
      {createMutation.isPending ? "Saving..." : "Save Changes"}
    </Button>
  </DialogFooter>
</DialogContent>
  `;

  code = code.replace(dialogContentRegex, newDialogContent.trim());

  // Also add React import if needed
  if (!code.includes("import React")) {
    code = `import React from 'react';\n` + code;
  }

  fs.writeFileSync(fullPath, code);
  console.log("Rewrote", target.path);
});
