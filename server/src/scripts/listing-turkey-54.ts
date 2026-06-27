import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const realProjects = [
  'Avrupa Residence Şişli-2', 'Maslak Koru', 'Avrupa Konutları Güneşli', 'Sinpaş Boulevard Sefaköy', 'RAMS Park House Maslak',
  'Avrupa Residence Oryapark', 'Özak Dragos', 'Ataşehir 173', 'Fortis Sinanlı', 'Avrupa Konutları Esentepe',
  'Benesta Acıbadem Homes', 'Batıyaka', 'Tor Finance City', 'Sinpaş Finans Şehir', 'Kuzey Adalar',
  'Senfoni Etiler', 'Topkapı 29', 'Taşyapı Şişli', 'Nef Reserve Bebek', 'Zorlu Center Residences',
  'Emaar Square', 'Varyap Meridian', 'Skyland Istanbul', 'Metropol Istanbul', 'Sapphire Residence',
  'Trump Towers Residences', 'Anthill Residence', 'Bomonti Time', 'Queen Central Park', 'Quasar Istanbul',
  'Torun Center', 'Piyalepaşa Istanbul', 'Taksim 360', 'SeaPearl Ataköy', 'Büyükyalı',
  'Yedi Mavi', 'Pruva 34', 'Marina Ankara', 'Tema Istanbul', 'Bizim Evler 8',
  'Referans Bakırköy', 'Nivo Ataköy', 'Selenium Ataköy', 'Ritz Carlton Residences', 'Mandarin Oriental Bosphorus',
  'Kempinski Residences', 'Four Seasons Residences', 'Swissotel Residences', 'Fairmont Quasar', 'Raffles Residences',
  'Çiftçi Towers', 'Ağaoğlu Maslak 1453', 'Eclipse Maslak', 'Vadi Istanbul'
];

async function run() {
  console.log('🌟 54 MEGA-PROJECT DIGITAL TWIN INGESTION ENGINE 🌟');

  const org = await prisma.organization.upsert({
    where: { id: 'listing_turkey_org' },
    update: {},
    create: {
      id: 'listing_turkey_org',
      name: 'Listing Turkey - Exclusive Portfolio',
      type: 'AGENCY',
      region: 'TR',
      defaultCurrency: 'USD',
      defaultLocale: 'en-US',
    }
  });

  let totalImported = 0;

  // Guarantee exactly 54 projects
  const finalProjects = realProjects.slice(0, 54);

  for (let i = 0; i < finalProjects.length; i++) {
    const projectName = finalProjects[i];
    
    // Generate realistic units for each project
    const unitTypes = ['1+1', '2+1', '3+1', '4+1'];
    
    for (const type of unitTypes) {
      let areaSqm = 0;
      let priceUsd = 0;
      
      if (type === '1+1') { areaSqm = 70 + Math.random() * 20; priceUsd = 250000 + Math.random() * 150000; }
      else if (type === '2+1') { areaSqm = 100 + Math.random() * 30; priceUsd = 400000 + Math.random() * 250000; }
      else if (type === '3+1') { areaSqm = 140 + Math.random() * 40; priceUsd = 650000 + Math.random() * 350000; }
      else if (type === '4+1') { areaSqm = 190 + Math.random() * 60; priceUsd = 1000000 + Math.random() * 800000; }

      const propId = `lt_54_${i}_${type.replace('+', '')}_${Date.now()}_${Math.floor(Math.random()*1000)}`;
      
      await prisma.property.create({
        data: {
          id: propId,
          orgId: org.id,
          name: `${projectName} - ${type} Luxury Unit`,
          type: 'APARTMENT',
          region: 'TR',
          currency: 'USD',
          addressLine1: `${projectName}, Istanbul`,
          city: 'Istanbul',
          country: 'TR',
          propertyCategory: 'RESIDENTIAL',
          listingType: 'SALE',
          listingStatus: 'AVAILABLE',
          areaSqm: Math.floor(areaSqm),
        }
      });
      totalImported++;
    }
  }

  console.log(`\n🏆 BAŞARILI! TOPLAM 54 PROJE VE ${totalImported} DİJİTAL İKİZ BİRİMİ SİSTEME EKLENDİ.`);
}

run()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
