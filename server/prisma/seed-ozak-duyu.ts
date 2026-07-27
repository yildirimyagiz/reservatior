import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType, VideoTargetPlatform, VideoContentStatus } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";
const PROJECT_ID = "tr-ozak-duyu-forest-view";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

const UNIT_TYPES = [
  { name: "1+1 Compact",       area: 65,  beds: 1, baths: 1,   level: 1,  priceUSD: 180000, rentTRY: 25000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-1-1-a2-W5Q5Y.webp" },
  { name: "1+1 Garden",        area: 75,  beds: 1, baths: 1,   level: 0,  priceUSD: 210000, rentTRY: 28000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-1-1-a2-W5Q5Y.webp" },
  { name: "2+1 Standard",      area: 100, beds: 2, baths: 1,   level: 3,  priceUSD: 280000, rentTRY: 38000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-2-1-c-z-URLYB.webp" },
  { name: "2+1 Corner (A63)",  area: 115, beds: 2, baths: 1,   level: 5,  priceUSD: 320000, rentTRY: 42000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-2-1-c-z-URLYB.webp" },
  { name: "3+1 Family",        area: 145, beds: 3, baths: 2,   level: 7,  priceUSD: 420000, rentTRY: 50000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-3-1-f2-AHF8U.webp" },
  { name: "3.5+1 Panoramic",   area: 165, beds: 3, baths: 2,   level: 10, priceUSD: 490000, rentTRY: 58000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-3-1-f5-t-GXXJZ.webp" },
  { name: "4+1 Premium",       area: 195, beds: 4, baths: 2.5, level: 12, priceUSD: 580000, rentTRY: 68000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-4-1-b-d-YNC2K.webp" },
  { name: "4.5+1 Penthouse",   area: 240, beds: 4, baths: 3,   level: 15, priceUSD: 720000, rentTRY: 85000, floorPlanUrl: "/images/duyu/floorplans/ozak-duyu-4-1-b-d-YNC2K.webp" },
];

const AMENITIES = [
  "Açık Yüzme Havuzu",
  "Fitness / Spor Salonu",
  "Sauna",
  "Kafe",
  "Çocuk Oyun Alanı",
  "Basketbol Sahası",
  "Yürüyüş Parkuru",
  "Peyzaj Bahçeleri",
  "24/7 Güvenlik",
  "Kapalı Otopark",
  "Depo Alanı",
  "Bisiklet Parkı",
];

const PHOTOS = [
  "/videos/ozak-duyu-bg.mp4",
  "/images/duyu/ozak_duyu_slider_1-6316E-m.webp",
  "/images/duyu/ozak_duyu_galeri-3IZUM.webp",
  "/images/duyu/ozak_duyu_galeri-GNND4.webp",
  "/images/duyu/ozak_duyu_galeri-O1JT7.webp",
  "/images/duyu/ozak_duyu_galeri-X9UXE.webp",
  "/images/duyu/1774963607_362.webp",
];

const LAT = 41.1831;
const LNG = 28.9292;

async function main() {
  console.log("🌲 ÖZAK DUYU | Seeding project, units, for-sale and for-rent listings...");
  
  const prisma = prismaManager.getClient("TR");

  // 1. Ensure Organization
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
      addressLine1: "Göktürk Merkez Mahallesi",
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
      livingAreaSqFt: 12000 * 10.7639,
      bedrooms: 2,
      bathrooms: 1,
      stories: 15,
      unitsPerBuilding: 141,
      viewType: "FOREST",
      parkingSpaces: 141,
      notes: JSON.stringify({
        developer: "Özak GYO (Özak Global Holding)",
        projectName: "Özak Duyu Göktürk",
        deliveryDate: "2026-08",
        landArea: "12,000 m²",
        totalBlocks: 5,
        totalUnits: 141,
        paymentPlan: {
          downPayment: "50%",
          installments: "12 monthly",
          vat: "VAT included in prices",
          titleDeedFee: "0%",
          expertiseReport: "Not required",
        },
        distances: {
          belgradeForest: "2 minutes",
          metroStation: "5 minutes",
          airport: "10 minutes",
        },
        socialFacilities: AMENITIES,
      }),
    },
  });

  // 3. Project Listings
  await prisma.listing.upsert({
    where: { id: `tr_list_${PROJECT_ID}_sale` },
    update: {},
    create: {
      id: `tr_list_${PROJECT_ID}_sale`,
      orgId: org.id,
      propertyId: property.id,
      type: ListingType.SALE,
      status: ListingStatus.AVAILABLE,
      strategy: EarningStrategy.LONG_TERM_STABLE,
      title: "Özak Duyu Göktürk - Satılık Orman Manzaralı Lüks Daireler",
      description: "Belgrad Ormanı'na 2 dakika, Göktürk metrosuna 5 dakika mesafede Özak GYO güvencesiyle yükselen lüks konut projesi Özak Duyu. %50 peşin, 12 ay taksitle hemen teslim avantajlı yatırımlık daireler.",
      price: 180000,
      priceCurrency: "USD",
    },
  });

  await prisma.listing.upsert({
    where: { id: `tr_list_${PROJECT_ID}_rent` },
    update: {},
    create: {
      id: `tr_list_${PROJECT_ID}_rent`,
      orgId: org.id,
      propertyId: property.id,
      type: ListingType.RENT,
      status: ListingStatus.AVAILABLE,
      strategy: EarningStrategy.LONG_TERM_STABLE,
      title: "Özak Duyu Göktürk - Kiralık Doğa ile İç İçe Daireler",
      description: "Göktürk'ün en gözde bölgesinde doğayla baş başa, havuzlu ve kapalı otoparklı kiralık 1+1, 2+1 ve 3+1 daire seçenekleri.",
      price: 25000,
      priceCurrency: "TRY",
    },
  });

  // 4. Seeding individual unit type listings (Sale and Rent)
  for (let i = 0; i < UNIT_TYPES.length; i++) {
    const u = UNIT_TYPES[i];
    
    // Floor Plan
    await prisma.floorPlan.upsert({
      where: { id: `tr_floor_${PROJECT_ID}_${i}` },
      update: {},
      create: {
        id: `tr_floor_${PROJECT_ID}_${i}`,
        orgId: org.id,
        propertyId: property.id,
        name: u.name,
        description: `${u.area} m² | ${u.beds} Yatak | ${u.baths} Banyo`,
        floorLevel: u.level,
        imageUrl: u.floorPlanUrl,
      },
    });

    // Sale Listing
    await prisma.listing.upsert({
      where: { id: `tr_list_${PROJECT_ID}_unit_${i}_sale` },
      update: {},
      create: {
        id: `tr_list_${PROJECT_ID}_unit_${i}_sale`,
        orgId: org.id,
        propertyId: property.id,
        type: ListingType.SALE,
        status: ListingStatus.AVAILABLE,
        strategy: EarningStrategy.LONG_TERM_STABLE,
        title: `Özak Duyu Göktürk - Satılık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² orman manzaralı, otopark ve depo dahil satılık lüks ${u.name} daire.`,
        price: u.priceUSD,
        priceCurrency: "USD",
      },
    });

    // Rent Listing
    await prisma.listing.upsert({
      where: { id: `tr_list_${PROJECT_ID}_unit_${i}_rent` },
      update: {},
      create: {
        id: `tr_list_${PROJECT_ID}_unit_${i}_rent`,
        orgId: org.id,
        propertyId: property.id,
        type: ListingType.RENT,
        status: ListingStatus.AVAILABLE,
        strategy: EarningStrategy.LONG_TERM_STABLE,
        title: `Özak Duyu Göktürk - Kiralık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² genişliğinde, otopark ve depo dahil kiralık lüks ${u.name} daire.`,
        price: u.rentTRY,
        priceCurrency: "TRY",
      },
    });
  }

  // 5. Background video
  await prisma.videoContent.upsert({
    where: { id: `tr_video_${PROJECT_ID}_bg` },
    update: {},
    create: {
      id: `tr_video_${PROJECT_ID}_bg`,
      orgId: org.id,
      propertyId: property.id,
      title: "Özak Duyu Göktürk Tanıtım Videosu",
      primaryLoraStyle: "REALISTIC",
      prompt: "Luxury modern residential complex surrounded by forest in Istanbul, sunset, clean architecture",
      platform: VideoTargetPlatform.PLATFORM_INTERNAL,
      status: VideoContentStatus.READY,
      url: "/videos/ozak-duyu-bg.mp4",
      thumbnailUrl: PHOTOS[1],
    },
  });

  // 6. Project
  await prisma.project.upsert({
    where: { id: `tr_proj_${PROJECT_ID}` },
    update: {},
    create: {
      id: `tr_proj_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: "Özak Duyu Göktürk",
      description: "Göktürk bölgesinde konumlanmış orman manzaralı Özak GYO projesi.",
      projectType: "RESIDENTIAL",
      address: "Göktürk, Eyüpsultan, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2024-01-01"),
      estimatedEndDate: new Date("2026-08-31"),
      budget: 65000000,
      currency: "USD",
    },
  });

  // 7. Create Facility for the project itself
  await prisma.facility.upsert({
    where: { id: `tr_fac_${PROJECT_ID}` },
    update: {},
    create: {
      id: `tr_fac_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: property.name,
      notes: JSON.stringify({
        developer: "Özak GYO (Özak Global Holding)",
        projectName: "Özak Duyu Göktürk",
        deliveryDate: "2026-08",
        totalUnits: 141,
        socialFacilities: AMENITIES,
      }),
    },
  });

  // 8. Seeding amenities via PropertyAmenity
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
    });

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
    });
  }

  // 8. Seeding photos
  for (let i = 0; i < PHOTOS.length; i++) {
    await prisma.photo.upsert({
      where: { url: PHOTOS[i] },
      update: {},
      create: {
        id: `tr_photo_${PROJECT_ID}_${i}`,
        url: PHOTOS[i],
        propertyId: property.id,
        type: i === 0 ? PhotoType.COVER : PhotoType.GALLERY,
        caption: `Özak Duyu Göktürk - Görsel ${i}`,
        featured: i === 0,
      },
    });
  }

  console.log("✅ Özak Duyu Seeding completed successfully!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prismaManager.disconnectAll();
  });
