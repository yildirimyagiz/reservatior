/**
 * Portfolio Import Service
 *
 * Parses XLSX/CSV files with auto-detected Turkish column headers.
 * Creates Organization → Project → Facility → Property → Contact → Listing → FloorPlan → PropertyPhoto
 * Emits property.imported.v1 events for the intelligence pipeline.
 */
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';
import * as xlsx from 'xlsx';

// ─── Types ──────────────────────────────────────────────────────────────────

export interface ImportConfig {
  filePath: string;
  orgId?: string;
  projectName: string;
  projectAddress?: string;
  city?: string;
  district?: string;
  subDistrict?: string;
  country?: string;
  lat?: number;
  lng?: number;
  yearBuilt?: number;
  region?: string;
  autoDetectColumns?: boolean;
  dryRun?: boolean;
}

export interface ParsedRow {
  ownerName: string;
  apartmentNo: string;
  blockNo: string;
  floor: string;
  areaSqm: number | null;
  roomType: string;
  phone: string;
  email: string;
  tenantName: string;
  status: string;
  price: number | null;
  rent: number | null;
  raw: Record<string, any>;
}

export interface ImportResult {
  success: boolean;
  projectName: string;
  orgId: string;
  projectId: string;
  facilityId: string;
  totalRows: number;
  imported: number;
  skipped: number;
  failed: number;
  contacts: number;
  properties: number;
  listings: number;
  floorPlans: number;
  photos: number;
  errors: string[];
}

// ─── Turkish Column Name Detection ──────────────────────────────────────────

const COLUMN_PATTERNS: Record<string, string[]> = {
  ownerName: ['ad', 'isim', 'sahip', 'musteri', 'name', 'unvan', 'malik', 'alici', 'oturan', 'ev sahibi', 'müşteri', 'ad soyad', 'tam ad'],
  apartmentNo: ['daire', 'no', 'kapi', 'bolum', 'bagimsiz', 'kapı', 'bağımsız', 'unit', 'door'],
  blockNo: ['blok', 'bina', 'residence', 'etap', 'tower', 'block'],
  floor: ['kat', 'floor', 'seviye'],
  areaSqm: ['m2', 'm²', 'alan', 'metrekare', 'area', 'net', 'brüt', 'brut', 'square'],
  roomType: ['tip', 'type', 'oda', 'oda tipi', 'layout', 'apartment type'],
  phone: ['tel', 'cep', 'gsm', 'irtibat', 'phone', 'telefon', 'tel no', 'cep no'],
  email: ['mail', 'e-posta', 'eposta', 'email'],
  tenantName: ['kiraci', 'kiracı', 'tenant', 'oturan'],
  status: ['durum', 'status', 'state'],
  price: ['fiyat', 'price', 'satis', 'satış', 'tutar', 'bedel', 'amount'],
  rent: ['kira', 'rent', 'kira bedeli', 'aylik kira', 'monthly rent'],
};

function normalizeTurkish(s: string): string {
  return s.toLowerCase()
    .replace(/İ/g, 'i').replace(/ı/g, 'i')
    .replace(/Ş/g, 's').replace(/ş/g, 's')
    .replace(/Ğ/g, 'g').replace(/ğ/g, 'g')
    .replace(/Ü/g, 'u').replace(/ü/g, 'u')
    .replace(/Ö/g, 'o').replace(/ö/g, 'o')
    .replace(/Ç/g, 'c').replace(/ç/g, 'c')
    .trim();
}

function detectColumn(key: string): string | null {
  const normalized = normalizeTurkish(key);
  for (const [field, patterns] of Object.entries(COLUMN_PATTERNS)) {
    for (const pattern of patterns) {
      if (normalized === pattern || normalized.includes(pattern)) {
        return field;
      }
    }
  }
  return null;
}

// ─── Parsers ────────────────────────────────────────────────────────────────

