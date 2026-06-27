import * as fs from 'fs';
import * as path from 'path';
import { parse } from 'csv-parse/sync';
import prismaManager from '../lib/prisma';
import { ContactType } from '../../generated/prismabox/Contact';

const CSV_PATH = '/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/Merkez Mahallesi/Bomonti Residences By Rotana/ROTANA-BOMONTİ son (1) 2.csv';

async function main() {
  console.log("🚀 Starting Rotana Bomonti import process...");
  const prisma = prismaManager.getClient('TR');

  // 1. Ensure Organization exists
  const orgName = "Anthill Residence Management"; // we can use the same or create a new one
  let org = await prisma.organization.findFirst({
    where: { name: orgName }
  });

  if (!org) {
    org = await prisma.organization.create({
      data: {
        id: "org_anthill_mgmt", // Using same org for simplicity, or we can use org_rotana
        name: orgName,
        type: "PROPERTY_MANAGER",
        slug: "anthill-residence-management",
      }
    });
    console.log(`✅ Organization created: ${orgName}`);
  } else {
    console.log(`✅ Organization found: ${org.name}`);
  }

  // 2. Master Property
  const masterPropId = 'prop_ROTANA_MASTER';
  await prisma.property.upsert({
    where: { id: masterPropId },
    update: {
      name: 'Bomonti Residences By Rotana',
    },
    create: {
      id: masterPropId,
      orgId: org.id,
      name: 'Bomonti Residences By Rotana',
      type: 'APARTMENT',
      region: 'TR_MARMARA',
      country: 'TR',
      city: 'Istanbul',
      state: 'Şişli',
      addressLine1: 'Merkez Mah. Güvenc Sok. No: 33 Şişli/İstanbul',
      zip: '34381',
      lat: 41.0583,
      lng: 28.9794,
      currency: 'TRY',
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'SOLD',
    }
  });
  console.log(`🏢 Master Property verified: ${masterPropId}`);

  // 3. Project
  const projectId = 'proj_ROTANA';
  await prisma.project.upsert({
    where: { id: projectId },
    update: {
      name: 'Bomonti Residences By Rotana',
    },
    create: {
      id: projectId,
      orgId: org.id,
      name: 'Bomonti Residences By Rotana',
      description: 'Luxury residences managed by Rotana, located in the heart of Bomonti.',
      projectType: 'RESIDENTIAL',
      status: 'COMPLETED',
      address: 'Merkez Mah. Güvenc Sok. No: 33 Şişli/İstanbul',
      propertyId: masterPropId,
      budget: 150000000,
      currency: 'TRY'
    }
  });
  console.log(`🏗️ Project verified: Bomonti Residences By Rotana`);

  // 4. Parse CSV
  console.log("📂 Reading CSV file...");
  const csvContent = fs.readFileSync(CSV_PATH, 'utf-8');
  const records = parse(csvContent, {
    columns: true,
    skip_empty_lines: true,
    delimiter: ';',
    trim: true,
  });

  console.log(`📊 Found ${records.length} records in CSV.`);

  // Mapping function to be filled out with the user's detailed floor plan
  function getLayoutFromKapiNo(kapiNoStr: string) {
    const kapiNo = parseInt(kapiNoStr, 10);
    // TODO: USER WILL PROVIDE FLOOR MAPPING
    // Example format expected to return:
    return {
      blok: 'A', // Unknown
      kat: Math.floor(kapiNo / 10), // Unknown
      type: '1+1', // Unknown
      bedrooms: 1, // Unknown
      bathrooms: 1, // Unknown
      sqm: 80, // Unknown
      balkonTipi: 'Yok', // Unknown
      katKategorisi: 'Rezidans' // Unknown
    };
  }

  let successCount = 0;

  for (const row of records) {
    const kapiNo = row["Kapı No"];
    if (!kapiNo) continue;

    let ownerName = String(row["Müşteri Adı"] || '').trim();
    if (!ownerName) ownerName = 'GİZLİ YATIRIMCI';
    if (ownerName.endsWith(" 100%")) {
        ownerName = ownerName.replace(" 100%", "");
    }

    const phone1 = String(row["Telefon 1"] || '').trim();
    const phone2 = String(row["Telefon 2"] || '').trim();
    const phone = phone2 || phone1; // Prefer mobile

    let email = String(row["E-Posta"] || '').trim().toLowerCase();
    if (!email || email === '-') {
      const safeName = ownerName.toLowerCase().replace(/[^a-z0-9]/g, '').substring(0, 15);
      email = `${safeName || 'owner'}_${kapiNo}@rotana.import`;
    }

    const taxId = row["T.C. Kimlik/Vergi No"];

    try {
      // 1. Owner Contact
      const ownerContactId = `contact_rotana_owner_${email.replace(/[^a-z0-9]/g, "")}`;
      await prisma.contact.upsert({
        where: { id: ownerContactId },
        update: {
          fullName: ownerName,
          phone: phone || null,
          taxId: taxId || null,
        },
        create: {
          id: ownerContactId,
          orgId: org.id,
          type: ContactType.OWNER_CONTACT,
          fullName: ownerName,
          email,
          phone: phone || null,
          taxId: taxId || null,
          notes: `İçe aktarma Rotana. Adres: ${row["Adres"]} ${row["Adres İlçesi"]}/${row["Adres İli"]}`,
        }
      });

      // 2. Unit Mapping (Waiting for user details)
      const layout = getLayoutFromKapiNo(kapiNo);
      
      const propId = `ROT-${layout.blok}${layout.kat.toString().padStart(2, '0')}${kapiNo.padStart(2, '0')}`;

      // Create property logic will go here once the layout logic is provided by user.
      // For now, we will just count it to verify processing works.
      successCount++;
    } catch (error) {
      console.error(`❌ Error processing Kapı No ${kapiNo}:`, error);
    }
  }

  console.log(`🎉 Processed ${successCount} records. Waiting for floor plan mapping to create Properties.`);
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
