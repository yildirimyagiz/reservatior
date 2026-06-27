import prismaManager from '../src/lib/prisma';
import * as XLSX from 'xlsx';
import * as fs from 'fs';
import * as path from 'path';

const DATA_DIR = '/root/reservatior/server/data/TURKİYE';

// ---------- Types ----------
interface ColumnMapping {
  name?: string;
  daireNo?: string;
  blok?: string;
  kat?: string;
  m2?: string;
  brütM2?: string;
  tip?: string;
  phone?: string;
  email?: string;
  notes?: string;
  ada?: string;
  parsel?: string;
  bagimsiz?: string;
  skipPrefixes?: string[];
}

interface ProjectConfig {
  id: string;
  orgId: string;
  name: string;
  description: string;
  address: string;
  filePath: string;
  csvSep?: string;
  mapping: ColumnMapping;
  defaults: Record<string, any>;
}

// ---------- Helpers ----------
function readRows(filePath: string, sep = ';'): Record<string, string>[] {
  const ext = path.extname(filePath).toLowerCase();
  if (ext === '.csv') {
    const content = fs.readFileSync(filePath, 'utf8');
    const lines = content.split(/\r?\n/).filter((l: string) => l.trim());
    if (lines.length === 0) return [];
    const actualSep = sep || (lines[0].includes(';') ? ';' : ',');
    const headers = lines[0].split(actualSep).map((h: string) => h.trim());
    return lines.slice(1).map(line => {
      const vals = line.split(actualSep);
      const row: Record<string, string> = {};
      headers.forEach((h, i) => { row[h] = vals[i]?.trim() || ''; });
      return row;
    });
  }

  // Excel
  const workbook = XLSX.readFile(filePath, { type: 'file' });
  const sheetName = workbook.SheetNames[0];
  if (!sheetName) return [];
  const sheet = workbook.Sheets[sheetName];
  const json = XLSX.utils.sheet_to_json<any>(sheet, { defval: '' });
  return json.map((r: any) => {
    const row: Record<string, string> = {};
    for (const [k, v] of Object.entries(r)) {
      row[String(k).trim()] = String(v ?? '').trim();
    }
    return row;
  });
}

function findColumn(row: Record<string, string>, candidates: string[]): string | undefined {
  for (const c of candidates) {
    const found = Object.keys(row).find(k =>
      k.toLowerCase().includes(c.toLowerCase())
    );
    if (found) return found;
  }
  return undefined;
}

function parseIntVal(v: string | undefined): number {
  if (!v) return 0;
  const m = v.match(/(\d+)/);
  return m ? parseInt(m[1]) : 0;
}

function parseFloatVal(v: string | undefined): number {
  if (!v) return 0;
  const cleaned = v.replace(/\./g, '').replace(',', '.');
  const m = cleaned.match(/(\d+(?:\.\d+)?)/);
  return m ? parseFloat(m[1]) : 0;
}

