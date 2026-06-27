import { ContactType, ListingStatus, ListingType, PropertyCategory, PropertyType, Region } from '@/schemas/generated';
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';

const DATA_DIR = path.join(__dirname, '../../data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL');
const A_BLOK_CSV = path.join(DATA_DIR, 'A Blok Anthill Haziran 2018.csv');
const B_BLOK_CSV = path.join(DATA_DIR, 'B Blok Güncel Düzenlenmiş.csv');

// Parse a semicolon-separated CSV
function parseCSV(filePath: string) {
  if (!fs.existsSync(filePath)) {
    console.error(`❌ CSV file not found: ${filePath}`);
    return [];
  }
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split(/\r?\n/);
  if (lines.length === 0) return [];

  const headers = lines[0].split(';');
  const results = [];

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

async function run() {
  console.log('🌟 INGESTION ENGINE INITIATED FOR ANTHILL RESIDENCE 🌟');

  // Connect to TR Database
  const prisma = prismaManager.getClient('TR');
  console.log('🔗 Connected to Turkey Database');

  // 1. Ensure Turkey organization exists
  const org = await prisma.organization.upsert({
    where: { id: 'tr_residence_org' },
    update: {
      name: 'Reservatior Turkey - Premium Residences',
    },
    create: {
      id: 'tr_residence_org',
      name: 'Reservatior Turkey - Premium Residences',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'TRY',
      defaultLocale: 'tr-TR',
    }
  });
  console.log(`🏢 Organization verified: ${org.name} (${org.id})`);

  // 2. Create/Upsert the Master Property
  const masterPropId = 'prop_ANTHILL_MASTER';
  await prisma.property.upsert({
    where: { id: masterPropId },
    update: {
      name: 'Anthill Residence (Master Building)',
      addressLine1: 'Cumhuriyet Mah. İncirlidede Cad. No:6',
      city: 'Istanbul',
      state: 'Şişli',
      country: 'TR',
      lat: 41.055611,
      lng: 28.980645,
      yearBuilt: 2011,
      notes: 'Master Building property for Anthill Residence.'
    },
    create: {
      id: masterPropId,
      orgId: org.id,
      name: 'Anthill Residence (Master Building)',
      type: 'APARTMENT',
      region: 'TR',
      currency: 'TRY',
      addressLine1: 'Cumhuriyet Mah. İncirlidede Cad. No:6',
      city: 'Istanbul',
      state: 'Şişli',
      country: 'TR',
      lat: 41.055611,
      lng: 28.980645,
      propertyCategory: 'RESIDENTIAL',
      listingType: 'SALE',
      listingStatus: 'SOLD',
      guvenlik: true,
      otopark: true,
      havuz: true,
      spor_salonu: true,
      jenerator: true,
      kamera_sistemi: true,
      yearBuilt: 2011,
      notes: 'Master Building property for Anthill Residence.'
    }
  });
  console.log(`🏢 Master Property verified: prop_ANTHILL_MASTER`);

  // 3. Create/Upsert the Project
  const projectId = 'proj_ANTHILL';
  await prisma.project.upsert({
    where: { id: projectId },
    update: {
      name: 'Anthill Residence',
      description: 'Anthill Residence offers a spectacular 360-degree view of Istanbul. Twin towers soaring into the sky with luxury residential units.',
      address: 'Cumhuriyet Mah. İncirlidede Cad. No:6, Şişli/İstanbul',
    },
    create: {
      id: projectId,
      orgId: org.id,
      name: 'Anthill Residence',
      description: 'Anthill Residence offers a spectacular 360-degree view of Istanbul. Twin towers soaring into the sky with luxury residential units.',
      projectType: 'RESIDENTIAL',
      status: 'COMPLETED',
      address: 'Cumhuriyet Mah. İncirlidede Cad. No:6, Şişli/İstanbul',
      propertyId: masterPropId,
      budget: 250000000,
      currency: 'TRY'
    }
  });
  console.log(`🏗️ Project verified: Anthill Residence (${projectId})`);

  // 4. Create/Upsert the Facility
  const facilityId = 'fac_ANTHILL_RESIDENCE';
  await prisma.facility.upsert({
    where: { id: facilityId },
    update: {
      name: 'Anthill Residence Complex',
    },
    create: {
      id: facilityId,
      orgId: org.id,
      propertyId: masterPropId,
      name: 'Anthill Residence Complex',
      notes: 'Main facility for Anthill Residence complex, including pool, gym, parking, and security.'
    }
  });
  console.log(`🏢 Facility verified: Anthill Residence Complex (${facilityId})`);

  const genelGorseller = [
    '/uploads/anthill/genel_gorseller/3cdc6f475dcf4136adac6a50f408677a.medium.jpg',
    '/uploads/anthill/genel_gorseller/Anthill_residence_with_flags.jpg',
    '/uploads/anthill/genel_gorseller/TURKECO-Yesil-Bina-Danismanligi-referanslar-Anthill-Residence-K-2-breeam-sertifikasi.webp',
    '/uploads/anthill/genel_gorseller/project_top_image_318e7f19ac03bcd271d864e5f5a83aa8.jpg'
  ];

  let successCount = 0;
  let failCount = 0;

  async function processBlock(rows: any[], blokName: string) {
    for (const row of rows) {
      const kapıNo = row["NO"];
      if (!kapıNo) continue;

      let ownerName = String(row["EV SAHİBİ"] || row["Ev Sahibi"] || '').trim();
      if (!ownerName) ownerName = 'GİZLİ YATIRIMCI';

      const phone = String(row["TELEFON"] || '').trim();
      let email = String(row["MAİL"] || '').trim().toLowerCase();
      
      // Fallback email
      if (!email || email.includes('example.com') || email === 'null' || email === '-') {
        const safeName = ownerName.toLowerCase().replace(/[^a-z0-9]/g, '').substring(0, 15);
        email = `${safeName || 'owner'}_${blokName.replace(' ', '')}_${kapıNo}@anthill.import`;
      }

      const kat = row["KAT"] || "0";
      const m2 = row["M2"] ? parseInt(row["M2"]) : null;
      const tenantName = String(row["KİRACI"] || '').trim();
      
      const contactNotes = [
        `Blok: ${blokName}, Kapı No: ${kapıNo}`,
        `Durum: ${row["DURUM"] || ''}`
      ].filter(Boolean).join('\n');

      try {
        // Owner Contact
        const ownerContactId = `contact_anthill_owner_${email.replace(/[^a-z0-9]/g, "")}`;
        await prisma.contact.upsert({
          where: { id: ownerContactId },
          update: {
            fullName: ownerName,
            phone: phone || null,
            notes: contactNotes,
          },
          create: {
            id: ownerContactId,
            orgId: org.id,
            type: ContactType.OWNER_CONTACT,
            fullName: ownerName,
            email,
            phone: phone || null,
            notes: contactNotes,
          }
        });

        // Tenant Contact
        let tenantContactId = null;
        if (tenantName) {
           const safeTenant = tenantName.toLowerCase().replace(/[^a-z0-9]/g, '').substring(0, 15);
           tenantContactId = `contact_anthill_tenant_${safeTenant}_${kapıNo}`;
           await prisma.contact.upsert({
            where: { id: tenantContactId },
            update: {
              fullName: tenantName,
            },
            create: {
              id: tenantContactId,
              orgId: org.id,
              type: ContactType.TENANT,
              fullName: tenantName,
              email: `${safeTenant}_${kapıNo}@anthill.tenant`,
            }
          });
        }

        // Deterministic Property ID prevents duplicates
        const propId = `prop_ANTHILL_${blokName.replace(' ', '')}_${kapıNo}`;
        const katNum = parseInt(kat, 10) || 0;
        
        // ─── DAİRE TİPİ (m² tabanlı doğru haritalama) ────────────────
        function getLayoutFromM2(sqm: number): { type: string; plan: string; bedrooms: number; bathrooms: number; planImage: string } {
          // Absolute path resolving or relative web paths. We'll map them relative to public web folder /uploads/anthill
          switch (sqm) {
            case 86:  return { type: '1+1', plan: 'Tip 3 / C1 / I1', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 3 Anthill.png' };
            case 88:  return { type: '1+1', plan: 'C2 / C3', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 8 Anthill.png' };
            case 95:  return { type: '1+1', plan: 'I4', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 3 Anthill.png' };
            case 96:  return { type: '2+1', plan: 'H1', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 98:  return { type: '2+1', plan: 'K1', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 99:  return { type: '2+1', plan: 'Özel', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 100: return { type: '2+1', plan: 'H2', bedrooms: 2, bathrooms: 1, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 102: return { type: '2+1', plan: 'K2', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 109: return { type: '2+1', plan: 'J1', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 110: return { type: '2+1', plan: 'B1', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19 Floors.jpg' };
            case 111: return { type: '2+1', plan: 'B1-Varyant', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19 Floors.jpg' };
            case 112: return { type: '2+1', plan: 'D3 / B3', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg' };
            case 113: return { type: '2+1', plan: 'D3-Varyant', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg' };
            case 118: return { type: '2+1', plan: 'J4 (Balkonlu)', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/2+1/Ekran Resmi 1441-04-27 20.17.48.png' };
            case 121: return { type: '2+1', plan: 'D4 (Balkonlu)', bedrooms: 2, bathrooms: 2, planImage: '/uploads/anthill/planlar/6-14-19-24 Floors.jpg' };
            default:
              if (sqm >= 180 && sqm < 200) return { type: '3+1', plan: 'A1/A4', bedrooms: 3, bathrooms: 2, planImage: '/uploads/anthill/planlar/35-39 Floors 3,4+1.jpg' };
              if (sqm >= 200) return { type: '4+1', plan: 'E1/E4', bedrooms: 4, bathrooms: 3, planImage: '/uploads/anthill/planlar/35-39 Floors 3,4+1.jpg' };
              return { type: '1+1', plan: 'Standart', bedrooms: 1, bathrooms: 1, planImage: '/uploads/anthill/planlar/1+1/Tip 3 Anthill.png' };
          }
        }
 
        // Balkon tipi (kat aralığına göre)
        let hasBalkon = false;
        let balkonTipi = 'Yok';
        if (katNum <= 2) {
          hasBalkon = false;
          balkonTipi = 'Yok';
        } else if (katNum <= 25) {
          hasBalkon = true;
          balkonTipi = 'Açık Balkon';
        } else if (katNum <= 30) {
          hasBalkon = true;
          balkonTipi = 'French Balkon';
        } else if (katNum <= 35) {
          hasBalkon = false;
          balkonTipi = 'Yok';
        } else if (katNum <= 39) {
          hasBalkon = true;
          balkonTipi = 'Teras';
        }
 
        let katKategorisi = 'Rezidans';
        if (katNum >= 40) katKategorisi = 'Otel';
        else if (katNum >= 36) katKategorisi = 'Dublex';
 
        const normalizedBlok = blokName.replace(/[^a-zA-Z]/g, '').toUpperCase();
        const blokChar = normalizedBlok.startsWith('B') ? 'B' : 'A';
        const katStr = String(katNum).padStart(2, '0');
        const noStr = String(kapıNo).padStart(2, '0');
        const unitId = `ANT-${blokChar}${katStr}${noStr}`;
 
        const actualM2 = m2 || 86; // CSV'de m² yoksa en küçük tip (86)
        const layoutInfo = getLayoutFromM2(actualM2);
 
        const bedrooms = layoutInfo.bedrooms;
        const bathrooms = layoutInfo.bathrooms;
        const planName = `${layoutInfo.type} - ${layoutInfo.plan}`;
        const planImageUrl = layoutInfo.planImage;
 
        const unitNotes = `Sahibi: ${ownerName}\nKiracı: ${tenantName || 'Yok'}\nDurum: ${row["DURUM"] || ''}\nUnit ID: ${unitId}\nBalkon: ${balkonTipi}\nKategori: ${katKategorisi}`;
 
        const propertyData = {
          orgId: org.id,
          name: `Anthill ${blokName} - Daire ${kapıNo}`,
          type: PropertyType.APARTMENT,
          region: Region.TR,
          currency: 'TRY',
          addressLine1: `Cumhuriyet Mah. İncirlidede Cad. No:6 ${blokName} Daire: ${kapıNo}`,
          city: 'Istanbul',
          state: 'Şişli',
          country: 'TR',
          daireNo: kapıNo.toString(),
          site_ici: true,
          notes: unitNotes,
          kat: katNum,
          bedrooms,
          bathrooms,
          balkon: hasBalkon,
          balkonTipi,
          katKategorisi,
          unitId,
          areaSqm: actualM2,
          yearBuilt: 2011,
          propertyCategory: PropertyCategory.RESIDENTIAL,
          listingType: tenantName ? ListingType.RENT : ListingType.SALE,
          listingStatus: tenantName ? ListingStatus.RENTED : ListingStatus.SOLD,
          guvenlik: true,
          otopark: true,
          havuz: true,
          spor_salonu: true,
        };
 
        const property = await prisma.property.upsert({
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
 
        // Upsert FloorPlan for this property
        await prisma.floorPlan.upsert({
          where: { id: `fp_${propId}` },
          update: {
            name: planName,
            imageUrl: planImageUrl,
            floorLevel: katNum
          },
          create: {
            id: `fp_${propId}`,
            orgId: org.id,
            propertyId: propId,
            name: planName,
            imageUrl: planImageUrl,
            floorLevel: katNum,
            description: `Anthill Residence ${bedrooms}+1 Daire Kat Planı`
          }
        });
 
        // ─── DİNAMİK FOTOĞRAF VE VİDEO INGESTION (DİJİTAL İKİZ) ───
        // Search in: PLANLAR&Fotolar/Blok [A/B]/[1+1 or 2+1]/[Axxxx or Bxxxx]
        const typeFolderName = `${bedrooms}+1`;
        const folderName = `${blokChar}${String(katNum).padStart(2, '0')}${String(kapıNo).padStart(2, '0')}`;
        const targetUnitPhotosPath = path.join(DATA_DIR, 'PLANLAR&Fotolar', `Blok ${blokChar}`, typeFolderName, folderName);
        
        let unitPhotos: string[] = [];
        
        if (fs.existsSync(targetUnitPhotosPath) && fs.statSync(targetUnitPhotosPath).isDirectory()) {
          const files = fs.readdirSync(targetUnitPhotosPath);
          const imageExtensions = ['.jpg', '.jpeg', '.png', '.webp'];
          unitPhotos = files
            .filter(f => imageExtensions.includes(path.extname(f).toLowerCase()))
            .map(f => `/uploads/anthill/planlar_fotolar/Blok_${blokChar}/${typeFolderName}/${folderName}/${f}`);
        }

        // If no unit specific photos found, fall back to general images
        const finalPhotos = unitPhotos.length > 0 ? unitPhotos : genelGorseller;
 
        // Attach PropertyPhotos
        for (let i = 0; i < finalPhotos.length; i++) {
          const photoId = `photo_${propId}_${i}`;
          await prisma.propertyPhoto.upsert({
            where: { id: photoId },
            update: {
              url: finalPhotos[i],
              isPrimary: i === 0,
              sortOrder: i
            },
            create: {
              id: photoId,
              orgId: org.id,
              propertyId: propId,
              url: finalPhotos[i],
              isPrimary: i === 0,
              sortOrder: i,
              caption: unitPhotos.length > 0 ? `Anthill Daire ${folderName} Özel Görsel` : 'Anthill Residence Genel Görsel'
            }
          });
        }

        // Optional: Associate videos if they exist (e.g. A3904.MOV or A3904-2.MOV in Blok [A/B]/Videolar)
        const videosDir = path.join(DATA_DIR, 'PLANLAR&Fotolar', `Blok ${blokChar}`, 'Videolar');
        if (fs.existsSync(videosDir) && fs.statSync(videosDir).isDirectory()) {
          const videoFiles = fs.readdirSync(videosDir);
          // Look for any video file matching the folderName prefix
          const matchingVideos = videoFiles.filter(f => f.toLowerCase().startsWith(folderName.toLowerCase()) && f.toLowerCase().endsWith('.mov'));
          
          for (let v = 0; v < matchingVideos.length; v++) {
            const documentId = `doc_video_${propId}_${v}`;
            const videoUrl = `/uploads/anthill/planlar_fotolar/Blok_${blokChar}/Videolar/${matchingVideos[v]}`;
            
            await prisma.document.upsert({
              where: { id: documentId },
              update: { fileUrl: videoUrl },
              create: {
                id: documentId,
                orgId: org.id,
                propertyId: propId,
                title: `${folderName} Daire Tur Videosu ${v + 1}`,
                documentType: 'CERTIFICATE',
                fileUrl: videoUrl,
                mimeType: 'video/quicktime',
                fileSize: 0,
                checksum: 'placeholder',
                fileName: matchingVideos[v],
              }
            });
          }
        }
 
        successCount++;
        if (successCount % 50 === 0) {
          console.log(`✅ Processed ${successCount} units successfully.`);
        }
      } catch (e: any) {
        failCount++;
        console.error(`❌ Failed to process ${blokName} No ${kapıNo}:`, e.message);
      }
    }
  }
 
  const aBlokRows = parseCSV(A_BLOK_CSV);
  console.log(`📊 A Blok rows: ${aBlokRows.length}`);
  await processBlock(aBlokRows, 'A Blok');
 
  const bBlokRows = parseCSV(B_BLOK_CSV);
  console.log(`📊 B Blok rows: ${bBlokRows.length}`);
  await processBlock(bBlokRows, 'B Blok');
 
  console.log(`\n🎉 INGESTION RUN SUMMARY:`);
  console.log(`   - Success: ${successCount} units`);
  console.log(`   - Fails: ${failCount} units`);
  console.log(`   - Total processed: ${successCount + failCount}`);
  console.log('🏆 ANTHILL RESIDENCE DATA IMPORT COMPLETED!');
}
 
run()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
