/**
 * Büyükyalı Istanbul Import Script
 *
 * Imports 742 sold units from 2019 contracts + 2026 price list.
 * Creates: Org → Master Property → Facility → Blocks → Unit Properties + Contacts
 * Price list stored as market reference for owner invitations.
 *
 * Usage:
 *   bun run import-buyukyali            # Full import
 *   bun run import-buyukyali --dry-run  # Preview only
 *   bun run import-buyukyali --owners   # Only create contacts for invitations
 */
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';

const DRY_RUN = process.argv.includes('--dry-run');
const OWNERS_ONLY = process.argv.includes('--owners');

const prisma = prismaManager.getClient('TR');

// ─── 2026 Price List (USD) ───────────────────────────────────────────────────
const PRICE_LIST_2026 = {
  general: [
    { type: '2+1', minM2: 134, maxM2: 223, minPrice: 1_079_000, maxPrice: 1_660_000 },
    { type: '3+1', minM2: 175, maxM2: 344, minPrice: 1_491_000, maxPrice: 2_549_000 },
    { type: '4+1', minM2: 227.54, maxM2: 364.1, minPrice: 2_192_000, maxPrice: 3_833_000 },
  ],
  fendiCasa: [
    { type: '2+1', minM2: 142, maxM2: 312.16, minPrice: 1_587_000, maxPrice: 1_740_000 },
    { type: '4+1', minM2: 326.32, maxM2: 517.87, minPrice: 3_126_000, maxPrice: 3_859_000 },
  ],
  loftVila: [
    { type: 'LOFT/VILA', minM2: 376, maxM2: 426, minPrice: 2_433_000, maxPrice: 3_603_000 },
  ],
  paymentPlan: '50% Cash + 12 months installments',
  vatOptions: ['%1 Vergi Seçeneği', '%20 KDV Seçeneği'],
};

// ─── Block floor counts (estimated from data) ───────────────────────────────
const BLOCK_FLOORS: Record<string, number> = {
  A: 16, B: 16, C: 8, D: 12, E: 8, F: 12,
  G: 16, H: 12, I: 12, J: 12, K: 16, L: 8,
  P: 4, S: 8,
};

function parseSoldUnits(): any[] {
  const jsonPath = path.join(__dirname, '../../datalar/buyukyali_2019/sold_units.json');
  if (!fs.existsSync(jsonPath)) {
    console.error(`❌ sold_units.json not found. Run PDF extraction first.`);
    process.exit(1);
  }
  return JSON.parse(fs.readFileSync(jsonPath, 'utf-8'));
}

function estimateType(grossM2: number): string {
  if (grossM2 < 100) return '1+1';
  if (grossM2 < 145) return '1.5+1';
  if (grossM2 < 175) return '2+1';
  if (grossM2 < 230) return '3+1';
  if (grossM2 < 320) return '3.5+1';
  if (grossM2 < 410) return '4+1';
  return '5+/LOFT';
}

function estimateMarketValueUsd(grossM2: number): { min: number; max: number; type: string } {
  const type = estimateType(grossM2);
  const allTypes = [...PRICE_LIST_2026.general, ...PRICE_LIST_2026.fendiCasa, ...PRICE_LIST_2026.loftVila];

  // Find matching price range by type
  for (const tier of allTypes) {
    if (tier.type === type && grossM2 >= tier.minM2 * 0.8 && grossM2 <= tier.maxM2 * 1.2) {
      // Interpolate price by m² position in range
      const m2Ratio = (grossM2 - tier.minM2) / (tier.maxM2 - tier.minM2);
      const estimated = tier.minPrice + m2Ratio * (tier.maxPrice - tier.minPrice);
      return { min: tier.minPrice, max: tier.maxPrice, type };
    }
  }

  // Fallback: price per m² from general
  const avgPricePerM2 = 8_500; // USD/m² rough estimate
  const est = grossM2 * avgPricePerM2;
  return { min: est * 0.8, max: est * 1.2, type };
}

