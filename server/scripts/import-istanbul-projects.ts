import prismaManager from '../src/lib/prisma';
import * as fs from 'fs';
import * as path from 'path';

const ANTHILL_A_CSV = '/root/reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/A Blok Anthill Haziran 2018.csv';
const ANTHILL_B_CSV = '/root/reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL/B Blok Güncel Düzenlenmiş.csv';
const QUEEN_UNITS_CSV = '/root/reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/Queen/queen_units.csv';
const BOMONTI_CSV = '/root/reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/Merkez Mahallesi/Bomonti Residences By Rotana/ROTANA-BOMONTİ son (1) 2.csv';

function parseCSV(filePath: string, separator = ';'): Record<string, string>[] {
  if (!fs.existsSync(filePath)) {
    console.error(`❌ File not found: ${filePath}`);
    return [];
  }
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split(/\r?\n/).filter((l: string) => l.trim());
  if (lines.length === 0) return [];
  const headers = lines[0].split(separator).map((h: string) => h.trim());
  const results: Record<string, string>[] = [];
  for (let i = 1; i < lines.length; i++) {
    const values = lines[i].split(separator);
    const row: Record<string, string> = {};
    for (let j = 0; j < headers.length; j++) {
      row[headers[j]] = values[j]?.trim() || '';
    }
    results.push(row);
  }
  return results;
}

async function importAnthill(prisma: any, orgId: string) {
  console.log('\n=== ANTHILL RESIDENCE ===');
  const projectId = 'proj_ANTHILL';

  let success = 0, fail = 0;

  for (const [csvPath, blokName] of [[ANTHILL_A_CSV, 'A Blok'], [ANTHILL_B_CSV, 'B Blok']] as const) {
    const rows = parseCSV(csvPath);
    console.log(`${blokName}: ${rows.length} rows`);

    for (const row of rows) {
      const no = row['NO'];
      if (!no) continue;

      const propId = `prop_ANTHILL_${blokName.replace(' ', '')}_${no}`;
      const owner = row['Ev Sahibi']?.trim() || 'GİZLİ YATIRIMCI';
      const kat = parseInt(row['KAT'] || '0');
      const m2 = parseInt(row['M2'] || '86') || 86;

      try {
        await prisma.property.upsert({
          where: { id: propId },
          update: { name: `Anthill ${blokName} - Daire ${no}` },
          create: {
            id: propId,
            orgId,
            name: `Anthill ${blokName} - Daire ${no}`,
            type: 'APARTMENT',
            region: 'TR',
            currency: 'TRY',
            addressLine1: `Cumhuriyet Mah. İncirlidede Cad. No:6 ${blokName} Daire: ${no}`,
            city: 'Istanbul',
            state: 'Şişli',
            country: 'TR',
            daireNo: no.toString(),
            site_ici: true,
            kat,
            areaSqm: m2,
            yearBuilt: 2011,
            propertyCategory: 'RESIDENTIAL',
            listingType: 'SALE',
            listingStatus: 'SOLD',
            guvenlik: true, otopark: true, havuz: true, spor_salonu: true,
            notes: `Sahibi: ${owner}\nBlok: ${blokName}, No: ${no}`,
            projects: { connect: { id: projectId } }
          }
        });
        success++;
      } catch (e: any) {
        fail++;
        console.error(`❌ ${blokName} No ${no}: ${e.message?.substring(0, 100)}`);
      }
    }
  }

  console.log(`Anthill: ${success} success, ${fail} fail`);
}

async function importQueen(prisma: any, orgId: string) {
  console.log('\n=== QUEEN CENTRAL PARK ===');
  const rows = parseCSV(QUEEN_UNITS_CSV, ',');
  console.log(`Queen CSV: ${rows.length} rows`);
  let success = 0, fail = 0;

  const projectId = 'proj_QUEEN';

  for (const row of rows) {
    const bbNo = row['BB_NO'];
    if (!bbNo) continue;

    const propId = `prop_queen_${bbNo}`;
    const tip = row['TIP']?.trim() || 'KONUT';
    const kat = row['BULUNDUGU_KAT'] || '';
    const m2 = parseFloat(row['YUZOLCUMU'] || '0');
    const daireTipi = row['DAIRE_TIPI']?.trim() || '';
    const malSahibi = row['MAL_SAHIBI']?.trim() || '';

    const katNum = (() => {
      const m = kat.match(/(\d+)\./);
      if (!m) return 0;
      const n = parseInt(m[1]);
      return kat.includes('BODRUM') ? -n : n;
    })();

    try {
      await prisma.property.upsert({
        where: { id: propId },
        update: { name: `Queen ${daireTipi || 'Daire'} - BB ${bbNo}` },
        create: {
          id: propId,
          orgId,
          name: `Queen ${daireTipi || 'Daire'} - BB ${bbNo}`,
          type: tip === 'KONUT' ? 'APARTMENT' : 'COMMERCIAL',
          region: 'TR',
          currency: 'TRY',
          addressLine1: `Cumhuriyet Mah. Bomonti, Şişli/İstanbul - BB ${bbNo}`,
          city: 'Istanbul',
          state: 'Şişli',
          country: 'TR',
          daireNo: bbNo.toString(),
          site_ici: true,
          kat: katNum,
          areaSqm: m2 || 0,
          yearBuilt: 2018,
          propertyCategory: tip === 'KONUT' ? 'RESIDENTIAL' : 'COMMERCIAL',
          listingType: 'SALE',
          listingStatus: 'SOLD',
          guvenlik: true, otopark: true, havuz: true, spor_salonu: true,
          notes: `BB No: ${bbNo}\nDaire Tipi: ${daireTipi}\nMal Sahibi: ${malSahibi}`,
          projects: { connect: { id: projectId } }
        }
      });
      success++;
    } catch (e: any) {
      fail++;
      console.error(`❌ BB ${bbNo}: ${e.message?.substring(0, 100)}`);
    }
  }
  console.log(`Queen: ${success} success, ${fail} fail`);
}

