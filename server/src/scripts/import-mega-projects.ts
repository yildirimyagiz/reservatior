import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';
import * as xlsx from 'xlsx'; // Requires: bun install xlsx

const prisma = prismaManager.getClient('TR');
const DATALAR_DIR = '/Users/os2026/Downloads/Reservatior/datalar/işlenenler';

async function run() {
  console.log('🌟 MASTER MEGA-PROJECT INGESTION ENGINE INITIATED 🌟');
  
  if (!fs.existsSync(DATALAR_DIR)) {
    console.error(`❌ Klasör bulunamadı: ${DATALAR_DIR}`);
    process.exit(1);
  }

  const files = fs.readdirSync(DATALAR_DIR).filter(f => f.endsWith('.xlsx') || f.endsWith('.xls'));
  console.log(`\n📂 ${files.length} Adet Mega-Proje Dosyası Bulundu. İşlem Başlıyor...\n`);

  const org = await prisma.organization.upsert({
    where: { id: 'tr_residence_org' },
    update: {},
    create: {
      id: 'tr_residence_org',
      name: 'Reservatior Turkey - Premium Residences',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    }
  });

  let grandTotal = 0;

  for (const file of files) {
    console.log(`\n======================================================`);
    console.log(`🏢 PROJE ANALİZ EDİLİYOR: ${file}`);
    console.log(`======================================================`);

    const filePath = path.join(DATALAR_DIR, file);
    const projectName = file.replace(/\.xlsx?$/i, '').trim().toUpperCase();

    // Create a specific Project entity
    const projectEntity = await prisma.project.upsert({
      where: { id: `proj_${projectName.replace(/[^A-Z0-9]/ig, "")}` },
      update: {},
      create: {
        id: `proj_${projectName.replace(/[^A-Z0-9]/ig, "")}`,
        orgId: org.id,
        name: projectName,
        projectType: "RESIDENTIAL",
        status: "COMPLETED",
        address: "İstanbul",
        currency: "TRY"
      }
    });

    let workbook;
    try {
      workbook = xlsx.readFile(filePath);
    } catch (e: any) {
      console.log(`⚠️ Excel dosyası okunamadı: ${e.message}`);
      continue;
    }

    const sheetName = workbook.SheetNames[0];
    const data: any[] = xlsx.utils.sheet_to_json(workbook.Sheets[sheetName]);
    
    console.log(`📊 ${data.length} satır veri tespit edildi.`);

    let projectImportCount = 0;

    for (const row of data) {
      if (!row) continue;

      // Heuristic (Yapay Zeka Mantığıyla) Sütun Tahmini
      const keys = Object.keys(row);
      
      let ownerName = '';
      let aptNo = '';
      let email = '';
      let phone = '';
      let blockNo = '';
      let floor = '';
      let squareMeters = '';

      for (const key of keys) {
        // Turkish characters normalization for keys
        const k = key.toLowerCase()
                     .replace(/i̇/g, 'i')
                     .replace(/ı/g, 'i')
                     .replace(/ş/g, 's')
                     .replace(/ğ/g, 'g')
                     .replace(/ü/g, 'u')
                     .replace(/ö/g, 'o')
                     .replace(/ç/g, 'c');

        const val = String(row[key]).trim();
        if (!val || val === 'undefined') continue;
        
        if (!ownerName && (k.includes('ad') || k.includes('isim') || k.includes('sahip') || k.includes('musteri') || k.includes('name') || k.includes('unvan') || k.includes('malik') || k.includes('alici') || k.includes('oturan'))) {
          if (val.length > 3) ownerName = val;
        }
        if (!aptNo && (k.includes('daire') || k === 'no' || k.includes('kapi') || k.includes('bolum') || k.includes('bagimsiz'))) {
          aptNo = val;
        }
        if (!email && (k.includes('mail') || k.includes('e-posta') || k.includes('eposta'))) {
          email = val;
        }
        if (!phone && (k.includes('tel') || k.includes('cep') || k.includes('gsm') || k.includes('irtibat'))) {
          phone = val;
        }
        if (!blockNo && (k.includes('blok') || k.includes('bina') || k.includes('residence') || k.includes('etap'))) {
          blockNo = val;
        }
        if (!floor && k.includes('kat')) {
          floor = val;
        }
        if (!squareMeters && (k.includes('m2') || k.includes('m²') || k.includes('alan') || k.includes('metrekare'))) {
          // clean any non-numeric characters except dots and commas
          squareMeters = val.replace(/[^0-9.,]/g, '').replace(',', '.');
        }
      }

      if (!ownerName) ownerName = 'GİZLİ YATIRIMCI'; // Fallback
      if (!aptNo) aptNo = `UNIT-${Math.floor(Math.random() * 9000) + 1000}`;
      if (!email) email = `${ownerName.toLowerCase().replace(/[^a-z0-9]/g, '')}_${Date.now().toString().slice(-4)}@${projectName.toLowerCase().replace(/[^a-z0-9]/g, '')}.import`;

      const addressBlock = blockNo ? `Blok ${blockNo}, ` : '';
      const addressFloor = floor ? `Kat ${floor}, ` : '';
      const m2Float = squareMeters ? parseFloat(squareMeters) : null;

      try {
        const contactId = `contact_mega_${email.replace(/[^a-z0-9]/g, "")}`;
        const contact = await prisma.contact.upsert({
          where: { id: contactId },
          update: {
            fullName: ownerName,
            phone: phone || null,
          },
          create: {
            id: contactId,
            orgId: org.id,
            type: "OWNER_CONTACT",
            fullName: ownerName,
            email,
            phone: phone || null,
          }
        });

        const propertyName = `${projectName} - ${addressBlock}Daire ${aptNo}`;
        const propId = `prop_${projectName.replace(/[^A-Z0-9]/ig, "")}_${addressBlock.replace(/[^A-Z0-9]/ig, "")}_${aptNo.replace(/[^A-Z0-9]/ig, "")}`;

        await prisma.property.upsert({
          where: { id: propId },
          update: {
            areaSqm: m2Float,
            addressLine1: `${projectName}, ${addressBlock}${addressFloor}Daire: ${aptNo}`,
            notes: `Sahibi: ${ownerName}`,
          },
          create: {
            id: propId,
            orgId: org.id,
            name: propertyName,
            type: 'APARTMENT',
            region: 'TR',
            currency: 'TRY',
            addressLine1: `${projectName}, ${addressBlock}${addressFloor}Daire: ${aptNo}`,
            city: 'Istanbul',
            country: 'TR',
            propertyCategory: 'RESIDENTIAL',
            listingType: 'SALE',
            listingStatus: 'SOLD',
            areaSqm: m2Float,
            notes: `Sahibi: ${ownerName}`
          }
        });

        projectImportCount++;
        grandTotal++;

        if (projectImportCount % 100 === 0) {
          process.stdout.write(`✅ ${projectImportCount} `);
        }
      } catch (err: any) {
        // Sessizce atla
      }
    }
    
    console.log(`\n✅ ${projectName} projesinden ${projectImportCount} bağımsız bölüm sisteme işlendi.`);
  }

  console.log(`\n🏆 MUAZZAM! TOPLAM ${grandTotal} ADET LÜKS GAYRİMENKUL VE MAL SAHİBİ SİSTEME EKLENDİ.`);
}

run()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
