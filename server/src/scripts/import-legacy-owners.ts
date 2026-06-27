import { PrismaClient } from '@prisma/client';
import * as fs from 'fs';
import * as path from 'path';

const prisma = new PrismaClient();

const directories = [
  { path: '/Users/os2026/Documents/buyukyali_2019', project: 'Büyükyalı' },
  { path: '/Users/os2026/Documents/validebag_konaklari', project: 'Validebağ Konakları' },
  { path: '/Users/os2026/Library/Mobile Documents/com~apple~CloudDocs/Desktop/Desktop/Mahalle -İş/Projeler/Şişli - Mecidiyeköy/Quasar/QUASAR Sözleşmeler', project: 'Quasar İstanbul' }
];

const blockAptRegex = /([A-Z0-9]{1,3}-\d{1,3})/i;

async function run() {
  console.log('🏗️ Başlıyor: Mega Proje Mal Sahibi & Daire Kayıt İşlemi...');
  let totalImported = 0;
  
  // Create an agency/org to tie them to
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

  for (const dir of directories) {
    if (!fs.existsSync(dir.path)) {
      console.log(`\n❌ Klasör bulunamadı: ${dir.path}`);
      continue;
    }

    const files = fs.readdirSync(dir.path);
    console.log(`\n📂 Klasör taranıyor: ${dir.project} (${files.length} dosya bulundu)`);

    for (const file of files) {
      if (file.startsWith('.') || file.startsWith('~') || file.toLowerCase().includes('.xlsx') || file.toLowerCase().includes('.xls')) continue;

      let nameWithoutExt = file.replace(/\.[^/.]+$/, "");
      
      let blockApt = "Unknown";
      let ownerName = "";

      const match = nameWithoutExt.match(blockAptRegex);
      if (match) {
        blockApt = match[1];
        ownerName = nameWithoutExt.replace(blockApt, '').replace(/\s+/g, ' ').trim();
      } else {
        ownerName = nameWithoutExt.trim();
      }
      
      // Clean up common suffix/prefix like (1), Szleme, iptal, pdf etc
      ownerName = ownerName
        .replace(/\(\d+\)/g, '')
        .replace(/Szleme|sözleşme/gi, '')
        .replace(/sat--|satis|satış/gi, '')
        .replace(/iptal/gi, '')
        .replace(/orjinal/gi, '')
        .replace(/-/g, ' ')
        .trim();

      if (!ownerName || ownerName.length < 3) continue;

      const email = `${ownerName.toLowerCase().replace(/[^a-z0-9]/g, '')}_${Date.now().toString().slice(-4)}@${dir.project.toLowerCase().replace(/[^a-z0-9]/g, '')}.import`;
      
      try {
        const user = await prisma.user.create({
          data: {
            email,
            name: ownerName,
          }
        });

        const propId = `prop_${Date.now()}_${Math.floor(Math.random() * 10000)}`;

        await prisma.property.create({
          data: {
            id: propId,
            orgId: org.id,
            name: `${dir.project} - ${blockApt} Numaralı Bağımsız Bölüm`,
            type: 'APARTMENT',
            region: 'TR',
            currency: 'TRY',
            addressLine1: `${dir.project}, Blok-Daire: ${blockApt}`,
            city: 'Istanbul',
            country: 'TR',
            propertyCategory: 'RESIDENTIAL',
            listingType: 'SALE',
            listingStatus: 'SOLD',
            createdBy: user.id
          }
        });

        totalImported++;
        if (totalImported % 50 === 0) {
          console.log(`✅ ${totalImported} kayıt başarıyla veritabanına eklendi...`);
        }
      } catch (err: any) {
        console.error(`\nHata (${ownerName}):`, err.message.substring(0, 300));
      }
    }
  }

  console.log(`\n🎉 TAMAMLANDI! Toplam ${totalImported} adet mal sahibi ve daire (User & Property) başarıyla sisteme aktarıldı.`);
}

run()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
