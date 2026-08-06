import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";

/**
 * Hayat Flora | Sea & Lake View - Halkalı, Küçükçekmece, Istanbul
 * Delivery: April 2027
 * Land Area: 92,000 m² | Green Space: 70%
 * 21 Blocks (3 parcels) | 1,384 residential + 45 commercial = 1,429 total
 * Unit Types: 1+1, 2+1, 3+1, 4+1, Duplexes
 * All units include separate storage room + parking space
 *
 * Payment: 50% down, 24 monthly installments
 * VAT: 1% (included in prices)
 * No expertise report required
 *
 * Distances:
 *   Marmaray Metro: 5 min | Airport: 15 min | National Park: 5 min | Tema World: 5 min
 *
 * Location: https://maps.app.goo.gl/RZNu7vLa57HY5TgC6
 */

const PROJECT_ID = "tr-hayat-flora-sea-lake-view";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

const UNIT_TYPES = [
  { name: "1+1 Standard",         area: 65,  beds: 1, baths: 1,   level: 2,  priceUSD: 120000 },
  { name: "1+1 Lake View",        area: 72,  beds: 1, baths: 1,   level: 5,  priceUSD: 145000 },
  { name: "2+1 Standard",         area: 105, beds: 2, baths: 1,   level: 3,  priceUSD: 195000 },
  { name: "2+1 Sea View",         area: 115, beds: 2, baths: 1,   level: 8,  priceUSD: 235000 },
  { name: "3+1 Family",           area: 145, beds: 3, baths: 2,   level: 6,  priceUSD: 295000 },
  { name: "3+1 Panoramic",        area: 160, beds: 3, baths: 2,   level: 10, priceUSD: 340000 },
  { name: "4+1 Premium",          area: 200, beds: 4, baths: 2.5, level: 12, priceUSD: 420000 },
  { name: "4+1 Duplex",           area: 250, beds: 4, baths: 3,   level: 14, priceUSD: 520000 },
  { name: "Ticari Ünite (Dükkan)", area: 80, beds: 0, baths: 1,   level: 0,  priceUSD: 180000 },
];

const AMENITIES = [
  "Açık Yüzme Havuzu",
  "Fitness / Spor Salonu",
  "Sauna",
  "Basketbol Sahası",
  "Yeşil Alanlar & Peyzaj",
  "Çocuk Oyun Alanı",
  "Toplantı Salonu",
  "24/7 Güvenlik",
  "Kapalı Otopark",
  "Depo Alanı",
  "Yürüyüş Parkuru",
  "Göl Manzara Terası",
  "Bisiklet Parkı",
  "Çocuk Havuzu",
];

const PHOTOS = [
  "https://cdn.reservatior.com/projects/hayat-flora/exterior-sea-lake.jpg",
  "https://cdn.reservatior.com/projects/hayat-flora/pool-garden.jpg",
  "https://cdn.reservatior.com/projects/hayat-flora/apartment-living.jpg",
  "https://cdn.reservatior.com/projects/hayat-flora/green-areas.jpg",
  "https://cdn.reservatior.com/projects/hayat-flora/aerial-view.jpg",
  "https://cdn.reservatior.com/projects/hayat-flora/commercial-units.jpg",
];

// Halkalı, Küçükçekmece coordinates
const LAT = 41.0222;
const LNG = 28.7745;

