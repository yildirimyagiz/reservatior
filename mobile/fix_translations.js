const fs = require('fs');
const path = require('path');

const trKeys = {
  "mobile.auto.coming_soon": "Çok Yakında",
  "mobile.auto.module_under_construction": "Bu Modül Yapım Aşamasındadır",
  "mobile.auto.module_path_not_found": "Geliştirme süreci devam ediyor: {}",
  "mobile.auto.back_to_features": "Modüllere Geri Dön"
};

const enKeys = {
  "mobile.auto.coming_soon": "Coming Soon",
  "mobile.auto.module_under_construction": "This Module is Under Construction",
  "mobile.auto.module_path_not_found": "Development in progress: {}",
  "mobile.auto.back_to_features": "Back to Features"
};

function addKeys(filePath, newKeys) {
  if (fs.existsSync(filePath)) {
    const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    for (const [k, v] of Object.entries(newKeys)) {
      data[k] = v;
    }
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), 'utf8');
    console.log(`Updated ${path.basename(filePath)}`);
  }
}

addKeys('assets/translations/tr.json', trKeys);
addKeys('assets/translations/en.json', enKeys);
