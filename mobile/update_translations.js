const fs = require('fs');

function updateJson(file, translations) {
  if (fs.existsSync(file)) {
    const data = JSON.parse(fs.readFileSync(file, 'utf-8'));
    if (!data.mobile) data.mobile = {};
    if (!data.mobile.profile) data.mobile.profile = {};
    Object.assign(data.mobile.profile, translations);
    fs.writeFileSync(file, JSON.stringify(data, null, 2));
  }
}

updateJson('assets/translations/en.json', {
  systemAdmin: "System Administration",
  adminModules: "Admin Modules Hub",
  adminModulesDesc: "Access to 150+ comprehensive admin modules"
});

updateJson('assets/translations/tr.json', {
  systemAdmin: "Sistem Yönetimi",
  adminModules: "Yönetim Modülleri Merkezi",
  adminModulesDesc: "150'den fazla kapsamlı yönetim modülüne erişim"
});
