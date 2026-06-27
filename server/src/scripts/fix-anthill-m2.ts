/**
 * fix-anthill-m2.ts
 * ─────────────────
 * Anthill Residence dairelerinin veritabanındaki m² ve yatak odası
 * bilgilerini CSV'deki GERÇEK verilerle düzeltir.
 *
 * CSV'de M2 sütunu boş olan dairelere 100 m² yazılmıştı → bu script
 * CSV'deki gerçek değerleri okuyup veritabanını günceller.
 *
 * Ek olarak kat aralıklarına göre balkon/french balkon mantığını uygular:
 *   Kat  1-2  : Balkon yok
 *   Kat  3-25 : Balkon var
 *   Kat 26-30 : French balkon (cam balkon)
 *   Kat 31-35 : Balkon/french balkon yok
 *   Kat 36-39 : 3+1 / 4+1 (Dublex)
 *   Kat 40+   : Otel katları
 *
 * Kullanım:  bun run src/scripts/fix-anthill-m2.ts
 */

import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';

const DATA_DIR = path.join(__dirname, '../../data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL');
const A_BLOK_CSV = path.join(DATA_DIR, 'A Blok Anthill Haziran 2018.csv');
const B_BLOK_CSV = path.join(DATA_DIR, 'B Blok Güncel Düzenlenmiş.csv');