async function importBomonti(prisma: any, orgId: string) {
  console.log('\n=== ROTANA BOMONTI RESIDENCES ===');
  const rows = parseCSV(BOMONTI_CSV, ';');
  console.log(`Bomonti CSV: ${rows.length} rows`);
  let success = 0, fail = 0;

  const projectId = 'proj_BOMONTI';

  for (const row of rows) {
    const kapiNo = row['Kapı No']?.trim() || row['KapÑ\xB1 No']?.trim();
    if (!kapiNo) continue;

    const propId = `prop_bomonti_${kapiNo}`;
    const tip = row['Kullanış Şekli']?.trim() || 'DAİRE';
    const musteri = row['Müşteri Adı']?.trim() || row['MÃ¼ÅŸteri AdÄ±']?.trim() || 'GİZLİ YATIRIMCI';

    try {
      await prisma.property.upsert({
        where: { id: propId },
        update: { name: `Bomonti Residence - Daire ${kapiNo}` },
        create: {
          id: propId,
          orgId,
          name: `Bomonti Residence - Daire ${kapiNo}`,
          type: 'APARTMENT',
          region: 'TR',
          currency: 'TRY',
          addressLine1: `Merkez Mah. Bomonti, Şişli/İstanbul - Daire ${kapiNo}`,
          city: 'Istanbul',
          state: 'Şişli',
          country: 'TR',
          daireNo: kapiNo.toString(),
          site_ici: true,
          yearBuilt: 2016,
          propertyCategory: 'RESIDENTIAL',
          listingType: 'SALE',
          listingStatus: 'SOLD',
          guvenlik: true, otopark: true, havuz: true, spor_salonu: true,
          notes: `Sahibi: ${musteri}\nProje: ROTANA BOMONTİ, Daire: ${kapiNo}`,
          projects: { connect: { id: projectId } }
        }
      });
      success++;
    } catch (e: any) {
      fail++;
      console.error(`❌ Daire ${kapiNo}: ${e.message?.substring(0, 100)}`);
    }
  }

  console.log(`Bomonti: ${success} success, ${fail} fail`);
}

async function main() {
  const prisma = prismaManager.getClient('TR');

  const org = await prisma.organization.upsert({
    where: { id: 'tr_residence_org' },
    update: { name: 'Reservatior Turkey - Premium Residences' },
    create: {
      id: 'tr_residence_org',
      name: 'Reservatior Turkey - Premium Residences',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    }
  });
  console.log(`Org: ${org.id}`);

  // Ensure projects exist
  for (const p of [
    { id: 'proj_ANTHILL', name: 'Anthill Residence', desc: 'Anthill Residence twin towers in Şişli', addr: 'Cumhuriyet Mah. İncirlidede Cad. No:6, Şişli/İstanbul' },
    { id: 'proj_QUEEN', name: 'Sinpaş Queen Central Park Bomonti', desc: 'Luxury residences in Bomonti', addr: 'Cumhuriyet Mah. Bomonti, Şişli/İstanbul' },
    { id: 'proj_BOMONTI', name: 'Rotana Bomonti Residences', desc: 'Bomonti Residences by Rotana in Şişli', addr: 'Merkez Mah. Bomonti, Şişli/İstanbul' },
  ]) {
    await prisma.project.upsert({
      where: { id: p.id },
      update: { name: p.name },
      create: { id: p.id, orgId: org.id, name: p.name, description: p.desc, projectType: 'RESIDENTIAL', status: 'COMPLETED', address: p.addr, budget: 100000000, currency: 'TRY' }
    });
  }

  await importAnthill(prisma, org.id);
  await importQueen(prisma, org.id);
  await importBomonti(prisma, org.id);

  console.log('\n✅ ALL IMPORTS COMPLETE');
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
