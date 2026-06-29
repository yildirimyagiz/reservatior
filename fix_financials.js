const fs = require('fs');
const path = require('path');
const targetFiles = [
  "EscrowManagement.tsx",
  "ExtraCharges.tsx",
  "Invoices.tsx",
  "Mortgages.tsx",
  "Payments.tsx",
  "Transactions.tsx"
];

targetFiles.forEach(fileName => {
  const file = path.join(__dirname, 'client/src/pages/admin/financial', fileName);
  if (!fs.existsSync(file)) return;
  
  let code = fs.readFileSync(file, 'utf8');

  // Remove injected generic mutations
  code = code.replace(/const updateMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
  code = code.replace(/const deleteMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
  code = code.replace(/const \[editingId, setEditingId\] = React\.useState<string \| null>\(null\);\n/, '');
  
  // Clean duplicate generic imports
  code = code.replace(/import { useMutation, useQueryClient } from "@tanstack\/react-query";\nimport { apiClient } from "@\/lib\/api";\nimport { useToast } from "@\/hooks\/use-toast";\nimport { MoreHorizontal, Edit, Trash2 } from "lucide-react";\nimport { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@\/components\/ui\/dropdown-menu";\n/, '');

  fs.writeFileSync(file, code);
});
console.log("Cleaned financial modules.");
