import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const projects = [
  {
    name: 'Avrupa Residence Şişli-2',
    city: 'Istanbul',
    region: 'TR',
    addressLine1: 'Şişli, Istanbul',
    units: [
      { type: '1+1', areaSqm: 72, priceUsd: 370000 },
      { type: '2+1', areaSqm: 128, priceUsd: 680000 },
      { type: '3+1', areaSqm: 145, priceUsd: 810000 },
      { type: '4+1', areaSqm: 210, priceUsd: 1150000 },
      { type: '5+1', areaSqm: 266, priceUsd: 1450000 },
    ]
  },
  {
    name: 'Maslak Koru',
    city: 'Istanbul',
    region: 'TR',
    addressLine1: 'Sarıyer / Maslak, Istanbul',
    units: [
      { type: '1+1', areaSqm: 64, priceUsd: 315000 },
      { type: '2+1', areaSqm: 105, priceUsd: 525000 },
      { type: '3+1', areaSqm: 150, priceUsd: 750000 },
    ]
  },
  {
    name: 'Avrupa Konutları Güneşli',
    city: 'Istanbul',
    region: 'TR',
    addressLine1: 'Bağcılar / Güneşli, Istanbul',
    units: [
      { type: '1+1', areaSqm: 73, priceUsd: 290000 },
      { type: '2+1', areaSqm: 115, priceUsd: 460000 },
      { type: '3+1', areaSqm: 145, priceUsd: 580000 },
    ]
  },
  {
    name: 'Sinpaş Boulevard Sefaköy',
    city: 'Istanbul',
    region: 'TR',
    addressLine1: 'Küçükçekmece / Sefaköy, Istanbul',
    units: [
      { type: '1+1', areaSqm: 72, priceUsd: 275000 },
      { type: '2+1', areaSqm: 105, priceUsd: 420000 },
      { type: '3+1', areaSqm: 140, priceUsd: 560000 },
      { type: '4+1', areaSqm: 185, priceUsd: 740000 },
    ]
  },
  {
    name: 'RAMS Park House Maslak',
    city: 'Istanbul',
    region: 'TR',
    addressLine1: 'Sarıyer / Maslak, Istanbul',
    units: [
      { type: '1+1', areaSqm: 74, priceUsd: 345000 },
      { type: '2+1', areaSqm: 93, priceUsd: 610000 },
      { type: '3+1', areaSqm: 118, priceUsd: 1133500 },
      { type: '4+1', areaSqm: 221, priceUsd: 1530000 },
    ]
  }
];

async function run() {
  console.log('🌟 LISTING TURKEY MEGA-PROJECTS INGESTION INITIATED 🌟');

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

  for (const project of projects) {
    console.log(`🏢 ENTEGRE EDİLİYOR: ${project.name}`);
    for (const unit of project.units) {
      const propId = `lt_${project.name.toLowerCase().replace(/[^a-z0-9]/g, '')}_${unit.type.replace('+', '')}_${Date.now()}`;
      
      await prisma.property.create({
        data: {
          id: propId,
          orgId: org.id,
          name: `${project.name} - ${unit.type} Luxury Unit`,
          type: 'APARTMENT',
          region: project.region,
          currency: 'USD',
          addressLine1: project.addressLine1,
          city: project.city,
          country: 'TR',
          propertyCategory: 'RESIDENTIAL',
          listingType: 'SALE',
          listingStatus: 'AVAILABLE',
          areaSqm: unit.areaSqm,
        }
      });
      totalImported++;
    }
    console.log(`✅ ${project.name} projesi birimleri eklendi.`);
  }

  console.log(`\n🏆 BAŞARILI! TOPLAM ${totalImported} ADET LÜKS LİSTELEME DİJİTAL İKİZ SİSTEMİNE AKTARILDI.`);
}

run()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
