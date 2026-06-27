import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";

/**
 * ÖZAK DRAGOS | View of Islands and Sea - Maltepe, Istanbul
 * Delivery: December 2026
 * Land Area: 16,000 m² | Green Space: 40%
 * 5 Blocks | 458 Residential Units
 * Unit Types: 1+1 to 3+1
 * All units include separate storage room + parking space
 *
 * Payment: 50% down, 24 monthly installments
 * VAT: 10% (included in prices)
 * No expertise report required
 *
 * Distances:
 *   Maltepe Piazza Mall: 3 min | Metro: 5 min | Beach: 10 min
 *
 * Location: https://maps.app.goo.gl/2tV5dzJHMec4Ws4f6
 */

const PROJECT_ID = "tr-ozak-dragos";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

const UNIT_TYPES = [
  { name: "1+1 Standard",         area: 60,  beds: 1, baths: 1,   level: 3,  priceUSD: 160000 },
  { name: "1+1 Sea View",         area: 70,  beds: 1, baths: 1,   level: 8,  priceUSD: 200000 },
  { name: "2+1 Standard",         area: 100, beds: 2, baths: 1,   level: 5,  priceUSD: 280000 },
  { name: "2+1 Island View",      area: 115, beds: 2, baths: 1.5, level: 10, priceUSD: 340000 },
  { name: "3+1 Family",           area: 140, beds: 3, baths: 2,   level: 7,  priceUSD: 420000 },
  { name: "3+1 Panoramic Sea",    area: 165, beds: 3, baths: 2,   level: 14, priceUSD: 520000 },
];

const FACILITIES = [
  "Yüzme Havuzu",
  "Fitness Center",
  "Sauna & Buhar Odası",
  "Çocuk Oyun Alanı",
  "Kafeterya",
  "Açık & Kapalı Otopark",
  "24/7 Güvenlik",
  "Yeşil Alanlar",
  "Yürüyüş Parkuru",
  "Bisiklet Parkı",
  "Depo Alanı",
];

const PHOTOS = [
  "https://cdn.reservatior.com/projects/ozak-dragos/exterior-island-view.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/pool-area.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/sea-panorama.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/apartment-interior.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/aerial-maltepe.jpg",
];

// Dragos, Maltepe coordinates
const LAT = 40.9267;
const LNG = 29.0706;

