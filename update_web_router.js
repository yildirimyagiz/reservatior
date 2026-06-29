const fs = require('fs');

let content = fs.readFileSync('client/src/router/index.tsx', 'utf8');

if (!content.includes('DynamicAdminPage')) {
  // Insert import at the top
  content = `import DynamicAdminPage from "@/pages/admin/dynamic/DynamicAdminPage";\n` + content;
  
  // Find where to insert the route
  // We saw: // Additional Admin Pages (around line 651)
  content = content.replace(
    /(\/\/ Additional Admin Pages)/,
    `$1\n          { path: "dynamic/:model", element: <DynamicAdminPage /> },`
  );
  
  fs.writeFileSync('client/src/router/index.tsx', content);
  console.log('Router updated.');
} else {
  console.log('Already updated.');
}
