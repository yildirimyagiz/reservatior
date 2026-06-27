import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";

/**
 * ÖZAK DUYU | Forest View - Göktürk, Istanbul
 * Delivery: August 2026
 * Land Area: 12,000 m² | Green Space: 65%
 * 5 Blocks | 141 Units
 * Apartment Types: 1+1 to 4.5+1
 * All units include separate storage room + parking space
 * 
 * Payment Plan: 50% down, rest in 12 monthly installments
 * Title Deed Fees: 0%
 * 
 * Location: Göktürk, Istanbul
 * Distances:
 *   - Belgrade Forest: 2 min
 *   - Metro Station: 5 min
 *   - Airport: 10 min
 *
 * SharePoint: https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g
 * Location: https://maps.app.goo.gl/XqFbYFuNyhcESJSQ7
 */

const PROJECT_ID = "tr-ozak-duyu-forest-view";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

// Based on the PDF: Göktürk Duyu - A63 2+1 unit layout
const UNIT_TYPES = [
  { name: "1+1 Compact",       area: 65,  beds: 1, baths: 1,   level: 1,  priceUSD: 180000 },
  { name: "1+1 Garden",        area: 75,  beds: 1, baths: 1,   level: 0,  priceUSD: 210000 },
  { name: "2+1 Standard",      area: 100, beds: 2, baths: 1,   level: 3,  priceUSD: 280000 },
  { name: "2+1 Corner (A63)",  area: 115, beds: 2, baths: 1,   level: 5,  priceUSD: 320000 },
  { name: "3+1 Family",        area: 145, beds: 3, baths: 2,   level: 7,  priceUSD: 420000 },
  { name: "3.5+1 Panoramic",   area: 165, beds: 3, baths: 2,   level: 10, priceUSD: 490000 },
  { name: "4+1 Premium",       area: 195, beds: 4, baths: 2.5, level: 12, priceUSD: 580000 },
  { name: "4.5+1 Penthouse",   area: 240, beds: 4, baths: 3,   level: 15, priceUSD: 720000 },
];

const FACILITIES = [
  "Açık Yüzme Havuzu",       // Open Swimming Pool
  "Fitness / Spor Salonu",    // Gym
  "Sauna",                    // Sauna
  "Kafe",                     // Café
  "Çocuk Oyun Alanı",        // Children's Playground
  "Basketbol Sahası",         // Basketball Court
  "Yürüyüş Parkuru",         // Walking Track
  "Peyzaj Bahçeleri",         // Landscaped Gardens
  "24/7 Güvenlik",            // 24/7 Security
  "Kapalı Otopark",           // Indoor Parking
  "Depo Alanı",               // Storage Room
  "Bisiklet Parkı",           // Bicycle Parking
];

const PHOTOS = [
  "https://cdn.reservatior.com/projects/ozak-duyu/exterior-forest-view.jpg",
  "https://cdn.reservatior.com/projects/ozak-duyu/pool-area.jpg",
  "https://cdn.reservatior.com/projects/ozak-duyu/lobby-entrance.jpg",
  "https://cdn.reservatior.com/projects/ozak-duyu/apartment-interior-2plus1.jpg",
  "https://cdn.reservatior.com/projects/ozak-duyu/belgrade-forest-panorama.jpg",
  "https://cdn.reservatior.com/projects/ozak-duyu/social-facilities.jpg",
];

// Göktürk coordinates
const LAT = 41.1831;
const LNG = 28.9292;