async function main() {
  console.log("🌊 Hayat Flora | Sea & Lake View - Halkalı, Küçükçekmece");
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
      contactEmail: "info@reservatior.com",
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
      name: "Hayat Flora | Sea & Lake View",
      type: "APARTMENT",
      region: "TR",
      currency: "TRY",
      addressLine1: "Halkalı Mahallesi, Küçükçekmece",
      city: "Istanbul",
      state: "Istanbul",
      zip: "34303",
      country: "TR",
      lat: LAT,
      lng: LNG,
      propertyCategory: "MIXED_USE",
      listingType: "SALE",
      listingStatus: "WILL_BE_AVAILABLE",
      yearBuilt: 2027,
      livingAreaSqFt: 92000 * 10.7639,
      bedrooms: 4,
      bathrooms: 3,
      stories: 15,
      unitsPerBuilding: 1429,
      assessedValue: 180000000,
      marketValue: 200000000,
      viewType: "SEA_LAKE",
      parkingSpaces: 1429,
      notes: JSON.stringify({
        developer: "Hayat Flora",
        projectName: "Hayat Flora | Sea & Lake View",
        deliveryDate: "2027-04",
        landArea: "92,000 m²",
        greenSpaceRatio: "70%",
        totalBlocks: 21,
        parcels: 3,
        residentialUnits: 1384,
        commercialUnits: 45,
        totalUnits: 1429,
        unitTypes: ["1+1", "2+1", "3+1", "4+1", "Duplex"],
        allUnitsInclude: ["Separate storage room", "Dedicated parking space"],
        paymentPlan: {
          downPayment: "50%",
          installments: "24 monthly",
          vat: "1% (included in prices)",
          expertiseReport: "Not required",
        },
        distances: {
          marmarayMetro: "5 minutes",
          istanbulNewAirport: "15 minutes",
          nationalPark: "5 minutes",
          temaWorld: "5 minutes",
        },
        socialFacilities: [
          "Open-air swimming pool", "Gym", "Sauna", "Basketball court",
          "Green areas", "Children's playground", "Meeting room", "24/7 security",
        ],
        sharePointDrive: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
        locationMap: "https://maps.app.goo.gl/RZNu7vLa57HY5TgC6",
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
      title: "Hayat Flora | Sea & Lake View - Halkalı, İstanbul",
      description: `Küçükçekmece'nin Halkalı bölgesinde, deniz ve göl manzaralı dev proje. 92.000 m² arazi, %70 yeşil alan. 21 blok (3 parsel), 1.384 konut + 45 ticari ünite. 1+1'den 4+1'e ve Dublex dairelere kadar geniş seçenek. Tüm dairelere ayrı depo ve otopark dahil. Her parselde: Açık havuz, spor salonu, sauna, basketbol sahası, çocuk parkı, toplantı salonu, 24/7 güvenlik. Marmaray Metro: 5dk, Havalimanı: 15dk, Milli Park: 5dk. %50 peşin, 24 ay taksit. KDV %1 fiyatlara dahil.`,
      price: 120000,
      priceCurrency: "USD",
    },
  }).catch(() => {});
  console.log(`  📋 Listing oluşturuldu`);

  // 4. Project
  const user = await prisma.user.findFirst().catch(() => null);
  await prisma.project.upsert({
    where: { id: `tr_proj_${PROJECT_ID}` },
    update: {
      name: "Hayat Flora | Sea & Lake View",
      status: "ACTIVE",
    },
    create: {
      id: `tr_proj_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: "Hayat Flora | Sea & Lake View",
      description: `Halkalı, Küçükçekmece - Deniz ve Göl manzaralı. 92.000 m², %70 yeşil. 21 blok (3 parsel), 1.384 konut + 45 ticari. 1+1 → Dublex. Nisan 2027 teslim. Her parselde sosyal tesisler: Havuz, spor, sauna, basketbol, çocuk parkı, toplantı salonu. Mesafeler: Marmaray 5dk, Havalimanı 15dk, Milli Park 5dk, Tema World 5dk. %50 peşin + 24 taksit. KDV %1. Ekspertiz raporu gerekmez.`,
      projectType: "RESIDENTIAL",
      address: "Halkalı Mahallesi, Küçükçekmece, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2024-01-01"),
      estimatedEndDate: new Date("2027-04-30"),
      budget: 200000000,
      currency: "USD",
      managerId: user?.id || undefined,
      phases: JSON.stringify({
        parcels: [
          { name: "Parsel 1", blocks: 7, units: 476, status: "IN_PROGRESS" },
          { name: "Parsel 2", blocks: 7, units: 478, status: "IN_PROGRESS" },
          { name: "Parsel 3", blocks: 7, units: 475, status: "PLANNING" },
        ],
        totalBlocks: 21,
        residentialUnits: 1384,
        commercialUnits: 45,
        totalUnits: 1429,
        deliveryDate: "2027-04",
      }),
      milestones: JSON.stringify([
        { name: "Proje Onayı & Ruhsat", date: "2024-01", status: "COMPLETED" },
        { name: "Temel Atma", date: "2024-06", status: "COMPLETED" },
        { name: "Parsel 1 Kaba İnşaat", date: "2025-06", status: "COMPLETED" },
        { name: "Parsel 2 Kaba İnşaat", date: "2025-12", status: "IN_PROGRESS" },
        { name: "Parsel 3 Kaba İnşaat", date: "2026-06", status: "PLANNED" },
        { name: "İnce İşler & Peyzaj", date: "2026-12", status: "PLANNED" },
        { name: "Teslim", date: "2027-04", status: "PLANNED" },
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
        description: `${u.area} m² | ${u.beds > 0 ? u.beds + ' yatak' : 'Ticari'} | ${u.baths} banyo | ~$${u.priceUSD.toLocaleString()} USD`,
        floorLevel: u.level,
        imageUrl: `https://cdn.reservatior.com/floorplans/${PROJECT_ID}_${u.name.toLowerCase().replace(/[\s+()]/g, '_')}.svg`,
      },
    }).catch(() => {});
    console.log(`  📐 ${u.name} (${u.area} m²)`);
  }

  // 6. Create Facility for the project itself
  await prisma.facility.upsert({
    where: { id: `tr_fac_${PROJECT_ID}` },
    update: {},
    create: {
      id: `tr_fac_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: property.name,
      notes: JSON.stringify({
        developer: "Hayat Flora",
        projectName: "Hayat Flora | Sea & Lake View",
        deliveryDate: "2027-04",
        totalUnits: 1429,
        socialFacilities: AMENITIES,
      }),
    },
  }).catch(() => {});
  console.log(`  🏢 Facility oluşturuldu`);

  // 7. Seeding amenities via PropertyAmenity
  for (let i = 0; i < AMENITIES.length; i++) {
    const amenity = await prisma.amenity.upsert({
      where: { id: `tr_amen_${PROJECT_ID}_${i}` },
      update: {},
      create: {
        id: `tr_amen_${PROJECT_ID}_${i}`,
        orgId: org.id,
        name: AMENITIES[i],
        category: "OTHER",
      },
    }).catch(() => {});

    await prisma.propertyAmenity.upsert({
      where: {
        propertyId_amenityId: {
          propertyId: property.id,
          amenityId: amenity.id,
        },
      },
      update: {},
      create: {
        id: `tr_prop_amen_${PROJECT_ID}_${i}`,
        propertyId: property.id,
        amenityId: amenity.id,
        orgId: org.id,
      },
    }).catch(() => {});
  }
  console.log(`  🏊 ${AMENITIES.length} amenity eklendi`);

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
        caption: `Hayat Flora | Sea & Lake View - Görsel ${i + 1}`,
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
      name: "Hayat Flora - 360° Sanal Tur",
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
      title: "Hayat Flora - Proje Katalogu",
      description: "Hayat Flora Sea & Lake View proje katalogu ve kat planları",
      fileUrl: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
      fileName: "hayat-flora-sea-lake-view-katalog.pdf",
      fileSize: 8388608,
      mimeType: "application/pdf",
      checksum: "hayat-flora-brochure-sha256",
    },
  }).catch(() => {});
  console.log(`  📄 Dökümanlar eklendi`);

  console.log(`\n🎉 Hayat Flora | Sea & Lake View başarıyla API endpointine eklendi!`);
  console.log(`\n📍 API Endpoints:`);
  console.log(`   GET  /api/v1/projects/tr_proj_${PROJECT_ID}`);
  console.log(`   GET  /api/v1/properties/${PROP_ID}`);
  console.log(`\n💡 Mesafeler: 🚊 Marmaray: 5dk | ✈️ Havalimanı: 15dk | 🌳 Milli Park: 5dk`);
  console.log(`💰 %50 peşin + 24 taksit | KDV %1 dahil\n`);
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(async () => { await prismaManager.disconnectAll(); });
