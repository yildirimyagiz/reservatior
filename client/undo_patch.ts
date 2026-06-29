import fs from 'fs';
import path from 'path';

const ADMIN_PAGES_DIR = path.join(__dirname, 'src', 'pages', 'admin');

function walkDir(dir: string, callback: (filePath: string) => void) {
    fs.readdirSync(dir).forEach(f => {
        const dirPath = path.join(dir, f);
        const isDirectory = fs.statSync(dirPath).isDirectory();
        if (isDirectory) {
            walkDir(dirPath, callback);
        } else if (f.endsWith('.tsx') || f.endsWith('.ts')) {
            callback(dirPath);
        }
    });
}

walkDir(ADMIN_PAGES_DIR, (filePath) => {
    let content = fs.readFileSync(filePath, 'utf-8');
    let modified = false;

    if (content.includes('onClick={() => { if(typeof updateMutation !== "undefined") { toast({title: "Edit mode triggered"}); } }}')) {
        content = content.replace(/onClick=\{\(\) => \{ if\(typeof updateMutation !== "undefined"\) \{ toast\(\{title: "Edit mode triggered"\}\); \} \}\} /g, '');
        modified = true;
    }

    if (content.includes('onClick={(e) => { e.stopPropagation(); if(typeof deleteMutation !== "undefined") { deleteMutation.mutate("item-id"); } else { toast({title: "Delete triggered", description: "Audit logged."}); } }}')) {
        content = content.replace(/onClick=\{\(e\) => \{ e\.stopPropagation\(\); if\(typeof deleteMutation !== "undefined"\) \{ deleteMutation\.mutate\("item-id"\); \} else \{ toast\(\{title: "Delete triggered", description: "Audit logged\."\}\); \} \}\} /g, '');
        modified = true;
    }

    if (modified) {
        fs.writeFileSync(filePath, content, 'utf-8');
        console.log(`Fixed: ${filePath}`);
    }
});
