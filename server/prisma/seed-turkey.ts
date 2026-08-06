import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

function id(slug: string) {
  return `tr_residence_${slug}`;
}

const TURKEY_RESIDENCES = [
  {
    parcel: "34-IST-001", address: "Levazım, Koru Sokağı No:2, Beşiktaş", city: "Istanbul", zip: "34340", lat: 41.0664, lng: 29.0163,
    name: "Zorlu Center - Luxury Residence", use: "MIXED_USE", yearBuilt: 2013, sqft: 2500, lot: 0,
    beds: 3, baths: 3.5, stories: 1, condition: "EXCELLENT", landVal: 15000000, imprVal: 35000000, totalVal: 50000000,
    district: "Besiktas",
  },
  {
    parcel: "34-IST-002", address: "Huzur Mah. Azerbaycan Cad. Sarıyer", city: "Istanbul", zip: "34396", lat: 41.1070, lng: 28.9897,
    name: "Skyland Istanbul - Sky Residence", use: "MIXED_USE", yearBuilt: 2018, sqft: 1800, lot: 0,
    beds: 2, baths: 2, stories: 1, condition: "EXCELLENT", landVal: 8000000, imprVal: 22000000, totalVal: 30000000,
    district: "Sariyer",
  },
  {
    parcel: "34-IST-003", address: "Cumhuriyet Mah. İncirlidede Cad. Şişli", city: "Istanbul", zip: "34380", lat: 41.0569, lng: 28.9796,
    name: "Anthill Residence - Premium Unit", use: "MIXED_USE", yearBuilt: 2010, sqft: 1200, lot: 0,
    beds: 1, baths: 1.5, stories: 1, condition: "GOOD", landVal: 5000000, imprVal: 12000000, totalVal: 17000000,
    district: "Sisli",
  },
  {
    parcel: "34-IST-004", address: "Kuruçeşme, Muallim Naci Cad. Beşiktaş", city: "Istanbul", zip: "34345", lat: 41.0375, lng: 29.0322,
    name: "Bosphorus View Yalı Dairesi", use: "APARTMENT", yearBuilt: 1995, sqft: 4500, lot: 5500,
    beds: 5, baths: 4, stories: 2, condition: "EXCELLENT", landVal: 80000000, imprVal: 45000000, totalVal: 125000000,
    district: "Besiktas",
  },
  {
    parcel: "35-IZM-001", address: "Adalet Mah. Manas Bulvarı No:47 Bayraklı", city: "Izmir", zip: "35530", lat: 38.4524, lng: 27.1751,
    name: "Folkart Towers - Sea View", use: "MIXED_USE", yearBuilt: 2014, sqft: 2200, lot: 0,
    beds: 3, baths: 2.5, stories: 1, condition: "EXCELLENT", landVal: 4000000, imprVal: 11000000, totalVal: 15000000,
    district: "Bayrakli",
  },
  {
    parcel: "35-IZM-002", address: "Mavişehir Mah. Caher Dudayev Blv.", city: "Izmir", zip: "35590", lat: 38.4682, lng: 27.0851,
    name: "Mavişehir Park Yaşam Residence", use: "APARTMENT", yearBuilt: 2015, sqft: 1650, lot: 0,
    beds: 3, baths: 2, stories: 1, condition: "GOOD", landVal: 3500000, imprVal: 7500000, totalVal: 11000000,
    district: "Karsiyaka",
  },
  {
    parcel: "48-BOD-001", address: "Yalıkavak, Çökertme Cd. No:1 Bodrum", city: "Mugla", zip: "48990", lat: 37.1042, lng: 27.2872,
    name: "Yalıkavak Marina - Private Villa", use: "SINGLE_FAMILY_RESIDENCE", yearBuilt: 2019, sqft: 6500, lot: 15000,
    beds: 6, baths: 6.5, stories: 2, condition: "EXCELLENT", landVal: 60000000, imprVal: 90000000, totalVal: 150000000,
    district: "Bodrum",
  },
  {
    parcel: "06-ANK-001", address: "Turan Güneş Blv. İlkbahar Mah. Çankaya", city: "Ankara", zip: "06550", lat: 39.8519, lng: 32.8550,
    name: "Sinpaş Altınoran - Premium Tower", use: "APARTMENT", yearBuilt: 2016, sqft: 1950, lot: 0,
    beds: 4, baths: 2, stories: 1, condition: "GOOD", landVal: 2000000, imprVal: 6500000, totalVal: 8500000,
    district: "Cankaya",
  },
  {
    parcel: "34-IST-005", address: "Ataköy 1. Kısım Mah. Rauf Orbay Cad.", city: "Istanbul", zip: "34158", lat: 40.9755, lng: 28.8576,
    name: "SeaPearl Ataköy Residence", use: "MIXED_USE", yearBuilt: 2021, sqft: 3100, lot: 0,
    beds: 4, baths: 3, stories: 1, condition: "EXCELLENT", landVal: 12000000, imprVal: 38000000, totalVal: 50000000,
    district: "Bakirkoy",
  },
  {
    parcel: "07-ANT-001", address: "Şirinyalı Mah. Lara Cad. Muratpaşa", city: "Antalya", zip: "07160", lat: 36.8617, lng: 30.7451,
    name: "Lara Yalı Residence - Sea Front", use: "APARTMENT", yearBuilt: 2012, sqft: 2800, lot: 0,
    beds: 4, baths: 3, stories: 1, condition: "GOOD", landVal: 6000000, imprVal: 14000000, totalVal: 20000000,
    district: "Muratpasa",
  }
];

