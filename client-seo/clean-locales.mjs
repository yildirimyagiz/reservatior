import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const LOCALES_DIR = path.join(__dirname, 'public', 'locales');

console.log("─────────────────────────────────────────────────────────────────────────────");
console.log("🌍 RESERVATIOR MULTI-LINGUAL SANITIZATION & PARITY SYNC ENGINE V2");
console.log("─────────────────────────────────────────────────────────────────────────────\n");

const files = fs.readdirSync(LOCALES_DIR).filter(f => f.endsWith('.json'));

const NEW_PARTNER_KEYS = {
  "en": {
    "partner_os.title": "Partner OS",
    "partner_os.subtitle": "Realtors · Brokers · %2 Rent Guarantee Underwriters · Bank Ecosystem",
    "partner_os.live": "ESCROW PROTECTED",
    "partner_os.partners_sub": "Realtors, Brokers, Underwriters & Banks",
    "partner_os.agreements_sub": "Co-Brokerage & Escrow Trust agreements",
    "partner_os.revenue_sub": "Revenue generated via partner commission splits",
    "insurance_os.banner": "Global 2% Rent Guarantee Underwriting Pool & Zero-Deposit Surety Bonds active across all lease agreements."
  },
  "tr": {
    "partner_os.title": "İş Ortağı OS (Partner OS)",
    "partner_os.subtitle": "Emlakçılar · Brokerlar · %2 Kira Güvence Fonu Kurumları · Bankacılık Ekosistemi",
    "partner_os.live": "ESCROW GÜVENCELİ",
    "partner_os.partners_sub": "Emlakçılar, Brokerlar, Sigorta Havuzu ve Bankalar",
    "partner_os.agreements_sub": "Co-Brokerage ve Escrow Güvence Sözleşmeleri",
    "partner_os.revenue_sub": "Partner komisyon paylaşımı ile üretilen hak ediş gelirleri",
    "insurance_os.banner": "Tüm kiralama sözleşmelerinde Küresel %2 Kira Güvence Havuzu ve Sıfır-Depozito Kefalet Senetleri etkindir."
  },
  "de": {
    "partner_os.title": "Partner OS",
    "partner_os.subtitle": "Immobilienmakler · Broker · 2% Mietgarantie-Versicherer · Banken-Ökosystem",
    "partner_os.live": "TREUHAND GESCHÜTZT",
    "partner_os.partners_sub": "Makler, Broker, Versicherer & Banken",
    "partner_os.agreements_sub": "Co-Brokerage & Treuhandvereinbarungen",
    "partner_os.revenue_sub": "Generierter Umsatz durch Provisionsaufteilung der Partner",
    "insurance_os.banner": "Globaler 2% Mietgarantie-Pool & Kautionsfreie Bürgschaften sind für alle Mietverträge aktiv."
  },
  "es": {
    "partner_os.title": "Partner OS",
    "partner_os.subtitle": "Agentes · Corredores · Aseguradoras de Garantía de Alquiler del 2% · Ecosistema Bancario",
    "partner_os.live": "PROTECCIÓN ESCROW",
    "partner_os.partners_sub": "Agentes, Corredores, Aseguradoras y Bancos",
    "partner_os.agreements_sub": "Acuerdos de Co-Brokerage y Fideicomiso Escrow",
    "partner_os.revenue_sub": "Ingresos generados mediante reparto de comisiones de socios",
    "insurance_os.banner": "Fondo Global de Garantía de Alquiler del 2% y Fianzas de Cero-Depósito activos en todos los contratos."
  },
  "fr": {
    "partner_os.title": "Partner OS",
    "partner_os.subtitle": "Agents · Courtiers · Assureurs de Garantie de Loyer 2% · Écosystème Bancaire",
    "partner_os.live": "PROTÉGÉ PAR ESCROW",
    "partner_os.partners_sub": "Agents immobiliers, Courtiers, Assureurs & Banques",
    "partner_os.agreements_sub": "Accords de Co-Courtage & Fiducie Escrow",
    "partner_os.revenue_sub": "Revenus générés via le partage des commissions partenaires",
    "insurance_os.banner": "Fonds Mondial de Garantie de Loyer de 2% et Cautions Sans-Dépôt actifs sur tous les baux."
  }
};

let totalJunkCleaned = 0;
let totalImportPathsRemoved = 0;

function isJunkKey(key) {
  const trimmed = key.trim();
  if (trimmed === "" || trimmed === "-" || trimmed === "--" || trimmed === "." || trimmed === ":" || trimmed === " -") {
    return { junk: true, reason: 'whitespace/symbol' };
  }
  if (!/[a-zA-Z0-9_\-/\.ãüşçöğıÁÉÍÓÚáéíóúüÜß]/.test(key) && key.length < 4) {
    return { junk: true, reason: 'symbol' };
  }
  // Purge file import path artifacts from careless regex scraper
  if (trimmed.startsWith('../') || trimmed.startsWith('./') || trimmed.startsWith('@/')) {
    return { junk: true, reason: 'import-path' };
  }
  return { junk: false };
}

for (const file of files) {
  const filePath = path.join(LOCALES_DIR, file);
  const langCode = file.replace('.json', '');
  
  try {
    const rawData = fs.readFileSync(filePath, 'utf8');
    const json = JSON.parse(rawData);
    let junkRemoved = 0;
    let importPathsRemoved = 0;

    const cleanedJson = {};
    for (const [key, val] of Object.entries(json)) {
      const check = isJunkKey(key);
      if (check.junk) {
        if (check.reason === 'import-path') {
          importPathsRemoved++;
          totalImportPathsRemoved++;
        } else {
          junkRemoved++;
          totalJunkCleaned++;
        }
        continue;
      }
      cleanedJson[key.trim()] = val;
    }

    const targetAdditions = NEW_PARTNER_KEYS[langCode] || NEW_PARTNER_KEYS["en"];
    for (const [newKey, newVal] of Object.entries(targetAdditions)) {
      cleanedJson[newKey] = newVal;
    }

    fs.writeFileSync(filePath, JSON.stringify(cleanedJson, null, 2), 'utf8');
    const finalCount = Object.keys(cleanedJson).length;

    console.log(`✅ [${langCode.toUpperCase().padEnd(2, ' ')}] Purged ${importPathsRemoved} ghost file imports & ${junkRemoved} symbols | Active Keys: ${finalCount}`);
  } catch (err) {
    console.error(`❌ Error processing file ${file}:`, err.message);
  }
}

console.log("\n─────────────────────────────────────────────────────────────────────────────");
console.log(`🎉 DEEP CLEAN COMPLETE: Purged ${totalImportPathsRemoved} ghost file import paths and ${totalJunkCleaned} junk symbols!`);
console.log("─────────────────────────────────────────────────────────────────────────────\n");