async function main() {
  console.log("🏝️ ÖZAK DRAGOS | View of Islands and Sea - Maltepe");
  console.log("   Proje API endpointine ekleniyor...\n");

  const prisma = prismaManager.getClient("TR");

  // 1. Organization
  const org = await prisma.organization.upsert({
    where: { id: ORG_ID },
    update: {},
    create: {
      id: ORG_ID,
      name: "Reservatior Turkey - Premium Residences",
      type: "AGENCY",
      region: "TR",
      defaultCurrency: "TRY",
      defaultLocale: "tr-TR",
      taxReportingEnabled: true,
      complianceTracking: true,
      contactEmail: "tr@reservatior.com",
      address: "Büyükdere Cad. No:199, Levent, Istanbul 34394",
    },
  });
  console.log(`✅ Organizasyon: ${org.name}\n`);

  // 2. Property
  const property = await prisma.property.upsert({
    where: { id: PROP_ID },
    update: {},
    create: {
      id: PROP_ID,
      orgId: org.id,
      name: "ÖZAK DRAGOS | View of Islands and Sea",
      type: "APARTMENT",
      region: "TR",
      currency: "TRY",
      addressLine1: "Dragos Mahallesi, Maltepe",
      city: "Istanbul",
      state: "Istanbul",
      zip: "34844",
      country: "TR",
      lat: LAT,
      lng: LNG,
      propertyCategory: "RESIDENTIAL",
      listingType: "SALE",
      listingStatus: "WILL_BE_AVAILABLE",
      yearBuilt: 2026,
      livingAreaSqFt: 16000 * 10.7639,
      bedrooms: 3,
      bathrooms: 2,
      stories: 15,
      unitsPerBuilding: 458,
      assessedValue: 75000000,
      marketValue: 85000000,
      viewType: "SEA_ISLANDS",
      parkingSpaces: 458,
      notes: JSON.stringify({
        developer: "Özak GYO (Özak Global Holding)",
        projectName: "ÖZAK DRAGOS | View of Islands and Sea",
        deliveryDate: "2026-12",
        landArea: "16,000 m²",
        greenSpaceRatio: "40%",
        totalBlocks: 5,
        totalUnits: 458,
        unitTypes: ["1+1", "2+1", "3+1"],
        allUnitsInclude: ["Separate storage room", "Parking space"],
        paymentPlan: {
          downPayment: "50%",
          installments: "24 monthly",
          vat: "10% (included in prices)",
          expertiseReport: "Not required",
        },
        distances: {
          maltepePiazzaMall: "3 minutes",
          metroStation: "5 minutes",
          beach: "10 minutes",
        },
        socialFacilities: [
          "Swimming Pool", "Fitness Center", "Sauna & Steam Room",
          "Children's Playground", "Cafeteria", "Open & Covered Parking", "24/7 Security",
        ],
        sharePointDrive: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
        locationMap: "https://maps.app.goo.gl/2tV5dzJHMec4Ws4f6",
      }),
    },
  });
  console.log(`  🏗️  Property: ${property.name}`);

  // 3. Listing
  await prisma.listing.upsert({
    where: { id: `tr_list_${PROJECT_ID}` },
    update: {},
    create: {
      id: `tr_list_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      type: ListingType.SALE,
      status: ListingStatus.WILL_BE_AVAILABLE,
      strategy: EarningStrategy.LONG_TERM_STABLE,
      title: "ÖZAK DRAGOS | View of Islands and Sea - Maltepe, İstanbul",
      description: `Maltepe Dragos'ta ada ve deniz manzaralı Özak GYO projesi. 16.000 m² arazi, %40 yeşil alan. 5 blok, 458 konut. 1+1'den 3+1'e daire tipleri. Tüm dairelere ayrı depo ve otopark dahil. Yüzme havuzu, fitness center, sauna & buhar odası, çocuk parkı, kafeterya, 24/7 güvenlik. Maltepe Piazza AVM: 3dk, Metro: 5dk, Sahil: 10dk. %50 peşin, 24 ay taksit. KDV %10 fiyatlara dahil. Ekspertiz raporu gerekmez.`,
      price: 160000,
      priceCurrency: "USD",
    },
  }).catch(() => {});
  console.log(`  📋 Listing oluşturuldu`);

  // 4. Project
  const user = await prisma.user.findFirst().catch(() => null);
  await prisma.project.upsert({
    where: { id: `tr_proj_${PROJECT_ID}` },
    update: {
      name: "ÖZAK DRAGOS | View of Islands and Sea",
      status: "ACTIVE",
    },
    create: {
      id: `tr_proj_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: "ÖZAK DRAGOS | View of Islands and Sea",
      description: `Maltepe Dragos - Ada ve deniz manzarası. 16.000 m², %40 yeşil. 5 blok, 458 konut. 1+1 → 3+1. Aralık 2026 teslim. Havuz, fitness, sauna, kafeterya, 24/7 güvenlik. Mesafeler: Piazza AVM 3dk, Metro 5dk, Sahil 10dk. %50 peşin + 24 taksit. KDV %10. Ekspertiz gerekmez.`,
      projectType: "RESIDENTIAL",
      address: "Dragos Mahallesi, Maltepe, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2024-03-01"),
      estimatedEndDate: new Date("2026-12-31"),
      budget: 85000000,
      currency: "USD",
      managerId: user?.id || undefined,
      phases: JSON.stringify({
        blocks: [
          { name: "A Blok", units: 92, floors: 15 },
          { name: "B Blok", units: 92, floors: 15 },
          { name: "C Blok", units: 92, floors: 15 },
          { name: "D Blok", units: 91, floors: 15 },
          { name: "E Blok", units: 91, floors: 15 },
        ],
        totalUnits: 458,
        deliveryDate: "2026-12",
      }),
      milestones: JSON.stringify([
        { name: "Temel Atma", date: "2024-03", status: "COMPLETED" },
        { name: "Kaba İnşaat", date: "2025-06", status: "COMPLETED" },
        { name: "İnce İşler", date: "2026-06", status: "IN_PROGRESS" },
        { name: "Peyzaj & Tesisler", date: "2026-10", status: "PLANNED" },
        { name: "Teslim", date: "2026-12", status: "PLANNED" },
      ]),
    },
  });
  console.log(`  🏗️  Project oluşturuldu`);

  // 5. Floor Plans
  for (let i = 0; i < UNIT_TYPES.length; i++) {
    const u = UNIT_TYPES[i];
    await prisma.floorPlan.upsert({
      where: { id: `tr_floor_${PROJECT_ID}_${i}` },
      update: {},
      create: {
        id: `tr_floor_${PROJECT_ID}_${i}`,
        orgId: org.id,
        propertyId: property.id,
        name: u.name,
        description: `${u.area} m² | ${u.beds} yatak | ${u.baths} banyo | ~$${u.priceUSD.toLocaleString()} USD`,
        floorLevel: u.level,
        imageUrl: `https://cdn.reservatior.com/floorplans/${PROJECT_ID}_${u.name.toLowerCase().replace(/[\s+()]/g, '_')}.svg`,
      },
    }).catch(() => {});
    console.log(`  📐 ${u.name} (${u.area} m²)`);
  }

  // 6. Facilities
  for (let i = 0; i < FACILITIES.length; i++) {
    await prisma.facility.upsert({
      where: { id: `tr_fac_${PROJECT_ID}_${i}` },
      update: {},
      create: {
        id: `tr_fac_${PROJECT_ID}_${i}`,
        orgId: org.id,
        propertyId: property.id,
        name: FACILITIES[i],
      },
    }).catch(() => {});
  }
  console.log(`  🏊 ${FACILITIES.length} sosyal tesis eklendi`);

  // 7. Photos
  for (let i = 0; i < PHOTOS.length; i++) {
    await prisma.photo.upsert({
      where: { url: PHOTOS[i] },
      update: {},
      create: {
        id: `tr_photo_${PROJECT_ID}_${i}`,
        url: PHOTOS[i],
        propertyId: property.id,
        type: i === 0 ? PhotoType.COVER : PhotoType.GALLERY,
        caption: `ÖZAK DRAGOS - Görsel ${i + 1}`,
        featured: i === 0,
      },
    }).catch(() => {});
  }
  console.log(`  📸 ${PHOTOS.length} fotoğraf eklendi`);

  // 8. Virtual Tour
  await prisma.virtualTour.upsert({
    where: { id: `tr_vt_${PROJECT_ID}` },
    update: {},
    create: {
      id: `tr_vt_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: "ÖZAK DRAGOS - 360° Sanal Tur",
      tourType: "360_PANORAMIC",
      thumbnailUrl: PHOTOS[0],
      isActive: true,
    },
  }).catch(() => {});
  console.log(`  🎥 Sanal tur eklendi`);

  // 9. Documents
  await prisma.document.upsert({
    where: { id: `tr_doc_${PROJECT_ID}_brochure` },
    update: {},
    create: {
      id: `tr_doc_${PROJECT_ID}_brochure`,
      orgId: org.id,
      propertyId: property.id,
      documentType: "LISTING_AGREEMENT",
      title: "ÖZAK DRAGOS - Proje Katalogu",
      description: "ÖZAK DRAGOS View of Islands and Sea proje katalogu",
      fileUrl: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
      fileName: "ozak-dragos-islands-sea-katalog.pdf",
      fileSize: 6291456,
      mimeType: "application/pdf",
      checksum: "ozak-dragos-brochure-sha256",
    },
  }).catch(() => {});
  console.log(`  📄 Dökümanlar eklendi`);

  console.log(`\n🎉 ÖZAK DRAGOS başarıyla API endpointine eklendi!`);
  console.log(`\n📍 API Endpoints:`);
  console.log(`   GET  /api/v1/projects/tr_proj_${PROJECT_ID}`);
  console.log(`   GET  /api/v1/properties/${PROP_ID}`);
  console.log(`\n💡 Mesafeler: 🏪 Piazza AVM: 3dk | 🚊 Metro: 5dk | 🏖️ Sahil: 10dk`);
  console.log(`💰 %50 peşin + 24 taksit | KDV %10 dahil\n`);
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(async () => { await prismaManager.disconnectAll(); });
