/**
 * Hayat City Mahmutbey (Bağcılar / İstanbul) Project Import
 *
 * Project-level import: Property → Facility → Blocks (A/B/C, 1+1..3+1) → Media inventory.
 * Unit-level (price) data added later once the sales office price list is available.
 * Media files are registered as PropertyDocument records (storageKey = source path).
 *
 * Usage:
 *   bun run import-hayat-city            # Full import
 *   bun run import-hayat-city --dry-run  # Preview only
 */
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';
import { createHash } from 'crypto';

const DRY_RUN = process.argv.includes('--dry-run');
const prisma = prismaManager.getClient('TR');

const ORG_ID = 'seed-tr-global-org-001-1';
const PROP_ID = 'prop_hayat_city_mahmutbey';
const FAC_ID = 'fac_hayat_city_mahmutbey';

const PROJECT_DIR = path.join(__dirname, '../../datalar/tr/istanbul/bagcilar/merkez/projeler/hayat-city-mahmutbey');

// Folder → (blockIdSuffix, block name). DZ = Daire Zemin (ground-floor duplex).
const FOLDER_BLOCKS: Record<string, { id: string; name: string; roomType: string }> = {
  'A 1+1 ':  { id: 'fblk_hayat_a_1p1',  name: 'A Blok 1+1',  roomType: '1+1' },
  'A 2+1':   { id: 'fblk_hayat_a_2p1',  name: 'A Blok 2+1',  roomType: '2+1' },
  'B 2+1':   { id: 'fblk_hayat_b_2p1',  name: 'B Blok 2+1',  roomType: '2+1' },
  'C 2+1':   { id: 'fblk_hayat_c_2p1',  name: 'C Blok 2+1',  roomType: '2+1' },
  'A 3+1':   { id: 'fblk_hayat_a_3p1',  name: 'A Blok 3+1',  roomType: '3+1' },
  'B 3+1':   { id: 'fblk_hayat_b_3p1',  name: 'B Blok 3+1',  roomType: '3+1' },
  '3+1 DZ':  { id: 'fblk_hayat_3p1_dz', name: '3+1 DZ (Zemin)', roomType: '3+1' },
};

function mimeFromExt(file: string): string {
  const ext = path.extname(file).toLowerCase();
  if (ext === '.jpg' || ext === '.jpeg') return 'image/jpeg';
  if (ext === '.png') return 'image/png';
  if (ext === '.webp') return 'image/webp';
  if (ext === '.mp4') return 'video/mp4';
  if (ext === '.mov') return 'video/quicktime';
  if (ext === '.pdf') return 'application/pdf';
  return 'application/octet-stream';
}

