import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

// Force the TR database explicitly
const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';
const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl
    }
  }
});

async function main() {
  console.log("🟢 WhatsApp Acentelerini İçeri Aktarma İşlemi (TR Veritabanı)");
  
  // 1. Marketing Organizasyonunu Bul veya Oluştur
  let org = await prisma.organization.findFirst({
    where: { name: 'Reservatior Marketing TR' }
  });

  if (!org) {
    console.log("📝 'Reservatior Marketing TR' organizasyonu oluşturuluyor...");
    org = await prisma.organization.create({
      data: {
        name: 'Reservatior Marketing TR',
        type: 'AGENCY', // Using OrgType AGENCY
        region: 'TR'
      }
    });
  }

  // 2. CSV Dosyasını Oku
  const csvPath = path.join(process.cwd(), 'data', 'all_members.csv');
  if (!fs.existsSync(csvPath)) {
    console.error("❌ Dosya bulunamadı:", csvPath);
    process.exit(1);
  }

  const fileContent = fs.readFileSync(csvPath, 'utf-8');
  const lines = fileContent.split('\n');
  
  // CSV başlığını atla
  const rows = lines.slice(1).filter(line => line.trim().length > 0);
  console.log(`📊 Toplam ${rows.length} kayıt bulundu. Yükleme başlıyor...`);

  let added = 0;
  let skipped = 0;

  for (const row of rows) {
    // Regex parsing to correctly handle fields quoted with "
    const matches = row.match(/(".*?"|[^",\s]+)(?=\s*,|\s*$)/g);
    if (!matches || matches.length < 3) continue;

    // Temizleme (Baştaki ve sondaki tırnakları kaldır)
    const rawName = matches[0].replace(/^"|"$/g, '').trim();
    let rawPhone = matches[1].replace(/^"|"$/g, '').trim();
    const rawGroup = matches[2].replace(/^"|"$/g, '').trim();

    if (!rawPhone) continue;
    
    // Telefon numarasını temizle (Sadece rakamları al)
    rawPhone = rawPhone.replace(/\D/g, '');
    if (!rawPhone.startsWith('90') && rawPhone.length === 10) {
      rawPhone = '90' + rawPhone;
    } else if (rawPhone.startsWith('05')) {
      rawPhone = '90' + rawPhone.substring(1);
    }

    // Telefon daha önce eklendiyse atla
    const existingLead = await prisma.lead.findFirst({
      where: { phone: rawPhone, orgId: org.id }
    });

    if (existingLead) {
      skipped++;
      continue;
    }

    // İsim soyisim ayrıştırma (Basitçe)
    const nameParts = rawName.split(' ');
    const firstName = nameParts[0] || 'Bilinmiyor';
    const lastName = nameParts.slice(1).join(' ') || '';

    try {
      await prisma.lead.create({
        data: {
          orgId: org.id,
          firstName,
          lastName,
          phone: rawPhone,
          sourceDetail: `WhatsApp Grubu: ${rawGroup}`,
          status: 'NEW'
        }
      });
      added++;
      if (added % 100 === 0) {
        console.log(`✅ ${added} kişi eklendi...`);
      }
    } catch (err) {
      console.error(`❌ Hata: ${rawPhone} eklenemedi.`);
    }
  }

  console.log(`\n🎉 İşlem tamamlandı!`);
  console.log(`- Yeni Eklenen: ${added}`);
  console.log(`- Zaten Var Olan / Atlanan: ${skipped}`);
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
