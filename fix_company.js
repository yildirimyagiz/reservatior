const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/company/CompanyManagement.tsx');
let code = fs.readFileSync(file, 'utf8');

// Remove duplicate imports
code = code.replace(/import { useMutation, useQueryClient } from "@tanstack\/react-query";\nimport { apiClient } from "@\/lib\/api";\nimport { useToast } from "@\/hooks\/use-toast";\nimport { MoreHorizontal, Edit, Trash2 } from "lucide-react";\nimport { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@\/components\/ui\/dropdown-menu";\n/, '');

// Remove injected mutations that don't belong
code = code.replace(/const updateMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const deleteMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const \[editingId, setEditingId\] = React\.useState<string \| null>\(null\);\n/, '');

fs.writeFileSync(file, code);
