/**
 * Avrupa Konutları Güneşli (Bağcılar / İstanbul) Project Import
 *
 * Project-level import: Property → Facility → Blocks (1+1..5+1) → Media inventory.
 * Unit-level (price) data requires OCR of the price-list JPG; added later.
 * Media files are registered as PropertyDocument records (storageKey = source path).
 *
 * Usage:
 *   bun run import-avrupa-konutlari-gunesli            # Full import
 *   bun run import-avrupa-konutlari-gunesli --dry-run  # Preview only
 */
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';
import { createHash } from 'crypto';

const DRY_RUN = process.argv.includes('--dry-run');
const prisma = prismaManager.getClient('TR');

const ORG_ID = 'seed-tr-global-org-001-1';
const PROP_ID = 'prop_avrupa_konutlari_gunesli';
const FAC_ID = 'fac_avrupa_konutlari_gunesli';

const PROJECT_DIR = path.join(__dirname, '../../datalar/tr/istanbul/bagcilar/merkez/projeler/Avrupa Konutları Güneşli');

// ─── Block/room-type definitions from folder structure ─────────────────────
const ROOM_TYPES = ['1+1', '2+1', '3+1', '4+1', '5+1'];

const CATEGORY_MAP: Record<string, string> = {
  'Photos': 'PHOTO',
  'VIDEOS': 'VIDEO',
  'Floor Plans ': 'FLOOR_PLAN',
  'Presentations': 'PRESENTATION',
  'Price list': 'PRICE_LIST',
  'Maps': 'MAP',
};

function mimeFromExt(file: string): string {
  const ext = path.extname(file).toLowerCase();
  if (ext === '.jpg' || ext === '.jpeg') return 'image/jpeg';
  if (ext === '.png') return 'image/png';
  if (ext === '.webp') return 'image/webp';
  if (ext === '.mp4') return 'video/mp4';
  if (ext === '.mov') return 'video/quicktime';
  if (ext === '.pdf') return 'application/pdf';
  if (ext === '.url') return 'text/uri-list';
  return 'application/octet-stream';
}

async function main() {
  console.log('═'.repeat(60));
  console.log('🏗️  AVRUPA KONUTLARI GÜNEŞLİ - PROJE IMPORT');
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
      name: 'Avrupa Konutları Güneşli',
      type: 'APARTMENT',
      region: 'TR',
      currency: 'USD',
      addressLine1: 'Güneşli, Bağcılar, İstanbul',
      city: 'Istanbul',
      state: 'Istanbul',
      country: 'TR',
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'AVAILABLE',
      notes: JSON.stringify({
        project: 'Avrupa Konutları Güneşli',
        district: 'Bağcılar / Güneşli',
        roomTypes: ROOM_TYPES,
        offering: ['SALE', 'RENT'],
        source: 'datalar/tr/istanbul/bagcilar/merkez/projeler/Avrupa Konutları Güneşli',
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
      name: 'Avrupa Konutları Güneşli',
      notes: `Oda tipleri: ${ROOM_TYPES.join(', ')}. Birim fiyatları fiyat listesi OCR'ı ile eklenecek.`,
    },
  });
  console.log(`✅ Facility: ${facility.id}`);

  // ── 3. Blocks per room type ────────────────────────────────────────────
  for (const rt of ROOM_TYPES) {
    const blockId = `fblk_gunesli_${rt.replace('+', 'p')}`;
    if (!DRY_RUN) {
      await prisma.facilityBlock.upsert({
        where: { id: blockId },
        update: {},
        create: {
          id: blockId,
          facilityId: FAC_ID,
          name: `${rt} Tipi`,
          floors: 20,
          totalUnits: 0,
          yearBuilt: 2024,
        },
      });
    }
    console.log(`  🏢 Block ${rt}: kayıtlı (birim sayısı OCR sonrası)`);
  }

  // ── 4. Media inventory (recursive) ────────────────────────────────────
  let docs = 0;
  const byCategory: Record<string, number> = {};
  const byDir: Record<string, number> = {};
  const topDirs = fs.readdirSync(PROJECT_DIR, { withFileTypes: true })
    .filter(d => d.isDirectory())
    .map(d => d.name);

  const walk = async (full: string, top: string, rel: string) => {
    for (const entry of fs.readdirSync(full, { withFileTypes: true })) {
      const relPath = rel ? `${rel}/${entry.name}` : entry.name;
      const abs = path.join(full, entry.name);
      if (entry.isDirectory()) { await walk(abs, top, relPath); continue; }
      if (!entry.isFile() || entry.isSymbolicLink()) continue;
      if (!fs.statSync(abs).isFile()) continue;

      byDir[top] = (byDir[top] || 0) + 1;
      const category = CATEGORY_MAP[top] || 'OTHER';
      byCategory[category] = (byCategory[category] || 0) + 1;
      const stat = fs.statSync(abs);
      const docId = `doc_gunesli_${createHash('sha1').update(relPath).digest('hex').slice(0, 16)}`;
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
            storageKey: `/avrupa-konutlari-gunesli/${relPath}`,
            category,
          },
        });
      }
      docs++;
    }
  };

  for (const sub of topDirs) await walk(path.join(PROJECT_DIR, sub), sub, sub);
  for (const [dir, n] of Object.entries(byDir)) console.log(`  🗂️  ${dir}: ${n} dosya`);
  console.log(`\n✅ Medya dosyası kaydı: ${docs}`);
  console.log(`   Kategori dağılımı: ${JSON.stringify(byCategory)}`);

  console.log('\n' + '═'.repeat(60));
  console.log('🏆 AVRUPA KONUTLARI GÜNEŞLİ IMPORT TAMAMLANDI');
  console.log('═'.repeat(60));
}

const projectDirRel = path.join(__dirname, '../../datalar');

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
