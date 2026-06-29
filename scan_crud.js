const fs = require('fs');
const path = require('path');

const adminDir = path.join(__dirname, 'client/src/pages/admin');
const missingFiles = [];

function scanDir(dir) {
  const items = fs.readdirSync(dir);
  for (const item of items) {
    const fullPath = path.join(dir, item);
    const stat = fs.statSync(fullPath);
    if (stat.isDirectory()) {
      scanDir(fullPath);
    } else if (fullPath.endsWith('.tsx')) {
      const content = fs.readFileSync(fullPath, 'utf8');
      
      // We are looking for files that have a Table or list but are missing proper CRUD
      const hasDialog = content.includes('<Dialog');
      const hasCreate = content.includes('createMutation') || content.includes('post(');
      const hasUpdate = content.includes('updateMutation') || content.includes('put(') || content.includes('patch(');
      const hasDelete = content.includes('deleteMutation') || content.includes('delete(');
      
      // If it's a page that seems like a management page (has table/list) but missing full CRUD
      if (hasDialog && (!hasCreate || !hasUpdate || !hasDelete)) {
        missingFiles.push({
          file: fullPath.replace(adminDir + '/', ''),
          missing: [
            !hasCreate ? 'CREATE' : null,
            !hasUpdate ? 'UPDATE' : null,
            !hasDelete ? 'DELETE' : null
          ].filter(Boolean)
        });
      }
    }
  }
}

scanDir(adminDir);
console.log(JSON.stringify(missingFiles, null, 2));