// ─── DAİRE TİPİ HARİTASI (m² → plan bilgisi) ────────────────────────────
function getLayoutFromM2(m2: number): {
  type: string;
  plan: string;
  bedrooms: number;
  bathrooms: number;
  planImage: string;
} {
  switch (m2) {
    case 86:
      return { type: '1+1', plan: 'Tip 3 / C1 / I1', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 3 Anthill.png' };
    case 88:
      return { type: '1+1', plan: 'C2 / C3', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 8 Anthill.png' };
    case 95:
      return { type: '1+1', plan: 'I4', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 3 Anthill.png' };
    case 96:
      return { type: '2+1', plan: 'H1', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 98:
      return { type: '2+1', plan: 'K1', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 99:
      return { type: '2+1', plan: 'Özel', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 100:
      return { type: '2+1', plan: 'H2', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 102:
      return { type: '2+1', plan: 'K2', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 109:
      return { type: '2+1', plan: 'J1', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 110:
      return { type: '2+1', plan: 'B1', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19 Floors.jpg' };
    case 111:
      return { type: '2+1', plan: 'B1-Varyant', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19 Floors.jpg' };
    case 112:
      return { type: '2+1', plan: 'D3 / B3', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg' };
    case 113:
      return { type: '2+1', plan: 'D3-Varyant', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg' };
    case 118:
      return { type: '2+1', plan: 'J4 (Balkonlu)', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
    case 121:
      return { type: '2+1', plan: 'D4 (Balkonlu)', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg' };
    default:
      if (m2 >= 180 && m2 < 200) return { type: '3+1', plan: 'A1 / A4', bedrooms: 3, bathrooms: 2, planImage: '/uploads/anthill/planlar/35-39 Floors 3,4+1.jpg' };
      if (m2 >= 200) return { type: '4+1', plan: 'E1 / E4', bedrooms: 4, bathrooms: 3, planImage: '/uploads/anthill/planlar/35-39 Floors 3,4+1.jpg' };
      return { type: '1+1', plan: 'Standart', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 3 Anthill.png' };
  }
}

// ─── BALKON TİPİ (kat aralığına göre) ─────────────────────────────────────
function getBalkonInfo(kat: number): { balkon: boolean; balkonTipi: string } {
  if (kat <= 2) return { balkon: false, balkonTipi: 'Yok' };
  if (kat <= 25) return { balkon: true, balkonTipi: 'Açık Balkon' };
  if (kat <= 30) return { balkon: true, balkonTipi: 'French Balkon' };
  if (kat <= 35) return { balkon: false, balkonTipi: 'Yok' };
  if (kat <= 39) return { balkon: true, balkonTipi: 'Teras' };
  // 40+ otel katları
  return { balkon: false, balkonTipi: 'Yok' };
}

function getKatKategorisi(kat: number): string {
  if (kat >= 40) return 'Otel';
  if (kat >= 36) return 'Dublex';
  return 'Rezidans';
}

// ─── UNIT ID ÜRETİMİ ─────────────────────────────────────────────────────
// Örnek: ANT-A3904  (A Blok, Kat 39, Kapı 04)
function generateUnitId(blok: string, kat: number, daireNo: string): string {
  const normalized = blok.replace(/[^a-zA-Z]/g, '').toUpperCase(); // "ABLOK" -> "ABLOK"
  const blokChar = normalized.startsWith('B') ? 'B' : 'A';
  const katStr = String(kat).padStart(2, '0');
  const noStr = String(daireNo).padStart(2, '0');
  return `ANT-${blokChar}${katStr}${noStr}`;
}

// ─── CSV PARSER ───────────────────────────────────────────────────────────
function parseCSV(filePath: string): Record<string, string>[] {
  if (!fs.existsSync(filePath)) {
    console.error(`❌ CSV dosyası bulunamadı: ${filePath}`);
    return [];
  }
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split(/\r?\n/);
  if (lines.length === 0) return [];

  const headers = lines[0].split(';');
  const results: Record<string, string>[] = [];

  for (let i = 1; i < lines.length; i++) {
    if (!lines[i].trim()) continue;
    const values = lines[i].split(';');
    const row: Record<string, string> = {};
    for (let j = 0; j < headers.length; j++) {
      row[headers[j]?.trim()] = values[j]?.trim() || '';
    }
    results.push(row);
  }
  return results;
}

// ─── ANA FONKSİYON ───────────────────────────────────────────────────────
async function main() {
  console.log('🔧 ANTHILL M² & DAİRE TİPİ DÜZELTME SCRIPT\'i BAŞLATILIYOR...\n');

  const prisma = prismaManager.getClient('TR');

  // Reset all unitId values to null first to avoid constraint conflicts on rerun
  console.log('🔄 resetting unitId fields to null...');
  await prisma.property.updateMany({
    where: {
      id: { startsWith: 'prop_ANTHILL_' }
    },
    data: {
      unitId: null
    }
  });

  // CSV verilerini oku ve NO → M2 haritası oluştur
  const csvMap: Map<string, { m2: number | null; kat: number; owner: string }> = new Map();

  function processCSVIntoMap(rows: Record<string, string>[], blokName: string) {
    for (const row of rows) {
      const kapıNo = row["NO"];
      if (!kapıNo) continue;

      const m2Str = row["M2"];
      const m2 = m2Str ? parseInt(m2Str, 10) : null;
      const kat = parseInt(row["KAT"] || '0', 10);
      const owner = row["Ev Sahibi"] || row["EV SAHİBİ"] || '';

      const key = `${blokName}_${kapıNo}`;
      csvMap.set(key, { m2: isNaN(m2 as number) ? null : m2, kat: isNaN(kat) ? 0 : kat, owner });
    }
  }

  const aBlokRows = parseCSV(A_BLOK_CSV);
  console.log(`📊 A Blok CSV: ${aBlokRows.length} satır okundu`);
  processCSVIntoMap(aBlokRows, 'ABlok');

  const bBlokRows = parseCSV(B_BLOK_CSV);
  console.log(`📊 B Blok CSV: ${bBlokRows.length} satır okundu`);
  processCSVIntoMap(bBlokRows, 'BBlok');

  console.log(`📋 Toplam CSV kaydı: ${csvMap.size}\n`);

  // Veritabanındaki tüm Anthill dairelerini çek
  const existingProps = await prisma.property.findMany({
    where: {
      AND: [
        { id: { startsWith: 'prop_ANTHILL_' } },
        { NOT: { id: 'prop_ANTHILL_MASTER' } }
      ]
    },
    select: {
      id: true,
      name: true,
      daireNo: true,
      binaNo: true,
      kat: true,
      areaSqm: true,
      bedrooms: true,
      bathrooms: true,
      balkon: true,
      notes: true,
      tapu_tasinmaz_tipi: true,
      unitId: true,
      balkonTipi: true,
      katKategorisi: true,
    }
  });

  console.log(`🏠 Veritabanında ${existingProps.length} Anthill dairesi bulundu.\n`);

  let updatedCount = 0;
  let unchangedCount = 0;
  let errorCount = 0;

  const m2Distribution: Record<number, number> = {};

  for (const prop of existingProps) {
    try {
      // prop.id formatı: prop_ANTHILL_ABlok_123  veya  prop_ANTHILL_BBlok_45
      const idParts = prop.id.replace('prop_ANTHILL_', '').split('_');
      // idParts: ["ABlok", "123"] veya ["A", "Blok", "123"]
      let blokKey: string;
      let daireNo: string;

      if (idParts.length === 2) {
        blokKey = idParts[0]; // "ABlok"
        daireNo = idParts[1];
      } else if (idParts.length === 3) {
        blokKey = idParts[0] + idParts[1]; // "A" + "Blok"
        daireNo = idParts[2];
      } else {
        // Garip format, atla
        continue;
      }

      const csvKey = `${blokKey}_${daireNo}`;
      const csvRecord = csvMap.get(csvKey);

      // CSV'den gerçek m² değerini al, yoksa mevcut DB değerini koru
      let realM2 = csvRecord?.m2 ?? prop.areaSqm ?? null;
      let realKat = csvRecord?.kat ?? prop.kat ?? 0;

      // m² değeri null ise veritabanındaki mevcut değeri koru
      if (realM2 === null || realM2 === 0) {
        realM2 = prop.areaSqm || 86; // Son çare varsayılan
      }

      // M² dağılımını takip et
      m2Distribution[realM2] = (m2Distribution[realM2] || 0) + 1;

      // Daire tipini hesapla
      const layout = getLayoutFromM2(realM2);
      const balkonInfo = getBalkonInfo(realKat);
      const unitId = generateUnitId(blokKey, realKat, daireNo);
      const katKategorisi = getKatKategorisi(realKat);

      // Değişiklik var mı kontrol et
      const hasChange =
        prop.areaSqm !== realM2 ||
        prop.bedrooms !== layout.bedrooms ||
        prop.bathrooms !== layout.bathrooms ||
        prop.balkon !== balkonInfo.balkon ||
        prop.unitId !== unitId ||
        prop.balkonTipi !== balkonInfo.balkonTipi ||
        prop.katKategorisi !== katKategorisi;

      if (!hasChange) {
        unchangedCount++;
        continue;
      }

      // Veritabanını güncelle
      await prisma.property.update({
        where: { id: prop.id },
        data: {
          areaSqm: realM2,
          bedrooms: layout.bedrooms,
          bathrooms: layout.bathrooms,
          balkon: balkonInfo.balkon,
          balkonTipi: balkonInfo.balkonTipi,
          katKategorisi: katKategorisi,
          unitId: unitId,
          tapu_tasinmaz_tipi: `${layout.type} - ${layout.plan}`,
          aidat: realM2 * 50,
          notes: [
            prop.notes || '',
            `\n--- M² Düzeltme (${new Date().toISOString().split('T')[0]}) ---`,
            `Eski M²: ${prop.areaSqm} → Yeni M²: ${realM2}`,
            `Tip: ${layout.type} | Plan: ${layout.plan}`,
            `Balkon: ${balkonInfo.balkonTipi}`,
            `Unit ID: ${unitId}`,
          ].join('\n'),
        }
      });

      // Floor plan da güncelle
      const fpId = `fp_${prop.id}`;
      await prisma.floorPlan.upsert({
        where: { id: fpId },
        update: {
          name: `${layout.type} - ${layout.plan}`,
          imageUrl: layout.planImage,
          floorLevel: realKat,
          description: `${layout.type} Daire | ${realM2} m² | Kat ${realKat} | Balkon: ${balkonInfo.balkonTipi} | ID: ${unitId}`,
        },
        create: {
          id: fpId,
          orgId: 'tr_residence_org',
          propertyId: prop.id,
          name: `${layout.type} - ${layout.plan}`,
          imageUrl: layout.planImage,
          floorLevel: realKat,
          description: `${layout.type} Daire | ${realM2} m² | Kat ${realKat} | Balkon: ${balkonInfo.balkonTipi} | ID: ${unitId}`,
        }
      });

      updatedCount++;

      if (updatedCount % 50 === 0) {
        console.log(`  ✅ ${updatedCount} daire güncellendi...`);
      }
    } catch (e: any) {
      errorCount++;
      console.error(`  ❌ Hata (${prop.id}): ${e.message}`);
    }
  }

  // ─── SONUÇ RAPORU ─────────────────────────────────────────────────────
  console.log('\n═══════════════════════════════════════════════════');
  console.log('  🏗️  ANTHILL M² DÜZELTME SONUÇ RAPORU');
  console.log('═══════════════════════════════════════════════════');
  console.log(`  ✅ Güncellenen daire  : ${updatedCount}`);
  console.log(`  ⏩ Zaten doğru olan   : ${unchangedCount}`);
  console.log(`  ❌ Hata               : ${errorCount}`);
  console.log(`  📊 Toplam işlenen     : ${existingProps.length}`);

  console.log('\n  📐 M² DAĞILIMI:');
  console.log('  ─────────────────');
  const sorted = Object.entries(m2Distribution).sort((a, b) => Number(a[0]) - Number(b[0]));
  for (const [m2, count] of sorted) {
    const layout = getLayoutFromM2(Number(m2));
    const bar = '█'.repeat(Math.min(count, 40));
    console.log(`  ${String(m2).padStart(4)} m² (${layout.type.padEnd(3)} ${layout.plan.padEnd(20)}) : ${bar} ${count}`);
  }

  console.log('\n🏆 DÜZELTME TAMAMLANDI!');
}

main()
  .catch(e => {
    console.error('FATAL ERROR:', e);
    process.exit(1);
  })
  .finally(() => prismaManager.disconnectAll());
