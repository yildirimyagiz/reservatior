import { PrismaClient, ListingType, ListingStatus, EarningStrategy, PhotoType, VideoTargetPlatform, VideoContentStatus } from "@prisma/client";
import prismaManager from "../src/lib/prisma";

const ORG_ID = "tr_residence_org";
const PROJECT_ID = "tr-ozak-buyukyali";
const PROP_ID = `tr_prop_${PROJECT_ID}`;

const UNIT_TYPES = [
  { name: "2+1 Standard", area: 110, beds: 2, baths: 1.5, level: 3, priceUSD: 310000, rentTRY: 45000 },
  { name: "3+1 Family",   area: 150, beds: 3, baths: 2,   level: 5, priceUSD: 450000, rentTRY: 60000 },
  { name: "4+1 Premium",  area: 190, beds: 4, baths: 2.5, level: 8, priceUSD: 600000, rentTRY: 75000 },
  { name: "Loft Suite",   area: 180, beds: 3, baths: 2,   level: 11, priceUSD: 750000, rentTRY: 90000 },
  { name: "5.5+1 Penthouse", area: 310, beds: 5, baths: 4, level: 14, priceUSD: 980000, rentTRY: 110000 },
];

const FACILITIES = [
  "Açık & Kapalı Yüzme Havuzları",
  "Fitness / Spor Salonu",
  "Sauna",
  "Türk Hamamı",
  "Açık & Kapalı Sinema Alanları",
  "Tiyatro & Konser Salonu (Fişekhane)",
  "Özel Alışveriş Caddesi (Markalar & Süpermarket)",
  "30 km Sahil Yürüyüş & Bisiklet Yolu Köprüsü",
  "Kapalı Otopark",
  "24/7 Güvenlik & Resepsiyon",
  "Depo Alanı",
];

const PHOTOS = [
  "/videos/ozak-buyukyali-bg.mp4",
  "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=1200&q=80",
  "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1200&q=80",
];

// Zeytinburnu, Kennedy Avenue coordinates
const LAT = 40.9881;
const LNG = 28.8964;

async function main() {
  console.log("🌊 ÖZAK BÜYÜKYALI | Seeding project, units, for-sale and for-rent listings...");
  
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
      name: "BÜYÜKYALI | Sea View",
      type: "APARTMENT",
      region: "TR",
      currency: "TRY",
      addressLine1: "Kazlıçeşme Mahallesi, Kennedy Caddesi",
      city: "Istanbul",
      state: "Istanbul",
      zip: "34020",
      country: "TR",
      lat: LAT,
      lng: LNG,
      propertyCategory: "RESIDENTIAL",
      listingType: "SALE",
      listingStatus: "WILL_BE_AVAILABLE",
      yearBuilt: 2024,
      livingAreaSqFt: 111000 * 10.7639,
      bedrooms: 3,
      bathrooms: 2,
      stories: 15,
      unitsPerBuilding: 1557,
      viewType: "SEA",
      parkingSpaces: 1557,
      notes: JSON.stringify({
        developer: "Özak GYO (Özak Global Holding)",
        projectName: "Büyükyalı İstanbul",
        deliveryDate: "Ready-to-Deliver",
        landArea: "111,000 m²",
        totalBlocks: 14,
        totalUnits: 1557,
        paymentPlan: {
          downPayment: "50%",
          installments: "12 monthly",
          vat: "1% and 20% included in prices",
          titleDeedFee: "0%",
          expertiseReport: "Not required",
        },
        distances: {
          promenade: "Direct Bridge Connection",
          fisekhane: "On-site",
          airport: "35 minutes",
        },
        citizenshipEligible: true,
        socialFacilities: FACILITIES,
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
      title: "Büyükyalı İstanbul - Satılık Deniz Manzaralı Daireler (Zeytinburnu)",
      description: "Kennedy Caddesi kıyısında, tarihi Fişekhane binasına ve deniz sahil yoluna doğrudan bağlanan lüks Özak GYO projesi Büyükyalı. Hemen teslim, vatandaşlığa uygun, tapu masrafsız satılık daireler.",
      price: 310000,
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
      title: "Büyükyalı İstanbul - Kiralık Lüks Loft ve Daire Seçenekleri",
      description: "Fişekhane sosyal yaşamı, mağazalar, sinema ve konser alanlarıyla iç içe kiralık lüks loft ve daireler. Deniz manzaralı, otoparklı, havuzlu ve eksiksiz güvenlikli yaşam alanı.",
      price: 45000,
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
        title: `Büyükyalı - Satılık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² deniz manzaralı, otopark ve depo dahil satılık lüks ${u.name} daire.`,
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
        title: `Büyükyalı - Kiralık ${u.name} (${u.area} m²)`,
        description: `${u.area} m² genişliğinde kiralık ${u.name} daire. Fişekhane ve sahil köprüsü bağlantısıyla.`,
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
      title: "Büyükyalı Tanıtım Videosu",
      primaryLoraStyle: "REALISTIC",
      prompt: "Luxury residential complex on the coast in Istanbul, sea view, fisekhane",
      platform: VideoTargetPlatform.PLATFORM_INTERNAL,
      status: VideoContentStatus.READY,
      url: "/videos/ozak-buyukyali-bg.mp4",
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
      name: "Büyükyalı İstanbul",
      description: "Fişekhane ve Kennedy Caddesi bölgesinde konumlanmış deniz manzaralı Özak GYO projesi.",
      projectType: "RESIDENTIAL",
      address: "Kennedy Caddesi, Zeytinburnu, Istanbul",
      status: "ACTIVE",
      startDate: new Date("2021-01-01"),
      estimatedEndDate: new Date("2024-12-31"),
      budget: 150000000,
      currency: "USD",
    },
  });

  // 7. Seeding facilities
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
        caption: `Büyükyalı İstanbul - Görsel ${i}`,
        featured: i === 0,
      },
    });
  }

  console.log("✅ Büyükyalı Seeding completed successfully!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prismaManager.disconnectAll();
  });
