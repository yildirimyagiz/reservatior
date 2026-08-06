import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType, VideoTargetPlatform, VideoContentStatus } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";
const PROJECT_ID = "tr-ozak-hayatcity";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

const UNIT_TYPES = [
  { name: "1+1 Standard", area: 65,  beds: 1, baths: 1, level: 2, priceUSD: 170000, rentTRY: 25000 },
  { name: "2+1 Family",   area: 100, beds: 2, baths: 1, level: 5, priceUSD: 260000, rentTRY: 35000 },
  { name: "3+1 Luxury",   area: 145, beds: 3, baths: 2, level: 8, priceUSD: 380000, rentTRY: 45000 },
];

const AMENITIES = [
  "Gym / Spor Salonu",
  "Sauna",
  "Basketbol Sahası",
  "Yeşil Alanlar",
  "Çocuk Oyun Alanı",
  "Açık & Kapalı Otopark",
  "24/7 Güvenlik",
  "Depo Alanı",
];

const PHOTOS = [
  "/videos/ozak-bg.mp4", // Using the video as primary media if needed, but we'll put mock images here too
  "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&q=80",
  "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&q=80",
];

// Bağcılar, Mahmutbey coordinates
const LAT = 41.0583;
const LNG = 28.8142;

async function main() {
  console.log("🏢 ÖZAK HAYAT CITY | Seeding project, units, for-sale and for-rent listings...");
  
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
      name: "ÖZAK HAYAT CITY",
      type: "APARTMENT",
      region: "TR",
      currency: "TRY",
      addressLine1: "Mahmutbey Mahallesi, Bağcılar",
      city: "Istanbul",
      state: "Istanbul",
      zip: "34218",
      country: "TR",
      lat: LAT,
      lng: LNG,
      propertyCategory: "RESIDENTIAL",
      listingType: "SALE",
      listingStatus: "WILL_BE_AVAILABLE",
      yearBuilt: 2026,
      livingAreaSqFt: 6500 * 10.7639,
      bedrooms: 2,
      bathrooms: 1,
      stories: 15,
      unitsPerBuilding: 142,
      viewType: "CITY",
      parkingSpaces: 142,
      notes: JSON.stringify({
        developer: "Özak GYO (Özak Global Holding)",
        projectName: "Özak Hayat City",
        deliveryDate: "2026-06",
        landArea: "6,500 m²",
        totalBlocks: 1,
        totalUnits: 142,
        paymentPlan: {
          downPayment: "50%",
          installments: "6 monthly",
          vat: "1% (included in prices)",
          titleDeedFee: "0%",
          expertiseReport: "Not required",
        },
        distances: {
          metroStation: "1 step",
          basinEkspres: "10 minutes",
          airport: "20 minutes",
        },
        citizenshipEligible: true,
        socialFacilities: AMENITIES,
      }),
    },
  });

  // 3. Create both SALE and RENT listings for the overall property project
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
      title: "Özak Hayat City - Satılık Lüks Daireler (Mahmutbey, Bağcılar)",
      description: "Mahmutbey Metro durağının hemen yanında, Basın Ekspres'e 10 dk, havalimanına 20 dk mesafede Özak GYO güvencesiyle yükselen Hayat City. %50 peşin, kalan %50 6 ay vade avantajıyla. Vatandaşlığa uygun, ekspertiz raporu gerekmez.",
      price: 170000,
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
      title: "Özak Hayat City - Kiralık Konforlu Daireler (Mahmutbey, Bağcılar)",
      description: "Metronun yanı başında, sıfır binada kiralık lüks daire seçenekleri. Depo alanı, otopark, gym, sauna ve çocuk oyun alanları dahil eksiksiz bir yaşam kompleksi.",
      price: 25000,
      priceCurrency: "TRY",
    },
  });

  // 4. Seeding individual unit type listings for test coverage
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
        imageUrl: PHOTOS[1],
      },
    });

    // Sale Listing for specific unit type
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
        title: `Özak Hayat City - Satılık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² genişliğinde, otopark ve depo dahil satılık lüks ${u.name} daire.`,
        price: u.priceUSD,
        priceCurrency: "USD",
      },
    });

    // Rent Listing for specific unit type
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
        title: `Özak Hayat City - Kiralık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² genişliğinde, otopark ve depo dahil kiralık konforlu ${u.name} daire.`,
        price: u.rentTRY,
        priceCurrency: "TRY",
      },
    });
  }

  // 5. Seeding background video as a VideoContent record
  await prisma.videoContent.upsert({
    where: { id: `tr_video_${PROJECT_ID}_bg` },
    update: {},
    create: {
      id: `tr_video_${PROJECT_ID}_bg`,
      orgId: org.id,
      propertyId: property.id,
      title: "Özak Hayat City Tanıtım Videosu",
      primaryLoraStyle: "REALISTIC",
      prompt: "Luxury modern high-rise residential building in Istanbul, clean architecture, sunset",
      platform: VideoTargetPlatform.PLATFORM_INTERNAL,
      status: VideoContentStatus.READY,
      url: "/videos/ozak-bg.mp4",
      thumbnailUrl: PHOTOS[1],
    },
  });

  // 6. Project record
  await prisma.project.upsert({
    where: { id: `tr_proj_${PROJECT_ID}` },
    update: {},
    create: {
      id: `tr_proj_${PROJECT_ID}`,
      orgId: org.id,
      propertyId: property.id,
      name: "Özak Hayat City",
      description: "Mahmutbey, Bağcılar bölgesinde konumlanmış metroya 1 adım mesafede Özak GYO projesi.",
      projectType: "RESIDENTIAL",
      address: "Mahmutbey, Bağcılar, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2024-06-01"),
      estimatedEndDate: new Date("2026-06-30"),
      budget: 35000000,
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
        projectName: "Özak Hayat City",
        deliveryDate: "2026-06",
        totalUnits: 142,
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
        caption: `Özak Hayat City - Görsel ${i}`,
        featured: i === 0,
      },
    });
  }

  console.log("✅ Seeding completed successfully!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prismaManager.disconnectAll();
  });
