const fs = require('fs');
const file = '/Users/os2026/Downloads/Reservatior/client-seo/src/pages-spa/client/layout/AppLayout.tsx';
const lines = fs.readFileSync(file, 'utf8').split('\n');

let navStart = lines.findIndex(l => l.includes('interface NavItem {'));
let navEnd = lines.findIndex(l => l.startsWith('}];')) + 1;
let sidebarImport = lines.findIndex(l => l.includes('import Sidebar from "@/components/layout/Sidebar";'));

if (navStart > -1 && navEnd > -1) {
  lines.splice(navStart, navEnd - navStart);
}
if (sidebarImport > -1) {
  lines.splice(sidebarImport, 1);
}

let isActiveStart = lines.findIndex(l => l.includes('const isActive = (href?: string) => {'));
let filteredNavEnd = lines.findIndex(l => l.includes('return true;')) + 2;

if (isActiveStart > -1 && filteredNavEnd > isActiveStart) {
  lines.splice(isActiveStart, filteredNavEnd - isActiveStart);
}

let sidebarRender = lines.findIndex(l => l.includes('<Sidebar />'));
if (sidebarRender > -1) {
  lines.splice(sidebarRender, 1);
}

fs.writeFileSync(file, lines.join('\n'), 'utf8');
console.log('Fixed AppLayout.tsx');