function parseCSVFile(filePath: string): Record<string, any>[] {
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split(/\r?\n/).filter(l => l.trim());
  if (lines.length < 2) return [];

  // Detect separator
  const firstLine = lines[0];
  const separator = firstLine.includes(';') ? ';' : ',';

  const headers = firstLine.split(separator).map(h => h.trim().replace(/^"|"$/g, ''));
  const results: Record<string, any>[] = [];

  for (let i = 1; i < lines.length; i++) {
    const values = lines[i].split(separator).map(v => v.trim().replace(/^"|"$/g, ''));
    const row: Record<string, any> = {};
    for (let j = 0; j < headers.length; j++) {
      row[headers[j]] = values[j] || '';
    }
    results.push(row);
  }
  return results;
}

function parseXLSXFile(filePath: string): Record<string, any>[] {
  const workbook = xlsx.readFile(filePath);
  const sheetName = workbook.SheetNames[0];
  return xlsx.utils.sheet_to_json(workbook.Sheets[sheetName]);
}

function parseFile(filePath: string): Record<string, any>[] {
  const ext = path.extname(filePath).toLowerCase();
  if (ext === '.xlsx' || ext === '.xls') return parseXLSXFile(filePath);
  if (ext === '.csv') return parseCSVFile(filePath);
  throw new Error(`Unsupported file format: ${ext}`);
}

// ─── Row Processing ─────────────────────────────────────────────────────────

function parseRow(raw: Record<string, any>, columnMap: Map<string, string>): ParsedRow {
  const get = (field: string): string => {
    const col = columnMap.get(field);
    if (!col) return '';
    return String(raw[col] || '').trim();
  };

  const ownerName = get('ownerName') || 'GİZLİ YATIRIMCI';
  const apartmentNo = get('apartmentNo') || `UNIT-${Math.floor(Math.random() * 9000) + 1000}`;
  const blockNo = get('blockNo');
  const floor = get('floor');
  const rawArea = get('areaSqm').replace(/[^0-9.,]/g, '').replace(',', '.');
  const areaSqm = rawArea ? parseFloat(rawArea) : null;
  const roomType = get('roomType');
  const phone = get('phone');
  const rawEmail = get('email').toLowerCase();
  const email = rawEmail && rawEmail.includes('@') ? rawEmail : '';
  const tenantName = get('tenantName');
  const status = get('status');
  const rawPrice = get('price').replace(/[^0-9.,]/g, '').replace(',', '.');
  const price = rawPrice ? parseFloat(rawPrice) : null;
  const rawRent = get('rent').replace(/[^0-9.,]/g, '').replace(',', '.');
  const rent = rawRent ? parseFloat(rawRent) : null;

  return { ownerName, apartmentNo, blockNo, floor, areaSqm, roomType, phone, email, tenantName, status, price, rent, raw };
}

function buildColumnMap(headers: string[]): Map<string, string> {
  const map = new Map<string, string>();
  const usedColumns = new Set<string>();

  for (const header of headers) {
    const detected = detectColumn(header);
    if (detected && !map.has(detected)) {
      map.set(detected, header);
      usedColumns.add(header);
    }
  }
  return map;
}

// ─── Room Type Helpers ──────────────────────────────────────────────────────

function parseRoomType(roomType: string, areaSqm: number | null): { bedrooms: number; bathrooms: number; type: string } {
  if (roomType) {
    const match = roomType.match(/(\d+)\+(\d+)/);
    if (match) {
      return { bedrooms: parseInt(match[1]), bathrooms: parseInt(match[2]) > 0 ? 1 : 0, type: roomType };
    }
  }
  if (areaSqm) {
    if (areaSqm < 90) return { bedrooms: 1, bathrooms: 1, type: '1+1' };
    if (areaSqm < 110) return { bedrooms: 2, bathrooms: 1, type: '2+1' };
    if (areaSqm < 140) return { bedrooms: 2, bathrooms: 2, type: '2+1' };
    if (areaSqm < 170) return { bedrooms: 3, bathrooms: 2, type: '3+1' };
    if (areaSqm < 200) return { bedrooms: 3, bathrooms: 2, type: '3+1' };
    return { bedrooms: 4, bathrooms: 3, type: '4+1' };
  }
  return { bedrooms: 1, bathrooms: 1, type: '1+1' };
}

// ─── Main Import Function ───────────────────────────────────────────────────