// ---------- Import logic ----------
async function importProject(prisma: any, cfg: ProjectConfig) {
  console.log(`\n${'='.repeat(60)}`);
  console.log(`📦 ${cfg.name}`);
  console.log(`   File: ${path.basename(cfg.filePath)}`);

  if (!fs.existsSync(cfg.filePath)) {
    console.log(`   ⚠️  Dosya bulunamadı, atlanıyor`);
    return;
  }

  const rows = readRows(cfg.filePath, cfg.csvSep);
  if (rows.length === 0) {
    console.log(`   ⚠️  Boş dosya, atlanıyor`);
    return;
  }

  console.log(`   ${rows.length} satır okundu`);

  // Ensure project exists
  await prisma.project.upsert({
    where: { id: cfg.id },
    update: { name: cfg.name },
    create: {
      id: cfg.id,
      orgId: cfg.orgId,
      name: cfg.name,
      description: cfg.description,
      projectType: cfg.defaults.projectType || 'RESIDENTIAL',
      status: 'COMPLETED',
      address: cfg.address,
      budget: cfg.defaults.budget || 100000000,
      currency: cfg.defaults.currency || 'TRY',
    }
  });

  const m = cfg.mapping;
  let success = 0, fail = 0;

  for (const row of rows) {
    // Find daireNo
    let daireNo = '';
    if (m.daireNo) {
      daireNo = row[m.daireNo] || '';
    }
    if (!daireNo) {
      // Try to find any column that looks like a unit number
      const candidates = ['NO', 'No', 'no', 'DAİRE NO', 'DAIRE NO', 'Daire No', 'KAPI NO', 'KAPİ NO', 'BB_NO', 'KONUT NO', 'BAĞIMSIZ', 'BAGIMSIZ'];
      for (const c of candidates) {
        if (row[c]) { daireNo = row[c]; break; }
      }
    }
    if (!daireNo) {
      // Try numerical columns
      for (const [k, v] of Object.entries(row)) {
        if (/^\d+$/.test(v) && v.length < 6 && !k.toLowerCase().includes('tel') && !k.toLowerCase().includes('gsm')) {
          daireNo = v;
          break;
        }
      }
    }
    // Generate a unique ID based on row hash if no daireNo
    const propId = daireNo
      ? `prop_${cfg.id.replace('proj_', '')}_${daireNo}`
      : `prop_${cfg.id.replace('proj_', '')}_${Buffer.from(JSON.stringify(row)).toString('base64').slice(0, 12)}`;

    if (!daireNo) {
      // Skip completely empty rows
      const hasData = Object.values(row).some(v => v);
      if (!hasData) continue;
    }

    // Owner name
    let ownerName = 'GİZLİ YATIRIMCI';
    if (m.name) {
      ownerName = row[m.name] || ownerName;
    }
    if (ownerName === 'GİZLİ YATIRIMCI') {
      // Try to find a name column
      const nameCandidates = ['Ad Soyad', 'AD SOYAD', 'İsim Soyisim', 'Müşteri Adı', 'MÜŞTERİ ADI', 'Ev Sahibi', 'Mal Sahibi', 'MAL_SAHIBI', 'İSİM', 'AD', 'Adı', 'Adı Soyadı', 'Açıklama'];
      for (const c of nameCandidates) {
        if (row[c] && row[c].length > 2) { ownerName = row[c]; break; }
      }
    }

    // Block
    let blok = '';
    if (m.blok) blok = row[m.blok] || '';
    if (!blok) {
      const blokCandidates = ['BLOK', 'Blok', 'BLOK ADI', 'Blok Adı', 'Blok No', 'KULE'];
      for (const c of blokCandidates) {
        if (row[c]) { blok = row[c]; break; }
      }
    }

    // Type
    let tip = '';
    if (m.tip) tip = row[m.tip] || '';
    if (!tip) {
      const tipCandidates = ['TİP', 'Tip', 'KULLANIM ŞEKLİ', 'Kullanış Şekli', 'DAIRE_TIPI', 'DAİRE TİPİ', 'CİNS', 'NİTELİK'];
      for (const c of tipCandidates) {
        if (row[c]) { tip = row[c]; break; }
      }
    }

    // Floor
    let kat = 0;
    if (m.kat) {
      kat = parseIntVal(row[m.kat]);
    }
    if (!kat) {
      const katCandidates = ['KAT', 'Kat', 'BULUNDUGU_KAT', 'Bulunduğu Kat', 'KAT NO'];
      for (const c of katCandidates) {
        if (row[c]) { kat = parseIntVal(row[c]); break; }
      }
    }

    // Area
    let m2 = 0;
    if (m.m2) m2 = parseFloatVal(row[m.m2]);
    if (!m2 && m.brütM2) m2 = parseFloatVal(row[m.brütM2]);
    if (!m2) {
      const m2Candidates = ['M2', 'ALAN', 'YÜZÖLÇÜMÜ', 'YUZOLCUMU', 'BRÜT M2', 'BRUT M2', 'NET M2', 'm2', 'm²'];
      for (const c of m2Candidates) {
        if (row[c]) { m2 = parseFloatVal(row[c]); break; }
      }
    }

    // Ada/Parsel
    let ada = '';
    if (m.ada) ada = row[m.ada] || '';
    let parsel = '';
    if (m.parsel) parsel = row[m.parsel] || '';
    let bagimsiz = '';
    if (m.bagimsiz) bagimsiz = row[m.bagimsiz] || '';

    // Notes
    const notesParts: string[] = [];
    if (ownerName) notesParts.push(`Sahibi: ${ownerName}`);
    if (blok) notesParts.push(`Blok: ${blok}`);
    if (tip) notesParts.push(`Tip: ${tip}`);
    if (ada) notesParts.push(`Ada: ${ada}`);
    if (parsel) notesParts.push(`Parsel: ${parsel}`);
    if (bagimsiz) notesParts.push(`Bağımsız: ${bagimsiz}`);
    if (m.notes && row[m.notes]) notesParts.push(row[m.notes]);

    // Build address
    const addrParts = [cfg.address];
    if (blok) addrParts.push(`Blok ${blok}`);
    if (daireNo) addrParts.push(`Daire ${daireNo}`);

    const isCommercial = tip && (tip.toLowerCase().includes('ofis') || tip.toLowerCase().includes('dükkan') || tip.toLowerCase().includes('mağaza') || tip.toLowerCase().includes('ticari'));
    const propertyCategory = isCommercial ? 'COMMERCIAL' : (cfg.defaults.propertyCategory || 'RESIDENTIAL');
    const type = isCommercial ? 'COMMERCIAL' : (cfg.defaults.type || 'APARTMENT');

    const displayName = blok
      ? `${cfg.name} - Blok ${blok} - ${daireNo || 'Unit'}`
      : `${cfg.name} - ${daireNo || 'Unit'}`;

    try {
      await prisma.property.upsert({
        where: { id: propId },
        update: { name: displayName },
        create: {
          id: propId,
          orgId: cfg.orgId,
          name: displayName,
          type,
          region: 'TR',
          currency: 'TRY',
          addressLine1: addrParts.join(', '),
          city: 'Istanbul',
          state: cfg.defaults.state || 'İstanbul',
          country: 'TR',
          daireNo: daireNo || propId,
          site_ici: cfg.defaults.site_ici ?? true,
          kat,
          areaSqm: m2 || cfg.defaults.areaSqm || 0,
          yearBuilt: cfg.defaults.yearBuilt || 2015,
          propertyCategory,
          listingType: cfg.defaults.listingType || 'SALE',
          listingStatus: cfg.defaults.listingStatus || 'SOLD',
          guvenlik: cfg.defaults.guvenlik ?? true,
          otopark: cfg.defaults.otopark ?? true,
          havuz: cfg.defaults.havuz ?? true,
          spor_salonu: cfg.defaults.spor_salonu ?? true,
          notes: notesParts.join('\n'),
          projects: { connect: { id: cfg.id } }
        }
      });
      success++;
    } catch (e: any) {
      fail++;
      console.error(`   ❌ ${daireNo || '?'}: ${e.message?.substring(0, 120)}`);
    }
  }

  console.log(`   ✅ ${success} başarılı, ${fail} başarısız (${rows.length} satırdan)`);
  return { success, fail };
}

