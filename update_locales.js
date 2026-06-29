const fs = require('fs');
const path = require('path');

const enPath = path.join(__dirname, 'client/src/locales/en.json');
const trPath = path.join(__dirname, 'client/src/locales/tr.json');

const en = JSON.parse(fs.readFileSync(enPath, 'utf8'));
const tr = JSON.parse(fs.readFileSync(trPath, 'utf8'));

const updates = {
  "admin.agencies.title": { en: "Agencies Management", tr: "Acente Yönetimi" },
  "admin.agencies.subtitle": { en: "Manage partner agencies and brokerages", tr: "Partner acenteleri ve brokerlıkları yönetin" },
  "admin.agents.title": { en: "Agent Management", tr: "Acente Yönetimi" },
  "admin.agents.subtitle": { en: "Monitor agent performance, licenses, and operational status", tr: "Acente performansını, lisanslarını ve durumunu izleyin" },
  "admin.ai.title": { en: "AI Services", tr: "Yapay Zeka Servisleri" },
  "admin.contacts.subtitle": { en: "Manage your business contacts and leads", tr: "İş bağlantılarınızı ve potansiyel müşterilerinizi yönetin" },
  "admin.facilities.subtitle": { en: "Manage properties facilities and amenities", tr: "Tesisleri ve olanakları yönetin" },
  "admin.financial.title": { en: "Financial Overview", tr: "Finansal Genel Bakış" },
  "admin.maintenance.orderTitle": { en: "Maintenance Orders", tr: "Bakım Talepleri" },
  "admin.maintenance.subtitle": { en: "Manage property maintenance and repair requests", tr: "Mülk bakım ve onarım taleplerini yönetin" },
  "admin.tasks.title": { en: "Tasks Management", tr: "Görev Yönetimi" },
  "admin.tasks.subtitle": { en: "Assign, track and manage system tasks", tr: "Sistem görevlerini atayın, takip edin ve yönetin" },
  "admin.vendors.subtitle": { en: "Manage third-party service providers", tr: "Üçüncü taraf hizmet sağlayıcılarını yönetin" },
  "client.property.portfolio.table.title": { en: "Property Portfolio Table", tr: "Mülk Portföyü Tablosu" },
  "client.property.portfolio.title": { en: "Property Portfolio", tr: "Mülk Portföyü" },
  "client.property.reservations.title": { en: "Reservations", tr: "Rezervasyonlar" },
  "client.property.reservationTracking.title": { en: "Reservation Tracking", tr: "Rezervasyon Takibi" },
  "client.property.valuations.dialog.title": { en: "Property Valuation", tr: "Mülk Değerlemesi" },
  "client.property.valuations.table.title": { en: "Valuations History", tr: "Değerleme Geçmişi" },
  "client.property.valuations.title": { en: "Property Valuations", tr: "Mülk Değerlemeleri" },
  "client.src.promotion.title": { en: "Promotions", tr: "Promosyonlar" },
  "hero.title": { en: "Welcome", tr: "Hoş Geldiniz" },
  "investors.portfolio.title": { en: "Investor Portfolio", tr: "Yatırımcı Portföyü" }
};

for (const [key, trans] of Object.entries(updates)) {
  if (en[key]) en[key] = trans.en;
  if (tr[key]) tr[key] = trans.tr;
}

fs.writeFileSync(enPath, JSON.stringify(en, null, 2) + '\n');
fs.writeFileSync(trPath, JSON.stringify(tr, null, 2) + '\n');
console.log('Locales updated successfully!');