async function main() {
  console.log("🌲 ÖZAK DUYU | Forest View - Göktürk, Istanbul");
  console.log("   Proje API endpointine ekleniyor...\n");

  const prisma = prismaManager.getClient("TR");

  // 1. Ensure Organization exists
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
      name: "ÖZAK DUYU | Forest View",
      type: "APARTMENT",
      region: "TR",
      currency: "TRY",
      addressLine1: "Göktürk Mahallesi, Eyüpsultan",
      city: "Istanbul",
      state: "Istanbul",
      zip: "34077",
      country: "TR",
      lat: LAT,
      lng: LNG,
      propertyCategory: "RESIDENTIAL",
      listingType: "SALE",
      listingStatus: "WILL_BE_AVAILABLE",
      yearBuilt: 2026,
      livingAreaSqFt: 12000 * 10.7639, // 12,000 m² land area in sqft
      bedrooms: 4,                     // max available
      bathrooms: 3,                    // max available
      stories: 15,
      unitsPerBuilding: 141,
      assessedValue: 45000000,
      marketValue: 50000000,
      viewType: "FOREST",
      parkingSpaces: 141,
      notes: JSON.stringify({
        developer: "Özak GYO (Özak Global Holding)",
        projectName: "ÖZAK DUYU | Forest View",
        deliveryDate: "2026-08",
        landArea: "12,000 m²",
        greenSpaceRatio: "65%",
        totalBlocks: 5,
        totalUnits: 141,
        apartmentTypes: "1+1 to 4.5+1",
        allUnitsInclude: ["Separate storage room", "Parking space"],
        paymentPlan: {
          downPayment: "50%",
          installments: "12 monthly",
          titleDeedFees: "0%",
        },
        distances: {
          belgradeForest: "2 minutes",
          metroStation: "5 minutes",
          airport: "10 minutes",
        },
        socialFacilities: [
          "Open swimming pool", "Gym", "Sauna", "Café",
          "Children's playground", "Basketball court",
        ],
        sharePointDrive: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
        locationMap: "https://maps.app.goo.gl/XqFbYFuNyhcESJSQ7",
      }),
    },
  });
  console.log(`  🏗️  Property oluşturuldu: ${property.name}`);

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
      title: "ÖZAK DUYU | Forest View - Göktürk, Istanbul",
      description: `Göktürk'ün kalbinde, Belgrad Ormanı'na 2 dakika mesafede, %65 yeşil alana sahip 12.000 m² arazi üzerinde yükselen ÖZAK DUYU | Forest View projesi. 5 blok, 141 daire. 1+1'den 4.5+1'e kadar daire tipleri. Tüm dairelere ayrı depo ve otopark dahil. Açık yüzme havuzu, spor salonu, sauna, kafe, çocuk oyun alanı, basketbol sahası gibi zengin sosyal donatılara sahip. Ağustos 2026 teslim. %50 peşin, kalan 12 taksit. Tapu masrafları: %0.`,
      price: 280000,                // Starting price USD
      priceCurrency: "USD",
    },
  }).catch(() => {});
  console.log(`  📋 Listing oluşturuldu`);

  // 4. Project
  const user = await prisma.user.findFirst().catch(() => null);
  await prisma.project.upsert({
    where: { id: `tr_proj_${PROJECT_ID}` },
    update: {
      name: "ÖZAK DUYU | Forest View",
      description: `Göktürk, Istanbul - Belgrad Ormanı manzaralı, 12.000 m² arazi, %65 yeşil alan. 5 blok, 141 daire. 1+1 ile 4.5+1 arası daire tipleri. Ağustos 2026 teslim. Tüm dairelere ayrı depo ve otopark dahil. Sosyal Tesisler: Açık yüzme havuzu, spor salonu, sauna, kafe, çocuk oyun alanı, basketbol sahası. Mesafeler: Belgrad Ormanı 2 dk, Metro 5 dk, Havalimanı 10 dk. Ödeme planı: %50 peşin, kalan 12 taksit. Tapu masrafları %0.`,
      status: "ACTIVE",
      address: "Göktürk Mahallesi, Eyüpsultan, Istanbul",
      budget: 50000000,
      currency: "USD",
      phases: JSON.stringify({
        blocks: [
          { name: "A Blok", units: 28, floors: 15 },
          { name: "B Blok", units: 28, floors: 15 },
          { name: "C Blok", units: 29, floors: 15 },
          { name: "D Blok", units: 28, floors: 15 },
          { name: "E Blok", units: 28, floors: 15 },
        ],
        totalUnits: 141,
        deliveryDate: "2026-08",
      }),
      milestones: JSON.stringify([
        { name: "İnşaat Başlangıcı", date: "2024-06", status: "COMPLETED" },
        { name: "Kaba İnşaat Tamamlama", date: "2025-06", status: "COMPLETED" },
        { name: "İnce İşler", date: "2025-12", status: "IN_PROGRESS" },
        { name: "Peyzaj ve Sosyal Tesisler", date: "2026-04", status: "PLANNED" },
        { name: "Teslim", date: "2026-08", status: "PLANNED" },
      ]),
    },
    create: {
      id: `tr_proj_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: "ÖZAK DUYU | Forest View",
      description: `Göktürk, Istanbul - Belgrad Ormanı manzaralı, 12.000 m² arazi, %65 yeşil alan. 5 blok, 141 daire. 1+1 ile 4.5+1 arası daire tipleri. Ağustos 2026 teslim. Tüm dairelere ayrı depo ve otopark dahil. Sosyal Tesisler: Açık yüzme havuzu, spor salonu, sauna, kafe, çocuk oyun alanı, basketbol sahası. Mesafeler: Belgrad Ormanı 2 dk, Metro 5 dk, Havalimanı 10 dk. Ödeme planı: %50 peşin, kalan 12 taksit. Tapu masrafları %0.`,
      projectType: "RESIDENTIAL",
      address: "Göktürk Mahallesi, Eyüpsultan, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2024-06-01"),
      estimatedEndDate: new Date("2026-08-31"),
      budget: 50000000,
      currency: "USD",
      managerId: user?.id || undefined,
      phases: JSON.stringify({
        blocks: [
          { name: "A Blok", units: 28, floors: 15 },
          { name: "B Blok", units: 28, floors: 15 },
          { name: "C Blok", units: 29, floors: 15 },
          { name: "D Blok", units: 28, floors: 15 },
          { name: "E Blok", units: 28, floors: 15 },
        ],
        totalUnits: 141,
        deliveryDate: "2026-08",
      }),
      milestones: JSON.stringify([
        { name: "İnşaat Başlangıcı", date: "2024-06", status: "COMPLETED" },
        { name: "Kaba İnşaat Tamamlama", date: "2025-06", status: "COMPLETED" },
        { name: "İnce İşler", date: "2025-12", status: "IN_PROGRESS" },
        { name: "Peyzaj ve Sosyal Tesisler", date: "2026-04", status: "PLANNED" },
        { name: "Teslim", date: "2026-08", status: "PLANNED" },
      ]),
    },
  });
  console.log(`  🏗️  Project oluşturuldu`);

  // 5. Floor Plans (unit types)
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
        description: `${u.area} m² | ${u.beds} yatak odası | ${u.baths} banyo | ~$${u.priceUSD.toLocaleString()} USD`,
        floorLevel: u.level,
        imageUrl: `https://cdn.reservatior.com/floorplans/${PROJECT_ID}_${u.name.toLowerCase().replace(/[\s+()]/g, '_')}.svg`,
      },
    }).catch(() => {});
    console.log(`  📐 Kat Planı: ${u.name} (${u.area} m²)`);
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
        caption: `ÖZAK DUYU | Forest View - Görsel ${i + 1}`,
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
      name: "ÖZAK DUYU | Forest View - 360° Sanal Tur",
      tourType: "360_PANORAMIC",
      thumbnailUrl: PHOTOS[0],
      isActive: true,
    },
  }).catch(() => {});
  console.log(`  🎥 Sanal tur eklendi`);

  // 9. Documents (link to SharePoint drive)
  await prisma.document.upsert({
    where: { id: `tr_doc_${PROJECT_ID}_brochure` },
    update: {},
    create: {
      id: `tr_doc_${PROJECT_ID}_brochure`,
      orgId: org.id,
      propertyId: property.id,
      documentType: "LISTING_AGREEMENT",
      title: "Göktürk Duyu - Proje Katalogu",
      description: "ÖZAK DUYU Forest View proje katalogu ve kat planları",
      fileUrl: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
      fileName: "ozak-duyu-forest-view-katalog.pdf",
      fileSize: 5242880,
      mimeType: "application/pdf",
      checksum: "ozak-duyu-brochure-sha256",
    },
  }).catch(() => {});

  await prisma.document.upsert({
    where: { id: `tr_doc_${PROJECT_ID}_floorplan_a63` },
    update: {},
    create: {
      id: `tr_doc_${PROJECT_ID}_floorplan_a63`,
      orgId: org.id,
      propertyId: property.id,
      documentType: "INSPECTION_REPORT",
      title: "Göktürk Duyu - A63 2+1 Kat Planı",
      description: "A63 Blok 2+1 daire kat planı detayları",
      fileUrl: `https://cdn.reservatior.com/documents/${PROJECT_ID}/a63-2plus1.pdf`,
      fileName: "gokturk-duyu-a63-2plus1.pdf",
      fileSize: 2097152,
      mimeType: "application/pdf",
      checksum: "ozak-duyu-a63-floorplan-sha256",
    },
  }).catch(() => {});
  console.log(`  📄 Dökümanlar eklendi`);

  console.log(`\n🎉 ÖZAK DUYU | Forest View projesi başarıyla API endpointine eklendi!`);
  console.log(`\n📍 API Endpoints:`);
  console.log(`   GET  /api/v1/projects                        → Tüm projeler (DUYU dahil)`);
  console.log(`   GET  /api/v1/projects/tr_proj_${PROJECT_ID}  → Proje detayı`);
  console.log(`   GET  /api/v1/properties/${PROP_ID}           → Property detayı`);
  console.log(`   GET  /api/v1/listings?propertyId=${PROP_ID}  → İlan bilgisi`);
  console.log(`   GET  /api/v1/floor-plans?propertyId=${PROP_ID} → Kat planları`);
  console.log(`   GET  /api/v1/facilities?propertyId=${PROP_ID}  → Sosyal tesisler`);
  console.log(`   GET  /api/v1/documents?propertyId=${PROP_ID}   → Dökümanlar`);
  console.log(`\n💡 Mesafeler: 🌳 Belgrad Ormanı: 2dk | 🚊 Metro: 5dk | ✈️ Havalimanı: 10dk`);
  console.log(`💰 Ödeme: %50 peşin + 12 taksit | Tapu: %0\n`);
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(async () => { await prismaManager.disconnectAll(); });
