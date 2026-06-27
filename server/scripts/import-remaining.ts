import * as XLSX from 'xlsx';
import * as fs from 'fs';
import prismaManager from '../src/lib/prisma';

const DATA_DIR = '/root/reservatior/server/data/TURKİYE';
const ORG_ID = 'tr_residence_org';

function readExcel(path: string): Record<string, string>[] {
  const wb = XLSX.readFile(path, { type: 'file' });
  const s = wb.SheetNames[0];
  const json = XLSX.utils.sheet_to_json<any>(wb.Sheets[s], { defval: '' });
  return json.map(r => {
    const row: Record<string, string> = {};
    for (const [k, v] of Object.entries(r)) row[String(k).trim()] = String(v ?? '').trim();
    return row;
  });
}

async function importProject(prisma: any, cfg: {
  id: string; name: string; desc: string; addr: string;
  file: string; state: string; year: number;
  mapName?: string; mapNo?: string; mapBlok?: string; mapKat?: string; mapM2?: string;
}) {
  const fp = cfg.file;
  console.log(`\n=== ${cfg.name} ===`);

  if (!fs.existsSync(fp)) { console.log('Dosya yok'); return; }

  await prisma.project.upsert({
    where: { id: cfg.id },
    update: {},
    create: {
      id: cfg.id, orgId: ORG_ID, name: cfg.name, description: cfg.desc,
      projectType: 'RESIDENTIAL', status: 'COMPLETED', address: cfg.addr,
      budget: 100000000, currency: 'TRY'
    }
  });

  const rows = readExcel(fp);
  console.log(`${rows.length} satır`);

  let ok = 0, fail = 0;
  for (const row of rows) {
    let no = cfg.mapNo ? row[cfg.mapNo] || '' : '';
    if (!no) { for (const c of ['NO', 'No', 'no', 'DAİRE NO', 'Daire No', 'KAPI NO']) { if (row[c]) { no = row[c]; break; } } }
    if (!no) continue;

    const name = cfg.mapName ? row[cfg.mapName] || '' : '';
    const blok = cfg.mapBlok ? row[cfg.mapBlok] || '' : '';
    const kat = cfg.mapKat ? parseInt(row[cfg.mapKat]) || 0 : 0;
    const m2 = cfg.mapM2 ? parseFloat(row[cfg.mapM2].replace(',', '.')) || 0 : 0;
    const owner = name || 'GİZLİ YATIRIMCI';

    const propId = `prop_${cfg.id.replace('proj_', '')}_${no}`;
    const notes = [`Sahibi: ${owner}`];
    if (blok) notes.push(`Blok: ${blok}`);
    if (m2) notes.push(`m2: ${m2}`);

    try {
      await prisma.property.upsert({
        where: { id: propId },
        update: {},
        create: {
          id: propId, orgId: ORG_ID,
          name: blok ? `${cfg.name} - Blok ${blok} - ${no}` : `${cfg.name} - ${no}`,
          type: 'APARTMENT', region: 'TR', currency: 'TRY',
          addressLine1: [cfg.addr, blok && `Blok ${blok}`, `Daire ${no}`].filter(Boolean).join(', '),
          city: 'Istanbul', state: cfg.state, country: 'TR',
          daireNo: no, site_ici: true, kat, areaSqm: m2,
          yearBuilt: cfg.year, propertyCategory: 'RESIDENTIAL',
          listingType: 'SALE', listingStatus: 'SOLD',
          guvenlik: true, otopark: true, havuz: true, spor_salonu: true,
          notes: notes.filter(Boolean).join('\n'),
          projects: { connect: { id: cfg.id } }
        }
      });
      ok++;
    } catch (e: any) { fail++; console.error(`  ❌ ${no}: ${e.message?.substring(0, 80)}`); }
  }
  console.log(`✅ ${ok} başarılı, ${fail} başarısız`);
}

async function main() {
  const prisma = prismaManager.getClient('TR');
  await prisma.organization.upsert({
    where: { id: ORG_ID }, update: {},
    create: { id: ORG_ID, name: 'Reservatior Turkey - Premium Residences', type: 'AGENCY', region: 'TR', defaultCurrency: 'TRY', defaultLocale: 'tr-TR' }
  });

  const projects = [
    {
      id: 'proj_MYHOME', name: 'My Home Residence', desc: 'My Home Residence', addr: 'My Home Residence, İstanbul',
      file: `${DATA_DIR}/Myhome excell.xlsx`, state: 'İstanbul', year: 2018,
      mapName: 'AD', mapNo: 'NO', mapBlok: 'BLOK', mapKat: 'KAT'
    },
    {
      id: 'proj_MASLAK42A', name: 'Maslak 42 A Kule', desc: 'Maslak 42 A Kule', addr: 'Maslak 42 A Kule, Maslak/İstanbul',
      file: `${DATA_DIR}/maskak 42 A kule.xlsx`, state: 'Sarıyer', year: 2018,
      mapName: 'Ad Soyad', mapNo: 'Daire No', mapBlok: 'Blok',
    },
    {
      id: 'proj_MASLAK42Y', name: 'Maslak 42 Yatay Ofis', desc: 'Maslak 42 Yatay Ofis', addr: 'Maslak 42 Yatay Ofis, Maslak/İstanbul',
      file: `${DATA_DIR}/maskak 42 yatay ofis.xlsx`, state: 'Sarıyer', year: 2018,
      mapName: 'Ad Soyad', mapNo: 'Daire No', mapBlok: 'Blok',
    },
    {
      id: 'proj_MASLAK_ECLIPS', name: 'Maslak Eclipse', desc: 'Maslak Eclipse', addr: 'Maslak Eclipse, Maslak/İstanbul',
      file: `${DATA_DIR}/MASLAK ECLÄ°PS.xlsx`, state: 'Sarıyer', year: 2018,
      mapName: 'Ad Soyad', mapNo: 'Daire No',
    },
  ];

  for (const p of projects) await importProject(prisma, p);

  const total = await prisma.property.count({ where: { region: 'TR' } });
  console.log(`\n📊 Toplam TR property: ${total}`);
}

main().catch(console.error).finally(() => prismaManager.disconnectAll());
