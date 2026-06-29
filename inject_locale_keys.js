const fs = require('fs');
const path = require('path');

const keysToInject = {
  "mobile.admin.search_placeholder": "Search Admin Modules...",
  "mobile.admin.hub_title": "Admin Hub",
  "mobile.admin.modules_tab": "Modules",
  "mobile.admin.settings_tab": "Settings",
  "mobile.admin.general_settings": "General Settings",
  "mobile.admin.error_deleting": "Error deleting: {}",
  "mobile.admin.error_backend": "Error: {}\n\nEnsure backend endpoint exists.",
  "mobile.admin.schema_not_found": "Schema not found.",
  "mobile.admin.data": "Data",
  "mobile.admin.no_records_found": "No records found.",
  "mobile.admin.delete": "Delete",
  "mobile.admin.add_feature_coming_soon": "Add feature coming soon via dynamic schema!",
  "mobile.admin.categories.users": "Users",
  "mobile.admin.categories.financials": "Financials",
  "mobile.admin.categories.system": "System",
  "mobile.admin.categories.properties": "Properties",
  "mobile.admin.categories.operations": "Operations"
};

// Also let's scrape the _allModules from admin_hub_screen.dart to get all module titles
const adminHub = fs.readFileSync('mobile/lib/features/admin/admin_hub_screen.dart', 'utf8');
const moduleRegex = /'title':\s*'mobile\.admin\.modules\.([^']+)'\.tr\(\)/g;
let match;
while ((match = moduleRegex.exec(adminHub)) !== null) {
  const key = `mobile.admin.modules.${match[1]}`;
  const englishVal = match[1].split('_').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ');
  keysToInject[key] = englishVal;
}

const targetDirs = [
  'client/src/locales',
  'mobile/assets/translations'
];

targetDirs.forEach(dir => {
  if (fs.existsSync(dir)) {
    const files = fs.readdirSync(dir).filter(f => f.endsWith('.json'));
    files.forEach(file => {
      const p = path.join(dir, file);
      try {
        let json = JSON.parse(fs.readFileSync(p, 'utf8'));
        let modified = false;
        for (const [k, v] of Object.entries(keysToInject)) {
          if (!json[k]) {
            json[k] = v;
            modified = true;
          }
        }
        if (modified) {
          fs.writeFileSync(p, JSON.stringify(json, null, 2));
          console.log(`Updated ${p}`);
        }
      } catch (e) {
        console.error(`Failed parsing ${p}:`, e.message);
      }
    });
  }
});

