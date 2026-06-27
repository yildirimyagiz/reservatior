import { ContactType, PropertyType, PropertyCategory, ListingType, ListingStatus, Region } from '@/schemas/generated';
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';
import * as xlsx from 'xlsx';

const EXCEL_PATH = '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/Queen/Queen data daire sahipleri.xlsx';
const PDF_CSV_PATH = '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/Queen/queen_units.csv'; // Placeholder for the OCR'd CSV file

async function main() {
  console.log("🚀 Starting Queen Central Park Bomonti import process...");
  const prisma = prismaManager.getClient('TR');

  // 1. Ensure Organization exists
  const orgName = "Sinpaş Queen Management";
  let org = await prisma.organization.findFirst({
    where: { name: orgName }
  });

  if (!org) {
    org = await prisma.organization.create({
      data: {
        id: "org_queen_mgmt",
        name: orgName,
        type: "AGENCY",
        region: "TR",
      }
    });
    console.log(`✅ Organization created: ${orgName}`);
  } else {
    console.log(`✅ Organization found: ${org.name}`);
  }

  // 2. Master Property
  const masterPropId = 'prop_QUEEN_MASTER';
  await prisma.property.upsert({
    where: { id: masterPropId },
    update: {
      name: 'Sinpaş Queen Central Park Bomonti',
    },
    create: {
      id: masterPropId,
      orgId: org.id,
      name: 'Sinpaş Queen Central Park Bomonti',
      type: 'APARTMENT',
      region: 'TR',
      country: 'TR',
      city: 'Istanbul',
      state: 'Şişli',
      addressLine1: 'Cumhuriyet Mah. Bomonti, Şişli/İstanbul',
      zip: '34380',
      lat: 41.0560,
      lng: 28.9800,
      currency: 'TRY',
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'SOLD',
    }
  });
  console.log(`🏢 Master Property verified: ${masterPropId}`);

  // 3. Project
  const projectId = 'proj_QUEEN';
  await prisma.project.upsert({
    where: { id: projectId },
    update: {
      name: 'Sinpaş Queen Central Park Bomonti',
    },
    create: {
      id: projectId,
      orgId: org.id,
      name: 'Sinpaş Queen Central Park Bomonti',
      description: 'Luxury residences in Bomonti with stunning city and Bosphorus views, featuring extensive social facilities.',
      projectType: 'RESIDENTIAL',
      status: 'COMPLETED',
      address: 'Cumhuriyet Mah. Bomonti, Şişli/İstanbul',
      propertyId: masterPropId,
      budget: 350000000,
      currency: 'TRY'
    }
  });
  console.log(`🏗️ Project verified: Sinpaş Queen Central Park Bomonti`);

  // 4. Parse Excel for Contacts
  console.log("📂 Reading Contacts Excel file...");
  if (fs.existsSync(EXCEL_PATH)) {
    const workbook = xlsx.readFile(EXCEL_PATH);
    const sheet = workbook.Sheets[workbook.SheetNames[0]];
    const data = xlsx.utils.sheet_to_json(sheet, { header: 1 }) as string[][];

    let contactCount = 0;
    for (let i = 1; i < data.length; i++) {
      const row = data[i];
      if (!row || row.length < 2) continue;

      const not = String(row[0] || '').trim();
      const isimSoyisim = String(row[1] || '').trim();
      const telefon = String(row[2] || '').trim();
      const mail = String(row[3] || '').trim().toLowerCase();

      if (!isimSoyisim) continue;

      // Extract multiple names if separated by '-'
      const names = isimSoyisim.split('-').map(n => n.trim()).filter(Boolean);

      for (const name of names) {
        if (!name) continue;
        const safeName = name.toLowerCase().replace(/[^a-z0-9]/g, '').substring(0, 15);
        const email = mail || `${safeName}@queen.import`;

        const contactId = `contact_queen_${email.replace(/[^a-z0-9]/g, "")}`;
        
        try {
          await prisma.contact.upsert({
            where: { id: contactId },
            update: {
              fullName: name.toUpperCase(),
              phone: telefon || null,
              notes: not ? `Not: ${not}` : undefined,
            },
            create: {
              id: contactId,
              orgId: org.id,
              type: ContactType.OWNER_CONTACT,
              fullName: name.toUpperCase(),
              email: email,
              phone: telefon || null,
              notes: not ? `Not: ${not}` : undefined,
            }
          });
          contactCount++;
        } catch (e) {
          console.error(`Error importing contact ${name}:`, e);
        }
      }
    }
    console.log(`✅ Imported ${contactCount} contacts from Excel.`);
  }

  // 5. Parse Properties from enriched CSV
  const CSV_PATH = '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/Queen/queen_units.csv';
  
  if (fs.existsSync(CSV_PATH)) {
    console.log("📂 Reading enriched Units CSV...");
    const csvContent = fs.readFileSync(CSV_PATH, 'utf-8');
    const lines = csvContent.split('\n').filter(l => l.trim());
    const headers = lines[0].split(',');
    
    let propertyCount = 0;
    let floorPlanCount = 0;

    // Floor plan image mapping based on daire tipi and m2
    function getFloorPlanImage(daireTipi: string, m2: number, katNum: number): string {
      const base = '/uploads/queen/kat-planlari';
      if (daireTipi === '1+0' || daireTipi === 'Studio') {
        if (katNum >= 39) return `${base}/Studio/St 39-48.jpg`;
        return `${base}/Studio/St 1-38.jpg`;
      }
      if (daireTipi === '1+1') {
        if (m2 >= 98) return `${base}/1+1/98-113 m2/A-K.jpg`;
        if (katNum >= 39) return `${base}/1+1/77-98 m2/S 39-48.jpg`;
        return `${base}/1+1/Queen 1+1 Daire 1.png`;
      }
      if (daireTipi === '2+1') {
        if (m2 >= 160) return `${base}/2+1/2+1 162 m2.jpg`;
        if (m2 >= 148) return `${base}/2+1/150 m2.jpg`;
        return `${base}/2+1/2+1 Small.jpg`;
      }
      if (daireTipi === '2.5+1') {
        if (katNum >= 39) return `${base}/2,5+1/Daire B2 2,5+1 : 39- 48 Katlar - Queen.png`;
        return `${base}/2,5+1/Daire B2 7-38 Katlar Queen.png`;
      }
      if (daireTipi === '3.5+1') {
        if (katNum >= 39) return `${base}/3,5+1/Daire B3 3,5+1  : 39-48 Katlar Arası Queen.png`;
        return `${base}/3,5+1/B3 3,5+1 7-38 Katlar Queen.png`;
      }
      if (daireTipi === '4.5+1') {
        if (katNum >= 39) return `${base}/4,5 +1/B4 4,5 + 1 : 39-47 Katlar Queen.png`;
        return `${base}/4,5 +1/B4 7-38 Katlar Queen.png`;
      }
      return `${base}/1+1/Queen 1+1 Daire 1.png`;
    }

    function getBedroomsBathrooms(daireTipi: string): { bedrooms: number; bathrooms: number } {
      switch (daireTipi) {
        case '1+0': case 'Studio': return { bedrooms: 0, bathrooms: 1 };
        case '1+1': return { bedrooms: 1, bathrooms: 1 };
        case '2+1': return { bedrooms: 2, bathrooms: 1 };
        case '2.5+1': return { bedrooms: 2, bathrooms: 2 };
        case '3.5+1': return { bedrooms: 3, bathrooms: 2 };
        case '4.5+1': return { bedrooms: 4, bathrooms: 3 };
        default: return { bedrooms: 1, bathrooms: 1 };
      }
    }

    for (let i = 1; i < lines.length; i++) {
      const cols = lines[i].split(',');
      const bbNo = parseInt(cols[0]);
      const tip = cols[1]?.trim();       // KONUT or TİCARET
      const eklentisi = cols[2]?.trim();
      const katStr = cols[3]?.trim();     // e.g. "11. KAT" or "5. BODRUM KAT"
      const m2 = parseFloat(cols[4]);
      const daireTipi = cols[5]?.trim() || '';
      const bbTipi = cols[6]?.trim() || '';
      const malSahibi = cols[7]?.trim() || '';

      if (!bbNo || isNaN(bbNo)) continue;

      // Parse floor number from "11. KAT" or "5. BODRUM KAT"
      let katNum = 0;
      const katMatch = katStr?.match(/(\d+)\./);
      if (katMatch) katNum = parseInt(katMatch[1]);
      if (katStr?.includes('BODRUM')) katNum = -katNum;

      // Generate unitId: QEN-KK-BBBB
      const katPadded = String(Math.abs(katNum)).padStart(2, '0');
      const bbPadded = String(bbNo).padStart(4, '0');
      const unitId = `QEN-${katNum < 0 ? 'B' : ''}${katPadded}-${bbPadded}`;

      const propId = `prop_queen_${bbNo}`;
      const { bedrooms, bathrooms } = getBedroomsBathrooms(daireTipi);

      const propertyCategory = tip === 'KONUT' ? PropertyCategory.RESIDENTIAL : PropertyCategory.COMMERCIAL;
      const propertyType = tip === 'KONUT' ? PropertyType.APARTMENT : PropertyType.COMMERCIAL;

      const notes = [
        `BB No: ${bbNo}`,
        daireTipi ? `Daire Tipi: ${daireTipi}` : null,
        bbTipi ? `BB Tipi: ${bbTipi}` : null,
        malSahibi ? `Mal Sahibi: ${malSahibi}` : null,
        eklentisi && eklentisi !== '-' ? `Eklenti: ${eklentisi}` : null,
        `Unit ID: ${unitId}`,
      ].filter(Boolean).join('\n');

      try {
        const propertyData = {
          orgId: org.id,
          name: tip === 'KONUT' 
            ? `Queen ${daireTipi || 'Daire'} - BB ${bbNo}` 
            : `Queen Ticaret - BB ${bbNo}`,
          type: propertyType,
          region: Region.TR,
          currency: 'TRY',
          addressLine1: `Cumhuriyet Mah. Bomonti, Şişli/İstanbul - BB ${bbNo}`,
          city: 'Istanbul',
          state: 'Şişli',
          country: 'TR',
          daireNo: bbNo.toString(),
          site_ici: true,
          notes,
          kat: katNum,
          bedrooms: tip === 'KONUT' ? bedrooms : 0,
          bathrooms: tip === 'KONUT' ? bathrooms : 0,
          unitId,
          areaSqm: m2 || 0,
          yearBuilt: 2018,
          propertyCategory,
          listingType: ListingType.SALE,
          listingStatus: ListingStatus.SOLD,
          guvenlik: true,
          otopark: true,
          havuz: true,
          spor_salonu: true,
        };

        await prisma.property.upsert({
          where: { id: propId },
          update: {
            ...propertyData,
            projects: { connect: { id: projectId } }
          },
          create: {
            id: propId,
            ...propertyData,
            projects: { connect: { id: projectId } }
          }
        });
        propertyCount++;

        // Create FloorPlan for KONUT units
        if (tip === 'KONUT' && daireTipi) {
          const planImageUrl = getFloorPlanImage(daireTipi, m2, katNum);
          await prisma.floorPlan.upsert({
            where: { id: `fp_${propId}` },
            update: {
              name: `${daireTipi} - ${katStr}`,
              imageUrl: planImageUrl,
              floorLevel: katNum,
            },
            create: {
              id: `fp_${propId}`,
              propertyId: propId,
              orgId: org.id,
              name: `${daireTipi} - ${katStr}`,
              imageUrl: planImageUrl,
              floorLevel: katNum,
            }
          });
          floorPlanCount++;
        }

        if (propertyCount % 50 === 0) {
          console.log(`  📦 ${propertyCount} properties imported...`);
        }
      } catch (e: any) {
        console.error(`❌ Error importing BB ${bbNo}:`, e.message?.substring(0, 200));
      }
    }

    console.log(`✅ Imported ${propertyCount} properties from CSV.`);
    console.log(`✅ Created ${floorPlanCount} floor plans.`);
  } else {
    console.log("⚠️ Units CSV not found at:", CSV_PATH);
  }
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    const prisma = prismaManager.getClient('TR');
    await prisma.$disconnect();
  });