// ---------- Project Configurations ----------
const ORG_ID = 'tr_residence_org';

function p(path: string): ProjectConfig[] {
  // Helper to create project configs with different file variations
  // Each returns an array so we can try multiple files
  return [];
}

const PROJECTS: ProjectConfig[] = [
  // ---- BELLEVUE ----
  {
    id: 'proj_BELLEVUE',
    orgId: ORG_ID,
    name: 'Bellevue Residence',
    description: 'Bellevue Residence in İstanbul',
    address: 'Bellevue Residence, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'Bellevue.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      kat: 'Kat',
      m2: 'm2',
      phone: 'Telefon',
    },
    defaults: { yearBuilt: 2014, state: 'Beşiktaş' }
  },

  // ---- UPCITY FLATS ----
  {
    id: 'proj_UPCITY_FLATS',
    orgId: ORG_ID,
    name: 'Upcity Flats Kartal',
    description: 'Upcity Flats in Kartal, İstanbul',
    address: 'Kartal/İstanbul',
    filePath: path.join(DATA_DIR, 'Upcity FLATS  KARTAL (379).xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      kat: 'Kat',
      m2: 'm2',
      phone: 'Telefon',
    },
    defaults: { yearBuilt: 2023, state: 'Kartal' }
  },

  // ---- UPCITY RESIDENCE ----
  {
    id: 'proj_UPCITY_RESIDENCE',
    orgId: ORG_ID,
    name: 'Upcity Residence Kartal',
    description: 'Upcity Residence in Kartal, İstanbul',
    address: 'Kartal/İstanbul',
    filePath: path.join(DATA_DIR, 'Upcity RESİDANCE(306).xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      kat: 'Kat',
      m2: 'm2',
    },
    defaults: { yearBuilt: 2023, state: 'Kartal' }
  },

  // ---- TEMA İSTANBUL ----
  {
    id: 'proj_TEMA_ISTANBUL',
    orgId: ORG_ID,
    name: 'Tema İstanbul',
    description: 'Tema İstanbul residences',
    address: 'Tema İstanbul, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'Tema İstanbul 1459 kisi.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      phone: 'Telefon',
    },
    defaults: { yearBuilt: 2023, state: 'Başakşehir' }
  },

  // ---- BATIŞEHİR ----
  {
    id: 'proj_BATISEHIR',
    orgId: ORG_ID,
    name: 'Batışehir Konutları',
    description: 'Batışehir daire sahipleri',
    address: 'Batışehir, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'BATIŞEHİR DAİRE SAHİPLERİ.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      kat: 'Kat',
    },
    defaults: { yearBuilt: 2020, state: 'Başakşehir' }
  },

  // ---- METROPOL (1) ----
  {
    id: 'proj_METROPOL',
    orgId: ORG_ID,
    name: 'Metropol İstanbul',
    description: 'Metropol İstanbul residences',
    address: 'Metropol İstanbul, Ataşehir/İstanbul',
    filePath: path.join(DATA_DIR, 'METROPOL 16,03,2018-2.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      phone: 'Telefon',
    },
    defaults: { yearBuilt: 2018, state: 'Ataşehir' }
  },

  // ---- METROPOL GÜNCEL ----
  {
    id: 'proj_METROPOL_GUN',
    orgId: ORG_ID,
    name: 'Metropol İstanbul (Güncel)',
    description: 'Metropol İstanbul güncel liste',
    address: 'Metropol İstanbul, Ataşehir/İstanbul',
    filePath: path.join(DATA_DIR, 'metropol güncel.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2018, state: 'Ataşehir' }
  },

  // ---- MASHATTAN ----
  {
    id: 'proj_MASHATTAN',
    orgId: ORG_ID,
    name: 'Mashattan',
    description: 'Mashattan residence in Maslak',
    address: 'Mashattan, Maslak/İstanbul',
    filePath: path.join(DATA_DIR, 'Mashattan Liste.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      phone: 'Telefon',
    },
    defaults: { yearBuilt: 2018, state: 'Sarıyer' }
  },

  // ---- TERRACE FULYA ----
  {
    id: 'proj_TERRACE_FULYA',
    orgId: ORG_ID,
    name: 'Terrace Fulya',
    description: 'Terrace Fulya residence in Şişli',
    address: 'Terrace Fulya, Fulya/Şişli/İstanbul',
    filePath: path.join(DATA_DIR, 'TERRACE_FULYA.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2020, state: 'Şişli' }
  },

  // ---- VADİ İSTANBUL ----
  {
    id: 'proj_VADI_ISTANBUL',
    orgId: ORG_ID,
    name: 'Vadi İstanbul',
    description: 'Vadi İstanbul residences',
    address: 'Vadi İstanbul, Başakşehir/İstanbul',
    filePath: path.join(DATA_DIR, 'Vadi istanbul.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2020, state: 'Başakşehir' }
  },

  // ---- ECLIPSE ----
  {
    id: 'proj_ECLIPSE',
    orgId: ORG_ID,
    name: 'Eclipse Residence',
    description: 'Eclipse Residence in Maslak',
    address: 'Eclipse Residence, Maslak/İstanbul',
    filePath: path.join(DATA_DIR, 'eclipse 2018.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2018, state: 'Sarıyer' }
  },

  // ---- TRUMP (güncel) ----
  {
    id: 'proj_TRUMP',
    orgId: ORG_ID,
    name: 'Trump Towers İstanbul',
    description: 'Trump Towers residences in Mecidiyeköy',
    address: 'Trump Towers, Mecidiyeköy/Şişli/İstanbul',
    filePath: path.join(DATA_DIR, 'Trump Price List Updated.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      kat: 'Kat',
      m2: 'm2',
    },
    defaults: { yearBuilt: 2012, state: 'Şişli' }
  },

  // ---- TRUMP 2 ----
  {
    id: 'proj_TRUMP2',
    orgId: ORG_ID,
    name: 'Trump Towers İstanbul (2)',
    description: 'Trump Towers price list 2',
    address: 'Trump Towers, Mecidiyeköy/Şişli/İstanbul',
    filePath: path.join(DATA_DIR, 'Trump Price List Updated 2.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2012, state: 'Şişli' }
  },

  // ---- SKYLAND ----
  {
    id: 'proj_SKYLAND',
    orgId: ORG_ID,
    name: 'Skyland Residence',
    description: 'Skyland Residence in Seyrantepe',
    address: 'Skyland, Seyrantepe/İstanbul',
    filePath: path.join(DATA_DIR, 'SKYLAND 15 BBS.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2020, state: 'Sarıyer' }
  },

  // ---- SKYLAND 2 ----
  {
    id: 'proj_SKYLAND2',
    orgId: ORG_ID,
    name: 'Skyland (Diğer)',
    description: 'Skyland residence ek liste',
    address: 'Skyland, Seyrantepe/İstanbul',
    filePath: path.join(DATA_DIR, 'skyland.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2020, state: 'Sarıyer' }
  },

  // ---- NISH ADALAR (535) ----
  {
    id: 'proj_NISH_ADALAR',
    orgId: ORG_ID,
    name: 'Nish Adalar',
    description: 'Nish Adalar residences on Adalar',
    address: 'Nish Adalar, Adalar/İstanbul',
    filePath: path.join(DATA_DIR, 'nish adalar 535 kişi.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2022, state: 'Adalar' }
  },

  // ---- NISH ADALAR (795) ----
  {
    id: 'proj_NISH_ADALAR_795',
    orgId: ORG_ID,
    name: 'Nish Adalar (795)',
    description: 'Nish Adalar 795 kişi listesi',
    address: 'Nish Adalar, Adalar/İstanbul',
    filePath: path.join(DATA_DIR, 'nish adalar 795 kişi.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2022, state: 'Adalar' }
  },

  // ---- NISH ADALAR (236) ----
  {
    id: 'proj_NISH_ADALAR_236',
    orgId: ORG_ID,
    name: 'Nish Adalar (Müşteri Data)',
    description: 'Nish Adalar müşteri data 236 adet',
    address: 'Nish Adalar, Adalar/İstanbul',
    filePath: path.join(DATA_DIR, 'nish adalar müşteri data-236 adet.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      phone: 'Telefon',
    },
    defaults: { yearBuilt: 2022, state: 'Adalar' }
  },

  // ---- UPHILL COURT ----
  {
    id: 'proj_UPHILL_COURT',
    orgId: ORG_ID,
    name: 'Uphill Court Bahçeşehir',
    description: 'Uphill Court Bahçeşehir kat malikleri',
    address: 'Uphill Court, Bahçeşehir/İstanbul',
    filePath: path.join(DATA_DIR, 'UPHİLCOURT BAHÇEŞEHİR KAT MALİKLERİ 1830 KİŞİ.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
      kat: 'Kat',
    },
    defaults: { yearBuilt: 2015, state: 'Başakşehir' }
  },

  // ---- AQUA CITY ----
  {
    id: 'proj_AQUA_CITY',
    orgId: ORG_ID,
    name: 'Aqua City',
    description: 'Aqua City residence',
    address: 'Aqua City, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'aquactiy.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2015, state: 'Beylikdüzü' }
  },

  // ---- VADİ TERAS ----
  {
    id: 'proj_VADI_TERAS',
    orgId: ORG_ID,
    name: 'Vadi Teras',
    description: 'Vadi Teras Güncel',
    address: 'Vadi Teras, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'VADİ TERAS GÜNCEL 04.numbers'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2020, state: 'İstanbul' }
  },

  // ---- AKKOZA ----
  {
    id: 'proj_AKKOZA',
    orgId: ORG_ID,
    name: 'Akkoza',
    description: 'Akkoza residences',
    address: 'Akkoza, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'AKKOZA 1.xls'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'İstanbul' }
  },

  // ---- ALICE VILLAGE ----
  {
    id: 'proj_ALICE_VILLAGE',
    orgId: ORG_ID,
    name: 'Alice Village',
    description: 'Alice Village residences',
    address: 'Alice Village, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'ALİCE VİLLAGE - DATA.xls'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'İstanbul' }
  },

  // ---- KANYON ----
  {
    id: 'proj_KANYON',
    orgId: ORG_ID,
    name: 'Kanyon Residence',
    description: 'Kanyon Residence in Levent',
    address: 'Kanyon, Levent/Şişli/İstanbul',
    filePath: path.join(DATA_DIR, 'Kanyon-1.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2006, state: 'Şişli' }
  },

  // ---- LEVENT LOFT ----
  {
    id: 'proj_LEVENT_LOFT',
    orgId: ORG_ID,
    name: 'Levent Loft',
    description: 'Levent Loft residences',
    address: 'Levent Loft, Levent/İstanbul',
    filePath: path.join(DATA_DIR, 'levent_loft.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'Beşiktaş' }
  },

  // ---- SAPPIRE ----
  {
    id: 'proj_SAPPHIRE',
    orgId: ORG_ID,
    name: 'Sapphire Residence',
    description: 'Sapphire residence in Maslak',
    address: 'Sapphire, Maslak/İstanbul',
    filePath: path.join(DATA_DIR, 'Sapphire Daire Sakinleri.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2012, state: 'Sarıyer' }
  },

  // ---- NUROL ----
  {
    id: 'proj_NUROL',
    orgId: ORG_ID,
    name: 'Nurol Residence',
    description: 'Nurol Residence',
    address: 'Nurol Residence, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'Nurol-1.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'İstanbul' }
  },

  // ---- MAYA RESIDENCE ----
  {
    id: 'proj_MAYA',
    orgId: ORG_ID,
    name: 'Maya Residence',
    description: 'Maya Residence',
    address: 'Maya Residence, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'Maya Residence.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'İstanbul' }
  },

  // ---- ASTORIA ----
  {
    id: 'proj_ASTORIA',
    orgId: ORG_ID,
    name: 'Astoria Residence',
    description: 'Astoria Residence',
    address: 'Astoria, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'astoria.xls'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2012, state: 'Şişli' }
  },

  // ---- ASTORYA ORJINAL ----
  {
    id: 'proj_ASTORYA',
    orgId: ORG_ID,
    name: 'Astorya Residence',
    description: 'Astorya Residence',
    address: 'Astorya, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'astorya orjinal.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'İstanbul' }
  },

  // ---- AVANGARDEN ----
  {
    id: 'proj_AVANGARDEN',
    orgId: ORG_ID,
    name: 'Avangarden',
    description: 'Avangarden residences',
    address: 'Avangarden, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'AVANGARDEN.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2019, state: 'İstanbul' }
  },

  // ---- SELENIUM CITY ----
  {
    id: 'proj_SELENIUM',
    orgId: ORG_ID,
    name: 'Selenium City/Panorama Twins',
    description: 'Selenium City - Panorama Twins',
    address: 'Selenium City, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'SELENIUM CITY-PANORAMA TWINS1.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'İstanbul' }
  },

  // ---- İNNOVA TESLİMLER ----
  {
    id: 'proj_INNOVA',
    orgId: ORG_ID,
    name: 'İnnova Teslimler',
    description: 'İnnova teslimler listesi',
    address: 'İnnova, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'innova teslimler.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
      blok: 'Blok',
    },
    defaults: { yearBuilt: 2023, state: 'İstanbul' }
  },

  // ---- POLAT TOWER ----
  {
    id: 'proj_POLAT',
    orgId: ORG_ID,
    name: 'Polat Tower',
    description: 'Polat Tower residence',
    address: 'Polat Tower, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'polat tower tüm liste.xls'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2013, state: 'Şişli' }
  },

  // ---- ROYAL ----
  {
    id: 'proj_ROYAL',
    orgId: ORG_ID,
    name: 'Royal Residence',
    description: 'Royal Residence',
    address: 'Royal Residence, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'royal-1.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'İstanbul' }
  },

  // ---- İSTWEST ----
  {
    id: 'proj_ISTWEST',
    orgId: ORG_ID,
    name: 'İstwest Residence',
    description: 'İstwest Residence',
    address: 'İstwest, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'İSTWEST.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2020, state: 'İstanbul' }
  },

  // ---- SAVOY ----
  {
    id: 'proj_SAVOY',
    orgId: ORG_ID,
    name: 'Savoy Residence',
    description: 'Savoy Residence',
    address: 'Savoy, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'savoy.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'İstanbul' }
  },

  // ---- SAVOY MÜLK SAHİPLERİ ----
  {
    id: 'proj_SAVOY2',
    orgId: ORG_ID,
    name: 'Savoy Residence (Mülk Sahipleri)',
    description: 'Savoy mülk sahipleri listesi',
    address: 'Savoy, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'savoy mülk sahipleri.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2015, state: 'İstanbul' }
  },

  // ---- MY HOME ----
  {
    id: 'proj_MYHOME',
    orgId: ORG_ID,
    name: 'My Home Residence',
    description: 'My Home Residence',
    address: 'My Home, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'Myhome excell.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'İstanbul' }
  },

  // ---- SEBA VISTA ----
  {
    id: 'proj_SEBA_VISTA',
    orgId: ORG_ID,
    name: 'Seba Vista',
    description: 'Seba Vista Residence',
    address: 'Seba Vista, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'seba vista orjinal.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'İstanbul' }
  },

  // ---- OTOMARE ----
  {
    id: 'proj_OTTOMARE',
    orgId: ORG_ID,
    name: 'Ottomare Residence',
    description: 'Ottomare Residence',
    address: 'Ottomare, İstanbul/Türkiye',
    filePath: path.join(DATA_DIR, 'ottomare.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'İstanbul' }
  },

  // ---- MASLAK 42 A KULE ----
  {
    id: 'proJ_MASLAK42A',
    orgId: ORG_ID,
    name: 'Maslak 42 A Kule',
    description: 'Maslak 42 A Kule',
    address: 'Maslak 42, Maslak/İstanbul',
    filePath: path.join(DATA_DIR, 'maskak 42 A kule.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'Sarıyer' }
  },

  // ---- MASLAK 42 YATAY OFİS ----
  {
    id: 'proj_MASLAK42Y',
    orgId: ORG_ID,
    name: 'Maslak 42 Yatay Ofis',
    description: 'Maslak 42 Yatay Ofis',
    address: 'Maslak 42, Maslak/İstanbul',
    filePath: path.join(DATA_DIR, 'maskak 42 yatay ofis.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'Sarıyer' }
  },

  // ---- MASLAK ECLİPS ----
  {
    id: 'proj_MASLAK_ECLIPS',
    orgId: ORG_ID,
    name: 'Maslak Eclipse',
    description: 'Maslak Eclipse',
    address: 'Maslak Eclipse, Maslak/İstanbul',
    filePath: path.join(DATA_DIR, 'MASLAK ECLÄ°PS.xlsx'),
    mapping: {
      name: 'Ad Soyad',
      daireNo: 'Daire No',
    },
    defaults: { yearBuilt: 2018, state: 'Sarıyer' }
  },
];

// ---------- Files to skip (not property data) ----------
const SKIP_FILES = new Set([
  '1453 01.01.xlsx',           // Not sure what this is
  'ACARKENT bögazüstü ve acar size.xlsx',
  'ARAP YATIRIMCILAR.xlsx',    // Arab investors, not property-specific
  'Asegmen  cep.xlsx',
  'avrupa plazalar..xlsx',     // Office/commercial plaza list
  'bebek (1).xlsx',            // Unclear
  'beyoğlu%20özel.xlsx',      // Specific list
  'beyoğluaralık (1).xls',    // Specific list
  'COL DAİRE SAHİPLERİ.xlsx', // Already processed?
  'istinye park mailler.xlsx', // Email list
  'Istinye park.xlsx',         // Mall list
  'life villa sahipleri.xls',  // Life villa
  'ofis yatırımcılar.xlsx',    // Office investors
  'özel yatırımcılar.xlsx',   // Private investors
  'Platin ulus.xlsx',          // Platinum ulus
  'Residence Sahipleri.xlsx',  // Generic
  'SARIKONAKLAR.xlsx',         // Sarıkonaklar
  'şehrizar).xlsx',           // Şehrizar
  'ULUS_LOTUS_SITESI(1).xls', // Ulus Lotus
  'ulus park evleri mal sahipleri.xlsx', // Ulus Park
  'üst düzey kisiler.xlsx',  // VIP list
  'zorlu yatırımcılar ..xlsx', // Zorlu investors
  'Torun%20Center%20Güncel.xlsx', // Torun Center
  'UÇAKSAVAR SİTESİi.xlsx',  // Uçaksavar
  'ANTHİLL 2018.xlsx',        // Already imported
]);

// ---------- Main ----------
async function main() {
  const prisma = prismaManager.getClient('TR');

  // Ensure org
  const org = await prisma.organization.upsert({
    where: { id: ORG_ID },
    update: { name: 'Reservatior Turkey - Premium Residences' },
    create: {
      id: ORG_ID,
      name: 'Reservatior Turkey - Premium Residences',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    }
  });
  console.log(`✅ Org: ${org.id}`);

  let totalSuccess = 0;
  let totalFail = 0;
  let imported = 0;
  let skipped = 0;

  // Also look for files not in our config but in the directory
  const allFiles = fs.readdirSync(DATA_DIR)
    .filter((f: string) => /\.(xlsx|xls|csv|numbers)$/i.test(f));

  // Import configured projects
  for (const cfg of PROJECTS) {
    const result = await importProject(prisma, cfg);
    if (result) {
      totalSuccess += result.success;
      totalFail += result.fail;
      if (result.success > 0 || result.fail > 0) imported++;
    }
  }

  // Report which files are not configured yet
  const configuredFiles = new Set(PROJECTS.map(p => path.basename(p.filePath)));
  console.log(`\n${'='.repeat(60)}`);
  console.log('\n📋 KONFIGÜRE EDİLMEMİŞ DOSYALAR:');
  for (const f of allFiles) {
    if (!configuredFiles.has(f) && !SKIP_FILES.has(f)) {
      console.log(`   ⚠️  ${f}`);
      skipped++;
    }
  }
  for (const f of [...SKIP_FILES].sort()) {
    if (allFiles.includes(f)) {
      console.log(`   ⏭️  ${f} (atlandı)`);
    }
  }

  console.log(`\n${'='.repeat(60)}`);
  console.log(`📊 ÖZET:`);
  console.log(`   ✅ Başarılı: ${totalSuccess}`);
  console.log(`   ❌ Başarısız: ${totalFail}`);
  console.log(`   📦 İmport edilen projeler: ${imported}`);
  console.log(`   ⚠️  Atlanan dosyalar: ${skipped}`);
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