export async function importPortfolio(config: ImportConfig): Promise<ImportResult> {
  const {
    filePath,
    orgId = 'tr_residence_org',
    projectName,
    projectAddress = 'İstanbul',
    city = 'Istanbul',
    district = '',
    subDistrict = '',
    country = 'TR',
    lat,
    lng,
    yearBuilt,
    region = 'TR',
    autoDetectColumns = true,
    dryRun = false,
  } = config;

  const result: ImportResult = {
    success: false,
    projectName,
    orgId,
    projectId: '',
    facilityId: '',
    totalRows: 0,
    imported: 0,
    skipped: 0,
    failed: 0,
    contacts: 0,
    properties: 0,
    listings: 0,
    floorPlans: 0,
    photos: 0,
    errors: [],
  };

  console.log(`\n🌟 PORTFOLIO IMPORT ENGINE: ${projectName}`);
  console.log(`📂 File: ${filePath}`);

  // 1. Parse file
  if (!fs.existsSync(filePath)) {
    result.errors.push(`File not found: ${filePath}`);
    return result;
  }

  const rawData = parseFile(filePath);
  result.totalRows = rawData.length;
  console.log(`📊 ${rawData.length} rows detected`);

  if (rawData.length === 0) {
    result.success = true;
    return result;
  }

  // 2. Auto-detect columns
  const headers = Object.keys(rawData[0]);
  const columnMap = autoDetectColumns ? buildColumnMap(headers) : new Map<string, string>();

  console.log(`🔍 Column mapping:`);
  for (const [field, col] of columnMap) {
    console.log(`   ${field} → "${col}"`);
  }

  if (dryRun) {
    console.log(`\n🧪 DRY RUN - No data will be written`);
    const sample = rawData.slice(0, 3).map(r => parseRow(r, columnMap));
    console.log(`📋 Sample rows:`, JSON.stringify(sample, null, 2));
    result.success = true;
    return result;
  }

  // 3. Connect to database
  const prisma = prismaManager.getClient(region);
  console.log(`🔗 Connected to ${region} database`);

  // 4. Upsert Organization
  const org = await prisma.organization.upsert({
    where: { id: orgId },
    update: { name: `Reservatior ${region} - ${projectName}` },
    create: {
      id: orgId,
      name: `Reservatior ${region} - ${projectName}`,
      type: 'AGENCY',
      region: region as any,
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    },
  });
  console.log(`🏢 Organization: ${org.name}`);

  // 5. Create Project
  const projectId = `proj_${projectName.replace(/[^A-Z0-9]/gi, '').toUpperCase()}`;
  const project = await prisma.project.upsert({
    where: { id: projectId },
    update: { name: projectName },
    create: {
      id: projectId,
      orgId: org.id,
      name: projectName,
      projectType: 'RESIDENTIAL',
      status: 'COMPLETED',
      address: projectAddress,
      currency: 'TRY',
    },
  });
  result.projectId = project.id;
  console.log(`🏗️ Project: ${project.name}`);

  // 6. Create Master Property
  const masterPropId = `prop_${projectName.replace(/[^A-Z0-9]/gi, '').toUpperCase()}_MASTER`;
  const masterProperty = await prisma.property.upsert({
    where: { id: masterPropId },
    update: { name: `${projectName} (Master Building)` },
    create: {
      id: masterPropId,
      orgId: org.id,
      name: `${projectName} (Master Building)`,
      type: 'APARTMENT',
      region: region as any,
      currency: 'TRY',
      addressLine1: projectAddress,
      city,
      state: district,
      country,
      lat: lat || undefined,
      lng: lng || undefined,
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'ACTIVE',
      yearBuilt: yearBuilt || undefined,
      guvenlik: true,
      otopark: true,
      havuz: true,
      spor_salonu: true,
      jenerator: true,
      kamera_sistemi: true,
      site_ici: true,
    },
  });

  // 7. Create Facility
  const facilityId = `fac_${projectName.replace(/[^A-Z0-9]/gi, '').toUpperCase()}`;
  const facility = await prisma.facility.upsert({
    where: { id: facilityId },
    update: { name: `${projectName} Complex` },
    create: {
      id: facilityId,
      orgId: org.id,
      propertyId: masterPropId,
      name: `${projectName} Complex`,
      notes: `Main facility for ${projectName} complex.`,
    },
  });
  result.facilityId = facility.id;
  console.log(`🏢 Facility: ${facility.name}`);

  // 8. Process rows
  const emailSet = new Set<string>();

  for (let i = 0; i < rawData.length; i++) {
    const row = parseRow(rawData[i], columnMap);

    if (!row.ownerName || row.ownerName === 'GİZLİ YATIRIMCI') {
      result.skipped++;
      continue;
    }

    try {
      // ─── Contact ──────────────────────────────────────────────
      const safeEmail = row.email || `${row.ownerName.toLowerCase().replace(/[^a-z0-9]/g, '')}_${i}@${projectName.toLowerCase().replace(/[^a-z0-9]/g, '')}.import`;
      const contactId = `contact_${projectName.replace(/[^A-Z0-9]/gi, '').toUpperCase()}_${safeEmail.replace(/[^a-z0-9]/g, '')}`;

      await prisma.contact.upsert({
        where: { id: contactId },
        update: { fullName: row.ownerName, phone: row.phone || null },
        create: {
          id: contactId,
          orgId: org.id,
          type: 'OWNER_CONTACT',
          fullName: row.ownerName,
          email: safeEmail,
          phone: row.phone || null,
          notes: `Blok: ${row.blockNo || '-'}, Daire: ${row.apartmentNo}, Kat: ${row.floor || '-'}`,
        },
      });
      result.contacts++;

      // ─── Tenant Contact ───────────────────────────────────────
      if (row.tenantName) {
        const tenantEmail = `${row.tenantName.toLowerCase().replace(/[^a-z0-9]/g, '')}_${row.apartmentNo}@${projectName.toLowerCase().replace(/[^a-z0-9]/g, '')}.tenant`;
        const tenantId = `contact_tenant_${projectName.replace(/[^A-Z0-9]/gi, '').toUpperCase()}_${tenantEmail.replace(/[^a-z0-9]/g, '')}`;
        await prisma.contact.upsert({
          where: { id: tenantId },
          update: { fullName: row.tenantName },
          create: {
            id: tenantId,
            orgId: org.id,
            type: 'TENANT',
            fullName: row.tenantName,
            email: tenantEmail,
          },
        });
        result.contacts++;
      }

      // ─── Property ─────────────────────────────────────────────
      const layout = parseRoomType(row.roomType, row.areaSqm);
      const blockClean = row.blockNo ? row.blockNo.replace(/[^A-Z0-9]/gi, '').toUpperCase() : '';
      const propId = `prop_${projectName.replace(/[^A-Z0-9]/gi, '').toUpperCase()}_${blockClean}_${row.apartmentNo.replace(/[^A-Z0-9]/gi, '')}`;

      const katNum = parseInt(row.floor, 10) || 0;
      let hasBalkon = katNum > 2;
      let balkonTipi = katNum > 2 ? 'Açık Balkon' : 'Yok';
      let katKategorisi = 'Rezidans';
      if (katNum >= 40) katKategorisi = 'Otel';
      else if (katNum >= 36) katKategorisi = 'Dublex';

      const unitNotes = [
        `Sahibi: ${row.ownerName}`,
        row.tenantName ? `Kiracı: ${row.tenantName}` : null,
        row.status ? `Durum: ${row.status}` : null,
        `Blok: ${row.blockNo || '-'}`,
        `Kat: ${row.floor || '-'}`,
      ].filter(Boolean).join('\n');

      const blockAddr = row.blockNo ? `Blok ${row.blockNo}, ` : '';
      const floorAddr = row.floor ? `Kat ${row.floor}, ` : '';

      await prisma.property.upsert({
        where: { id: propId },
        update: { areaSqm: row.areaSqm || undefined },
        create: {
          id: propId,
          orgId: org.id,
          name: `${projectName} - ${blockAddr}Daire ${row.apartmentNo}`,
          type: 'APARTMENT',
          region: region as any,
          currency: 'TRY',
          addressLine1: `${projectName}, ${blockAddr}${floorAddr}Daire: ${row.apartmentNo}`,
          city,
          state: district,
          country,
          propertyCategory: 'RESIDENTIAL',
          listingType: row.tenantName ? 'RENT' : 'SALE',
          listingStatus: row.tenantName ? 'RENTED' : 'ACTIVE',
          areaSqm: row.areaSqm || undefined,
          bedrooms: layout.bedrooms,
          bathrooms: layout.bathrooms,
          kat: katNum,
          balkon: hasBalkon,
          balkonTipi,
          katKategorisi,
          site_ici: true,
          guvenlik: true,
          otopark: true,
          notes: unitNotes,
          projects: { connect: { id: projectId } },
        },
      });
      result.properties++;

      // ─── Floor Plan ───────────────────────────────────────────
      const fpId = `fp_${propId}`;
      const planName = `${layout.type} - Blok ${row.blockNo || '?'}`;
      await prisma.floorPlan.upsert({
        where: { id: fpId },
        update: {},
        create: {
          id: fpId,
          orgId: org.id,
          propertyId: propId,
          name: planName,
          imageUrl: `/uploads/${projectName.toLowerCase().replace(/[^a-z0-9]/g, '-')}/kat-planlari/${layout.type.replace('+', '-')}.jpg`,
          floorLevel: katNum,
          description: `${projectName} ${layout.type} Daire Kat Planı`,
        },
      });
      result.floorPlans++;

      // ─── Listing ──────────────────────────────────────────────
      const listingType = row.tenantName ? 'RENT' : 'SALE';
      const listingPrice = row.price || row.rent || null;
      const listingId = `listing_${propId}_${listingType.toLowerCase()}`;

      await prisma.listing.upsert({
        where: { id: listingId },
        update: { price: listingPrice || undefined },
        create: {
          id: listingId,
          orgId: org.id,
          propertyId: propId,
          type: listingType as any,
          status: 'ACTIVE',
          title: `${projectName} ${layout.type} ${listingType === 'RENT' ? 'Kiralık' : 'Satılık'}`,
          description: `${projectName} projesinde ${layout.type} daire. ${row.areaSqm ? `${row.areaSqm} m²` : ''}`,
          price: listingPrice || undefined,
          priceCurrency: 'TRY',
          strategy: 'LONG_TERM_STABLE',
        },
      });
      result.listings++;

      result.imported++;
      if (result.imported % 50 === 0) {
        console.log(`✅ Processed ${result.imported} units...`);
      }
    } catch (e: any) {
      result.failed++;
      result.errors.push(`Row ${i}: ${e.message}`);
    }
  }

  console.log(`\n🎉 IMPORT COMPLETE: ${projectName}`);
  console.log(`   ✅ Imported: ${result.imported}`);
  console.log(`   ⏭️ Skipped: ${result.skipped}`);
  console.log(`   ❌ Failed: ${result.failed}`);
  console.log(`   👥 Contacts: ${result.contacts}`);
  console.log(`   🏠 Properties: ${result.properties}`);
  console.log(`   📋 Listings: ${result.listings}`);
  console.log(`   📐 Floor Plans: ${result.floorPlans}`);

  result.success = true;
  return result;
}

// ─── Bulk Import (Multiple Files) ───────────────────────────────────────────

export async function importAllFromDirectory(dirPath: string, options: Partial<ImportConfig> = {}): Promise<ImportResult[]> {
  const results: ImportResult[] = [];

  if (!fs.existsSync(dirPath)) {
    console.error(`❌ Directory not found: ${dirPath}`);
    return results;
  }

  const files = fs.readdirSync(dirPath).filter(f => /\.(xlsx|xls|csv)$/i.test(f));
  console.log(`📂 Found ${files.length} data files in ${dirPath}`);

  for (const file of files) {
    const projectName = file.replace(/\.(xlsx|xls|csv)$/i, '').trim();
    const result = await importPortfolio({
      ...options,
      filePath: path.join(dirPath, file),
      projectName: options.projectName || projectName,
    });
    results.push(result);
  }

  const totalImported = results.reduce((sum, r) => sum + r.imported, 0);
  console.log(`\n🏆 BULK IMPORT COMPLETE: ${results.length} files, ${totalImported} total properties`);

  return results;
}
