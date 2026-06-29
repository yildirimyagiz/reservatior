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

const MODIFIED_FILES: string[] = [];

walkDir(ADMIN_PAGES_DIR, (filePath) => {
    let content = fs.readFileSync(filePath, 'utf-8');
    let modified = false;

    // Use a regex to match the entire injected block
    const injectedRegex = /\/\/ Injected standardized CRUD hooks[\s\S]*?onError: \(err: any\) => toast\(\{ title: "Error", description: err\.message, variant: "destructive" \}\)\n\s*\}\);\n\s*/g;
    
    if (injectedRegex.test(content)) {
        content = content.replace(injectedRegex, '');
        modified = true;
    }
    
    // Some files might only have had one mutation injected, let's catch them individually if needed
    const injectedRegexUpdate = /\/\/ Injected standardized CRUD hooks[\s\S]*?const updateMutation = useMutation\(\{[\s\S]*?onError: \(err: any\) => toast\(\{ title: "Error", description: err\.message, variant: "destructive" \}\)\n\s*\}\);\n\s*/g;
    const injectedRegexDelete = /\/\/ Injected standardized CRUD hooks[\s\S]*?const deleteMutation = useMutation\(\{[\s\S]*?onError: \(err: any\) => toast\(\{ title: "Error", description: err\.message, variant: "destructive" \}\)\n\s*\}\);\n\s*/g;

    if (injectedRegexUpdate.test(content)) {
        content = content.replace(injectedRegexUpdate, '');
        modified = true;
    }
    if (injectedRegexDelete.test(content)) {
        content = content.replace(injectedRegexDelete, '');
        modified = true;
    }

    if (modified) {
        fs.writeFileSync(filePath, content, 'utf-8');
        MODIFIED_FILES.push(filePath);
    }
});

console.log(`Reverted boilerplate in ${MODIFIED_FILES.length} files.`);
