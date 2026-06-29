const fs = require('fs');
const path = require('path');
const file = path.join(__dirname, 'client/src/pages/admin/documents/DocumentManagement.tsx');
let code = fs.readFileSync(file, 'utf8');

// Remove injected block
code = code.replace(/const updateMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const deleteMutation = useMutation\(\{[\s\S]*?\}\);\n/, '');
code = code.replace(/const \[editingId, setEditingId\] = React\.useState<string \| null>\(null\);\n/, '');

fs.writeFileSync(file, code);
