const fs = require('fs');
const path = require('path');

const l10nDir = path.join(__dirname, 'lib', 'l10n');
const files = ['app_en.arb', 'app_ar.arb', 'app_tr.arb'];

const dict = {
  "cleaning": { en: "Cleaning", ar: "تنظيف", tr: "Temizlik" },
  "commission": { en: "Commission", ar: "عمولة", tr: "Komisyon" },
  "insurance": { en: "Insurance", ar: "تأمين", tr: "Sigorta" },
  "maintenance": { en: "Maintenance", ar: "صيانة", tr: "Bakım" },
  "managementFee": { en: "Management Fee", ar: "رسوم الإدارة", tr: "Yönetim Ücreti" },
  "marketing": { en: "Marketing", ar: "تسويق", tr: "Pazarlama" },
  "other": { en: "Other", ar: "أخرى", tr: "Diğer" },
  "renovation": { en: "Renovation", ar: "تجديد", tr: "Renovasyon" },
  "repair": { en: "Repair", ar: "إصلاح", tr: "Tamirat" },
  "tax": { en: "Tax", ar: "ضريبة", tr: "Vergi" },
  "utilities": { en: "Utilities", ar: "مرافق", tr: "Fatura" },
  "abort": { en: "Cancel", ar: "إلغاء", tr: "İptal" },
  "accountDesc": { 
    en: "Configure your personal information and operational preferences", 
    ar: "قم بتكوين معلوماتك الشخصية وتفضيلاتك التشغيلية", 
    tr: "Kişisel bilgilerinizi ve operasyonel tercihlerinizi yapılandırın" 
  },
  "activeBookings": { 
    en: "Active Notifications", 
    ar: "إشعارات نشطة", 
    tr: "Aktif Bildirimler" 
  }
};

files.forEach(file => {
  const filePath = path.join(l10nDir, file);
  if (!fs.existsSync(filePath)) return;
  
  const lang = file.replace('app_', '').replace('.arb', '');
  let data = JSON.parse(fs.readFileSync(filePath, 'utf8'));

  for (let key in dict) {
    if (dict[key][lang]) {
      data[key] = dict[key][lang];
    }
  }

  fs.writeFileSync(filePath, JSON.stringify(data, null, 2) + '\n');
});

console.log('Mobile .arb files patched successfully.');