async function main() {
  console.log("🏙️ Türkiye lüks rezidans projeleri ekleniyor...\n");

  const org = await prisma.organization.upsert({
    where: { id: id("org") },
    update: {},
    create: {
      id: id("org"),
      name: "Reservatior Turkey - Premium Residences",
      type: "AGENCY",
      region: "TR",
      defaultCurrency: "TRY",
      defaultLocale: "tr-TR",
      taxReportingEnabled: true,
      complianceTracking: true,
      contactEmail: "info@reservatior.com",
      address: "Büyükdere Cad. No:199, Levent, Istanbul 34394",
    },
  });

  console.log(`✅ Organizasyon oluşturuldu: ${org.name} (${org.id})\n`);

  for (const p of TURKEY_RESIDENCES) {
    const propId = id(`prop_${p.parcel}`);

    const property = await prisma.property.upsert({
      where: { id: propId },
      update: {},
      create: {
        id: propId,
        orgId: org.id,
        name: p.name,
        type: p.use === "SINGLE_FAMILY_RESIDENCE" ? "DETACHED_HOUSE" : "APARTMENT",
        region: "TR",
        currency: "TRY",
        addressLine1: p.address,
        city: p.city,
        state: p.city, // For TR, state is often the province/city
        zip: p.zip,
        country: "TR",
        lat: p.lat,
        lng: p.lng,
        propertyCategory: p.use.includes("MIXED") ? "MIXED_USE" : "RESIDENTIAL",
        listingType: "SALE",
        listingStatus: "AVAILABLE",
        yearBuilt: p.yearBuilt,
        livingAreaSqFt: p.sqft * 10.7639, // approx sqm to sqft or just use directly if schema expects sqft
        lotSizeSqFt: p.lot,
        bedrooms: p.beds,
        bathrooms: p.baths,
        stories: Math.floor(p.stories),
        assessedValue: p.totalVal,
        marketValue: p.totalVal * 1.10,
        schoolDistrict: p.district,
      },
    });
    
    // Listing create for TR residences
    await (prisma.listing as any).upsert({
      where: { id: id(`listing_${p.parcel}`) },
      update: {},
      create: {
        id: id(`listing_${p.parcel}`),
        orgId: org.id,
        propertyId: property.id,
        type: "SALE",
        status: "AVAILABLE",
        strategy: "LONG_TERM_STABLE",
        title: p.name,
        description: `${p.name} - ${p.city} ${p.district} konumunda harika lüks rezidans.`,
        price: p.totalVal * 1.10,
        priceCurrency: "TRY",
      }
    }).catch((e: any) => console.log(`Listing skip: ${e.message}`));

    console.log(`  📋 ${p.parcel} | ${p.address.padEnd(45)} | ₺${p.totalVal.toLocaleString().padStart(15)}`);
  }

  console.log(`\n✅ ${TURKEY_RESIDENCES.length} Türkiye rezidans projesi veritabanına eklendi.`);
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(() => prisma.$disconnect());
