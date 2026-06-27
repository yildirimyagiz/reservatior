import { prismaManager } from '../lib/prisma';
import * as dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.join(__dirname, '../../../.env') });

async function main() {
  // Türkiye (TR) veritabanı bağlantısını alıyoruz
  const prisma = prismaManager.getClient('TR');
  
  // Master kayıt dışındaki dairelerden ilk 10 tanesini getiriyoruz
  const properties = await prisma.property.findMany({
    where: {
      id: { startsWith: 'prop_ROTANABOMONTI_' },
      NOT: { id: 'prop_ROTANABOMONTI_MASTER' }
    },
    take: 10,
    orderBy: {
      createdAt: 'asc' // İlk eklenenlerden 10 tanesini görelim
    }
  });

  console.log(`\n==================================================`);
  console.log(`VERİTABANINDAN ÇEKİLEN ÖRNEK KAYITLAR (İlk ${properties.length} kayıt)`);
  console.log(`==================================================\n`);
  
  properties.forEach((p: any) => {
    console.log(`🏡 Daire (Kapı) No: ${p.daireNo}`);
    console.log(`👤 ${p.notes || 'Detay bulunamadı'}`);
    console.log(`🏷️ Kullanış Şekli: ${p.type}`);
    console.log(`--------------------------------------------------`);
  });

  const totalProperties = await prisma.property.count({
    where: {
      id: { startsWith: 'prop_ROTANABOMONTI_' },
      NOT: { id: 'prop_ROTANABOMONTI_MASTER' }
    }
  });

  console.log(`\n📊 Toplam işlenen ve veritabanında bulunan daire sayısı: ${totalProperties}\n`);
}

main()
  .catch((e) => {
    console.error("Hata oluştu:", e);
  })
  .finally(async () => {
    process.exit(0);
  });