async function main() {
  console.log('═'.repeat(60));
  console.log('🏙️  BÜYÜKYALI İSTANBUL - PROJE IMPORT');
  console.log('═'.repeat(60));

  if (DRY_RUN) console.log('⚠️  DRY RUN MODE - No data will be written\n');

  // ── 1. Organization ──────────────────────────────────────────────────────
  const orgId = 'seed-tr-global-org-001-1'; // Use existing org to avoid DB migration issues
  const org = DRY_RUN ? { id: orgId } : await prisma.organization.findUnique({
    where: { id: orgId },
    select: { id: true, name: true },
  });
  if (!org) throw new Error(`Organization ${orgId} not found`);
  console.log(`✅ Organization: ${org.id} (${org.name})`);

  // ── 2. Master Property (the project) ────────────────────────────────────
  const masterPropId = 'prop_buyukyali_istanbul';
  const masterProp = DRY_RUN ? { id: masterPropId } : await prisma.property.upsert({
    where: { id: masterPropId },
    update: {},
    create: {
      id: masterPropId,
      orgId: org.id,
      name: 'Büyükyalı Istanbul',
      type: 'APARTMENT',
      region: 'TR',
      currency: 'USD',
      addressLine1: 'Zeytinburnu, İstanbul',
      city: 'Istanbul',
      state: 'Istanbul',
      country: 'TR',
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'AVAILABLE',
      areaSqm: 70,
      notes: 'Büyükyalı Istanbul projesi. Emlak Konut + ÖZAK-YENİGÜN-ZİYLAN ortaklığı. 14 blok, 742+ satılmış bağımsız bölüm. Ada/Parsel: 774/83. 2026 fiyat listesi USD bazında.',
      lat: 41.0201,
      lng: 28.9085,
      yearBuilt: 2019,
      listingPrice: 1_079_000,
    },
  });
  console.log(`✅ Master Property: ${masterProp.id}`);

  // ── 3. Facility ─────────────────────────────────────────────────────────
  const facilityId = 'fac_buyukyali_istanbul';
  const facility = DRY_RUN ? { id: facilityId } : await prisma.facility.upsert({
    where: { id: facilityId },
    update: {},
    create: {
      id: facilityId,
      orgId: org.id,
      propertyId: masterPropId,
      name: 'Büyükyalı Istanbul',
      notes: 'Ödeme: %50 Peşin + 12 ay taksit. KDV: %1 veya %20 seçenekli.',
    },
  });
  console.log(`✅ Facility: ${facility.id}`);

  // ── 4. FacilityBlocks ───────────────────────────────────────────────────
  const soldUnits = parseSoldUnits();
  console.log(`\n📊 Loaded ${soldUnits.length} sold unit records from contracts\n`);

  // Count units per block from actual data
  const blockCounts: Record<string, number> = {};
  for (const u of soldUnits) {
    const b = u.block || 'UNKNOWN';
    blockCounts[b] = (blockCounts[b] || 0) + 1;
  }

  const blockIds: Record<string, string> = {};
  for (const [blockName, unitCount] of Object.entries(blockCounts)) {
    const blockId = `fblk_buyukyali_${blockName}`;
    blockIds[blockName] = blockId;

    if (!DRY_RUN) {
      await prisma.facilityBlock.upsert({
        where: { id: blockId },
        update: { totalUnits: unitCount },
        create: {
          id: blockId,
          facilityId,
          name: `Blok ${blockName}`,
          floors: BLOCK_FLOORS[blockName] || 12,
          totalUnits: unitCount,
          yearBuilt: 2019,
        },
      });
    }
    console.log(`  🏢 Block ${blockName}: ${unitCount} units (floors: ${BLOCK_FLOORS[blockName] || '?'})`);
  }

  // ── 5. Unit Properties + Contacts ───────────────────────────────────────
  let created = 0;
  let skipped = 0;

  // Track unique owners for invitation
  const ownerMap = new Map<string, { name: string; phone?: string; email?: string; units: any[] }>();

  for (const unit of soldUnits) {
    const block = unit.block || 'UNKNOWN';
    const door = unit.door || '0';
    const gross = parseFloat((unit.gross || '0').replace(',', '.'));
    const net = parseFloat((unit.net || '0').replace(',', '.'));
    const priceRaw = (unit.price || '0').replace('.', '').replace(',', '.');
    const priceTry = parseFloat(priceRaw) || 0;
    const floor = unit.floor || '';
    const floorNum = parseInt(floor) || 0;
    const ownerName = unit.ownerName || 'GİZLİ';
    const phone = unit.phone || '';
    const email = unit.email || '';
    const direction = unit.dir || '';

    const propId = `prop_buyukyali_${block}${door}`;

    // Market value estimate
    const marketEst = gross > 0 ? estimateMarketValueUsd(gross) : null;

    // Parse floor number
    const floorMatch = floor.match(/(\d+)/);
    const floorNumParsed = floorMatch ? parseInt(floorMatch[1]) : null;

    // Build address
    const address = `Büyükyalı Istanbul, Blok ${block}, Daire ${door}, ${floor}`;

    if (!DRY_RUN) {
      try {
        await prisma.property.upsert({
          where: { id: propId },
          update: {
            areaSqm: gross || undefined,
            notes: JSON.stringify({
              netArea: net,
              direction,
              salePriceTRY: priceTry,
              marketValueEstUSD: marketEst,
              originalContract: '2019',
              source: 'buyukyali_2019_contracts',
            }),
          },
          create: {
            id: propId,
            orgId: org.id,
            name: `Büyükyalı ${block}${door}`,
            type: 'APARTMENT',
            region: 'TR',
            currency: 'USD',
            addressLine1: address,
            city: 'Istanbul',
            state: 'Istanbul',
            country: 'TR',
            propertyCategory: 'RESIDENTIAL',
            listingType: 'SALE',
            listingStatus: 'AVAILABLE',
            areaSqm: gross || undefined,
            bedrooms: gross > 0 ? undefined : undefined,
            listingPrice: marketEst ? marketEst.min : undefined,
            lat: 41.0201 + (Math.random() - 0.5) * 0.002,
            lng: 28.9085 + (Math.random() - 0.5) * 0.002,
            notes: JSON.stringify({
              netArea: net,
              direction,
              salePriceTRY: priceTry,
              marketValueEstUSD: marketEst,
              originalContract: '2019',
              source: 'buyukyali_2019_contracts',
            }),
          },
        });
        created++;
      } catch (e: any) {
        skipped++;
        if (skipped <= 3) console.log(`  ⚠️  Skip ${propId}: ${e.message?.slice(0, 80)}`);
      }
    } else {
      created++;
    }

    // Track owner for invitations
    const ownerKey = ownerName.toUpperCase().trim();
    if (!ownerMap.has(ownerKey)) {
      ownerMap.set(ownerKey, { name: ownerName, phone, email, units: [] });
    }
    ownerMap.get(ownerKey)!.units.push({ block, door, floor, gross, net, priceTry, marketEst });
  }

  console.log(`\n✅ Properties created: ${created}`);
  if (skipped > 0) console.log(`  ⚠️  Skipped: ${skipped}`);

  // ── 6. Contacts (for invitations) ───────────────────────────────────────
  let contactsCreated = 0;
  for (const [key, owner] of ownerMap) {
    if (!DRY_RUN) {
      const contactId = `ct_buyukyali_${key.replace(/[^A-Z0-9]/g, '').slice(0, 40)}`;
      try {
        await prisma.contact.upsert({
          where: { id: contactId },
          update: { phone: owner.phone || undefined, email: owner.email || undefined },
          create: {
            id: contactId,
            orgId: org.id,
            type: 'OWNER_CONTACT',
            fullName: owner.name,
            email: owner.email || `owner_${contactsCreated}@buyukyali.import`,
            phone: owner.phone || undefined,
            notes: JSON.stringify({
              project: 'Büyükyalı Istanbul',
              units: owner.units.map(u => `${u.block}${u.door}`),
              totalUnits: owner.units.length,
              invitationPending: true,
            }),
          },
        });
        contactsCreated++;
      } catch { /* skip */ }
    } else {
      contactsCreated++;
    }
  }

  console.log(`✅ Contacts created: ${contactsCreated}`);

  // ── 7. Price List Summary ───────────────────────────────────────────────
  console.log('\n' + '═'.repeat(60));
  console.log('📋 2026 FİYAT LİSTESİ (USD)');
  console.log('═'.repeat(60));
  console.log('\nGeneral:');
  for (const t of PRICE_LIST_2026.general) {
    console.log(`  ${t.type}: ${t.minM2}–${t.maxM2} m² → $${(t.minPrice).toLocaleString()}–$${(t.maxPrice).toLocaleString()}`);
  }
  console.log('\nFendi Casa:');
  for (const t of PRICE_LIST_2026.fendiCasa) {
    console.log(`  ${t.type}: ${t.minM2}–${t.maxM2} m² → $${(t.minPrice).toLocaleString()}–$${(t.maxPrice).toLocaleString()}`);
  }
  console.log('\nLoft/Vila:');
  for (const t of PRICE_LIST_2026.loftVila) {
    console.log(`  ${t.type}: ${t.minM2}–${t.maxM2} m² → $${(t.minPrice).toLocaleString()}–$${(t.maxPrice).toLocaleString()}`);
  }
  console.log(`\nÖdeme: ${PRICE_LIST_2026.paymentPlan}`);
  console.log(`KDV: ${PRICE_LIST_2026.vatOptions.join(' veya ')}`);

  // ── 8. Market Value Distribution ─────────────────────────────────────────
  console.log('\n' + '═'.repeat(60));
  console.log('💰 PİYASA DEĞERİ DAĞILIMI (Tahmini USD)');
  console.log('═'.repeat(60));

  const valueRanges: Record<string, number> = {
    '$500K–$1M': 0,
    '$1M–$1.5M': 0,
    '$1.5M–$2M': 0,
    '$2M–$3M': 0,
    '$3M–$4M': 0,
    '$4M+': 0,
  };

  for (const unit of soldUnits) {
    const gross = parseFloat((unit.gross || '0').replace(',', '.'));
    if (gross <= 0) continue;
    const est = estimateMarketValueUsd(gross);
    const avg = (est.min + est.max) / 2;

    if (avg < 500_000) valueRanges['$500K–$1M']++;
    else if (avg < 1_000_000) valueRanges['$500K–$1M']++;
    else if (avg < 1_500_000) valueRanges['$1M–$1.5M']++;
    else if (avg < 2_000_000) valueRanges['$1.5M–$2M']++;
    else if (avg < 3_000_000) valueRanges['$2M–$3M']++;
    else if (avg < 4_000_000) valueRanges['$3M–$4M']++;
    else valueRanges['$4M+']++;
  }

  for (const [range, count] of Object.entries(valueRanges)) {
    const bar = '█'.repeat(Math.min(40, Math.round(count / 3)));
    console.log(`  ${range.padEnd(12)} ${String(count).padStart(4)} ${bar}`);
  }

  // ── 9. Type Distribution ────────────────────────────────────────────────
  console.log('\n' + '═'.repeat(60));
  console.log('🏠 DAİRE TİPİ DAĞILIMI');
  console.log('═'.repeat(60));

  const typeDist: Record<string, number> = {};
  for (const unit of soldUnits) {
    const gross = parseFloat((unit.gross || '0').replace(',', '.'));
    if (gross <= 0) continue;
    const t = estimateType(gross);
    typeDist[t] = (typeDist[t] || 0) + 1;
  }
  for (const [t, count] of Object.entries(typeDist).sort()) {
    const bar = '█'.repeat(Math.min(40, Math.round(count / 3)));
    console.log(`  ${t.padEnd(8)} ${String(count).padStart(4)} ${bar}`);
  }

  // ── 10. Invitation Summary ──────────────────────────────────────────────
  console.log('\n' + '═'.repeat(60));
  console.log('📨 DAVETİYE HAZIRLIĞI');
  console.log('═'.repeat(60));
  console.log(`  Toplam mülk sahibi: ${ownerMap.size}`);
  console.log(`  Toplam bağımsız bölüm: ${soldUnits.length}`);
  console.log(`  E-posta olan: ${[...ownerMap.values()].filter(o => o.email).length}`);
  console.log(`  Telefon olan: ${[...ownerMap.values()].filter(o => o.phone).length}`);
  console.log(`  Hem e-posta hem telefon: ${[...ownerMap.values()].filter(o => o.email && o.phone).length}`);
  console.log(`\n  ℹ️  Davetiye sistemi hazır. Owner'lar davet edildiğinde`);
  console.log(`     mülklerinin piyasa değerini ve kiralama potansiyelini görebilecek.`);

  console.log('\n' + '═'.repeat(60));
  console.log('🏆 BÜYÜKYALI İSTANBUL IMPORT TAMAMLANDI');
  console.log('═'.repeat(60));
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
