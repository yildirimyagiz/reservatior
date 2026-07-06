const fs = require('fs');

const trPath = 'src/locales/tr.json';
const enPath = 'src/locales/en.json';

let tr = JSON.parse(fs.readFileSync(trPath, 'utf8'));
let en = JSON.parse(fs.readFileSync(enPath, 'utf8'));

const newKeysTr = {
  "plan_desc": "İhtiyaçlarınıza özel gelişmiş yönetim paneli.",
  "prop_limit_10": "10 Mülke Kadar Portföy Yönetimi",
  "prop_limit_25": "25 Mülke Kadar Portföy Yönetimi",
  "prop_limit_50": "50 Mülke Kadar Portföy Yönetimi",
  "prop_limit_100": "100 Mülke Kadar Portföy Yönetimi",
  "prop_limit_unlimited": "Sınırsız Mülk & Portföy Yönetimi",
  "user_access_1": "1 Kullanıcı Erişimi",
  "user_access_3": "3 Kullanıcı Erişimi",
  "user_access_5": "5 Kullanıcı Erişimi",
  "user_access_10": "10 Kullanıcı Erişimi",
  "listing_limit_25": "25 Aktif İlan Limiti",
  "listing_limit_100": "100 Aktif İlan Limiti",
  "listing_limit_250": "250 Aktif İlan Limiti",
  "listing_limit_500": "500 Aktif İlan Limiti",
  "listing_limit_unlimited": "Sınırsız İlan Yayını",
  "support_email": "Standart E-posta Desteği",
  "support_24_7": "7/24 Öncelikli Canlı Destek",
  "ai_analysis": "Yapay Zeka Destekli Analiz",
  "custom_erp": "Özel Entegrasyonlar ve ERP",
  "get_started": "Başlayın",
  "contact_sales": "SATIŞ İLE İLETİŞİME GEÇ",
  "badge_optimized": "Optimize Edilmiş Seçim",
  "badge_enterprise": "Kurumsal",
  "tab_hotel": "OTEL YÖNETİMİ",
  "tab_apartment": "DAİRE PORTFÖYÜ",
  "tab_commission": "KOMİSYON MODELİ",
  "discount_notice": "Sektör Ortalamasına Göre %25 Net Avantaj!",
  "commission_notice": "1 Ay Ücretsiz Deneme Hesaplarında Bile %3.5 - %3.5 Komisyon Modelimiz Sabittir."
};

const newKeysEn = {
  "plan_desc": "Advanced management panel tailored to your needs.",
  "prop_limit_10": "Portfolio Management up to 10 Properties",
  "prop_limit_25": "Portfolio Management up to 25 Properties",
  "prop_limit_50": "Portfolio Management up to 50 Properties",
  "prop_limit_100": "Portfolio Management up to 100 Properties",
  "prop_limit_unlimited": "Unlimited Property & Portfolio Management",
  "user_access_1": "1 User Access",
  "user_access_3": "3 Users Access",
  "user_access_5": "5 Users Access",
  "user_access_10": "10 Users Access",
  "listing_limit_25": "25 Active Listings Limit",
  "listing_limit_100": "100 Active Listings Limit",
  "listing_limit_250": "250 Active Listings Limit",
  "listing_limit_500": "500 Active Listings Limit",
  "listing_limit_unlimited": "Unlimited Listings",
  "support_email": "Standard Email Support",
  "support_24_7": "24/7 Priority Live Support",
  "ai_analysis": "AI-Powered Analysis",
  "custom_erp": "Custom Integrations and ERP",
  "get_started": "Get Started",
  "contact_sales": "CONTACT SALES",
  "badge_optimized": "Optimized Choice",
  "badge_enterprise": "Enterprise",
  "tab_hotel": "HOTEL MANAGEMENT",
  "tab_apartment": "APARTMENT PORTFOLIO",
  "tab_commission": "COMMISSION MODEL",
  "discount_notice": "25% Net Advantage Compared to Industry Average!",
  "commission_notice": "Our 3.5% - 3.5% Commission Model is Fixed Even for 1-Month Free Trial Accounts."
};

if (!tr.client.src.plans) tr.client.src.plans = {};
if (!en.client.src.plans) en.client.src.plans = {};

Object.assign(tr.client.src.plans, newKeysTr);
Object.assign(en.client.src.plans, newKeysEn);

fs.writeFileSync(trPath, JSON.stringify(tr, null, 2));
fs.writeFileSync(enPath, JSON.stringify(en, null, 2));

console.log("Locales updated!");