async function main() {
  console.log('═'.repeat(60));
  console.log('🏗️  HAYAT CITY MAHMUTBEY - PROJE IMPORT');
  console.log('═'.repeat(60));

  if (!fs.existsSync(PROJECT_DIR)) {
    console.error(`❌ Proje dizini bulunamadı: ${PROJECT_DIR}`);
    process.exit(1);
  }

  const org = DRY_RUN ? { id: ORG_ID } : await prisma.organization.findUnique({
    where: { id: ORG_ID }, select: { id: true, name: true },
  });
  if (!org) throw new Error(`Organization ${ORG_ID} not found`);
  console.log(`✅ Organization: ${org.id}`);

  // ── 1. Project Property ────────────────────────────────────────────────
  const masterProp = DRY_RUN ? { id: PROP_ID } : await prisma.property.upsert({
    where: { id: PROP_ID },
    update: {},
    create: {
      id: PROP_ID,
      orgId: org.id,
      name: 'Hayat City Mahmutbey',
      type: 'APARTMENT',
      region: 'TR',
      currency: 'USD',
      addressLine1: 'Mahmutbey, Bağcılar, İstanbul',
      city: 'Istanbul',
      state: 'Istanbul',
      country: 'TR',
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'AVAILABLE',
      notes: JSON.stringify({
        project: 'Hayat City Mahmutbey',
        district: 'Bağcılar / Mahmutbey',
        roomTypes: ['1+1', '2+1', '3+1'],
        blocks: ['A', 'B', 'C'],
        offering: ['SALE', 'RENT'],
        source: 'datalar/tr/istanbul/bagcilar/merkez/projeler/hayat-city-mahmutbey',
        mediaRegistered: true,
      }),
    },
  });
  console.log(`✅ Project Property: ${masterProp.id}`);

  // ── 2. Facility ────────────────────────────────────────────────────────
  const facility = DRY_RUN ? { id: FAC_ID } : await prisma.facility.upsert({
    where: { id: FAC_ID },
    update: {},
    create: {
      id: FAC_ID,
      orgId: org.id,
      propertyId: PROP_ID,
      name: 'Hayat City Mahmutbey',
      notes: 'Bloklar: A, B, C. Oda tipleri: 1+1, 2+1, 3+1 (3+1 DZ zemin). Birim fiyatları satış ofisi fiyat listesi ile eklenecek.',
    },
  });
  console.log(`✅ Facility: ${facility.id}`);

  // ── 3. Blocks per folder (room type) ───────────────────────────────────
  for (const [folder, blk] of Object.entries(FOLDER_BLOCKS)) {
    if (!DRY_RUN) {
      await prisma.facilityBlock.upsert({
        where: { id: blk.id },
        update: {},
        create: {
          id: blk.id,
          facilityId: FAC_ID,
          name: blk.name,
          floors: 0,
          totalUnits: 0,
          yearBuilt: 2025,
        },
      });
    }
    console.log(`  🏢 Block ${blk.name}: kayıtlı (birim sayısı fiyat listesi sonrası)`);
  }

  // ── 4. Media inventory (recursive per folder) ─────────────────────────
  let docs = 0;
  const byDir: Record<string, number> = {};
  const byCategory: Record<string, number> = {};

  const walk = async (full: string, rel: string) => {
    for (const entry of fs.readdirSync(full, { withFileTypes: true })) {
      if (entry.name === '.DS_Store') continue;
      const relPath = rel ? `${rel}/${entry.name}` : entry.name;
      const abs = path.join(full, entry.name);
      if (entry.isDirectory()) { await walk(abs, relPath); continue; }
      if (!entry.isFile() || entry.isSymbolicLink()) continue;
      if (!fs.statSync(abs).isFile()) continue;

      const top = relPath.split('/')[0];
      byDir[top] = (byDir[top] || 0) + 1;
      const category = 'FLOOR_PLAN';
      byCategory[category] = (byCategory[category] || 0) + 1;
      const stat = fs.statSync(abs);
      const docId = `doc_hayat_${createHash('sha1').update(relPath).digest('hex').slice(0, 16)}`;
      if (!DRY_RUN) {
        await prisma.propertyDocument.upsert({
          where: { id: docId },
          update: { sizeBytes: stat.size },
          create: {
            id: docId,
            orgId: org.id,
            propertyId: PROP_ID,
            title: entry.name.replace(/\.[^.]+$/, ''),
            fileName: entry.name,
            mimeType: mimeFromExt(entry.name),
            sizeBytes: stat.size,
            storageKey: `/hayat-city-mahmutbey/${relPath}`,
            category,
          },
        });
      }
      docs++;
    }
  };

  for (const folder of Object.keys(FOLDER_BLOCKS)) {
    const abs = path.join(PROJECT_DIR, folder);
    if (!fs.existsSync(abs)) { console.warn(`  ⚠️  Klasör bulunamadı, atlanıyor: ${folder}`); continue; }
    await walk(abs, folder);
  }
  for (const [dir, n] of Object.entries(byDir)) console.log(`  🗂️  ${dir}: ${n} dosya`);
  console.log(`\n✅ Medya dosyası kaydı: ${docs}`);
  console.log(`   Kategori dağılımı: ${JSON.stringify(byCategory)}`);

  console.log('\n' + '═'.repeat(60));
  console.log('🏆 HAYAT CITY MAHMUTBEY IMPORT TAMAMLANDI');
  console.log('═'.repeat(60));
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
