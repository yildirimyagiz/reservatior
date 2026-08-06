import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType, VideoTargetPlatform, VideoContentStatus } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";
const PROJECT_ID = "tr-ozak-dragos";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

const UNIT_TYPES = [
  { name: "1+1 Standard",      area: 60,  beds: 1, baths: 1,   level: 3,  priceUSD: 160000, rentTRY: 27000 },
  { name: "1+1 Sea View",      area: 70,  beds: 1, baths: 1,   level: 8,  priceUSD: 200000, rentTRY: 33000 },
  { name: "2+1 Standard",      area: 100, beds: 2, baths: 1,   level: 5,  priceUSD: 280000, rentTRY: 40000 },
  { name: "2+1 Island View",   area: 115, beds: 2, baths: 1.5, level: 10, priceUSD: 340000, rentTRY: 48000 },
  { name: "3+1 Family",        area: 140, beds: 3, baths: 2,   level: 7,  priceUSD: 420000, rentTRY: 58000 },
  { name: "3+1 Panoramic Sea", area: 165, beds: 3, baths: 2,   level: 14, priceUSD: 520000, rentTRY: 70000 },
];

const AMENITIES = [
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
  "/videos/ozak-dragos-bg.mp4",
  "https://cdn.reservatior.com/projects/ozak-dragos/exterior-island-view.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/pool-area.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/sea-panorama.jpg",
  "https://cdn.reservatior.com/projects/ozak-dragos/apartment-interior.jpg",
];

const LAT = 40.9267;
const LNG = 29.0706;

async function main() {
  console.log("🏝️ ÖZAK DRAGOS | Seeding project, units, for-sale and for-rent listings...");
  
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
        socialFacilities: AMENITIES,
        sharePointDrive: "https://ozakglobalholding-my.sharepoint.com/:f:/g/personal/mahmut_demir_ozakgyo_com/EhIuFOgIENNBg5pqHgJ4Q_UBuB6JtYHddXMZe-iLkV277g",
        locationMap: "https://maps.app.goo.gl/2tV5dzJHMec4Ws4f6",
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
      title: "ÖZAK DRAGOS | Satılık Lüks Daireler (Maltepe, İstanbul)",
      description: "Maltepe Dragos'ta ada ve deniz manzaralı Özak GYO projesi. %50 peşin, 24 ay taksit avantajıyla. KDV %10 fiyatlara dahil. Ekspertiz raporu gerekmez.",
      price: 160000,
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
      title: "ÖZAK DRAGOS | Kiralık Konforlu Daireler (Maltepe, İstanbul)",
      description: "Maltepe Dragos'ta deniz manzaralı kiralık daire seçenekleri. Otopark, depo, yüzme havuzu ve sosyal tesisler dahil.",
      price: 27000,
      priceCurrency: "TRY",
    },
  });

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
      description: "Maltepe Dragos - Ada ve deniz manzarası. %50 peşin + 24 taksit.",
      projectType: "RESIDENTIAL",
      address: "Dragos Mahallesi, Maltepe, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2024-03-01"),
      estimatedEndDate: new Date("2026-12-31"),
      budget: 85000000,
      currency: "USD",
      managerId: user?.id || undefined,
    },
  });

  // 5. Seeding individual unit type listings (Sale and Rent)
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
        description: `${u.area} m² | ${u.beds} yatak | ${u.baths} banyo`,
        floorLevel: u.level,
        imageUrl: PHOTOS[1],
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
        title: `ÖZAK DRAGOS - Satılık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² deniz manzaralı, depo ve otopark dahil satılık lüks ${u.name} daire.`,
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
        title: `ÖZAK DRAGOS - Kiralık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² genişliğinde, depo ve otopark dahil kiralık lüks ${u.name} daire.`,
        price: u.rentTRY,
        priceCurrency: "TRY",
      },
    });
  }

  // 6. Background video
  await prisma.videoContent.upsert({
    where: { id: `tr_video_${PROJECT_ID}_bg` },
    update: {},
    create: {
      id: `tr_video_${PROJECT_ID}_bg`,
      orgId: org.id,
      propertyId: property.id,
      title: "Özak Dragos Tanıtım Videosu",
      primaryLoraStyle: "REALISTIC",
      prompt: "Luxury modern residential complex by the sea in Istanbul, islands view, sunset",
      platform: VideoTargetPlatform.PLATFORM_INTERNAL,
      status: VideoContentStatus.READY,
      url: "/videos/ozak-dragos-bg.mp4",
      thumbnailUrl: PHOTOS[1],
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
        projectName: "ÖZAK DRAGOS | View of Islands and Sea",
        deliveryDate: "2026-12",
        totalUnits: 458,
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
        caption: `ÖZAK DRAGOS - Görsel ${i}`,
        featured: i === 0,
      },
    });
  }

  console.log("✅ Özak Dragos Seeding completed successfully!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prismaManager.disconnectAll();
  });
