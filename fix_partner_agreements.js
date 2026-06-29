const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/agencies/PartnerAgreements.tsx');
let code = fs.readFileSync(file, 'utf8');

// Clean up duplicate imports
code = code.replace(/import { useMutation, useQueryClient } from "@tanstack\/react-query";\nimport { apiClient } from "@\/lib\/api";\nimport { useToast } from "@\/hooks\/use-toast";\n/, '');

// Delete the generic generic updateMutation because this file has transitionMutation
code = code.replace(/const updateMutation = useMutation\(\{[\s\S]*?\}\);/, '');

// Delete generic deleteMutation and fix endpointName error
code = code.replace(/const deleteMutation = useMutation\(\{[\s\S]*?\}\);/, '');

// Clean up duplicated state
code = code.replace(/const { toast } = useToast\(\);\n  const queryClient = useQueryClient\(\);\n  const \[editingId, setEditingId\] = React\.useState<string \| null>\(null\);\n/, '');

fs.writeFileSync(file, code);
