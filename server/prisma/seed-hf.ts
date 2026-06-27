import { PrismaClient, PropertyType, Region, ListingType, ListingStatus, LegalComplianceStatus } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  console.log("🌱 Seeding High-Fidelity Property Data...");

  // 1. Find or create an organization
  const org = await prisma.organization.findFirst();
  if (!org) {
    console.error("No organization found. Please run regular seed first.");
    return;
  }

  const hfProperties: {
    name: string;
    type: PropertyType;
    city: string;
    country: string;
    listingPrice: number;
    bedrooms: number;
    bathrooms: number;
    areaSqm: number;
    notes: string;
    photos: string[];
  }[] = [
    {
      name: "The Obsidian Sky-Villa",
      type: "PENTHOUSE",
      city: "Dubai",
      country: "UAE",
      listingPrice: 12500000,
      bedrooms: 4,
      bathrooms: 5,
      areaSqm: 450,
      notes: "Trad Rent: $25000\nAirbnb: $45000\nHidden Potential: +15%\nPlan: https://images.adsttc.com/media/images/5f21/6b44/b357/652f/4b00/0173/large_jpg/02_First_Floor_Plan.jpg?1596025648",
      photos: [
        "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=1200",
        "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800"
      ]
    },
    {
      name: "Villa Azure Amalfi",
      type: "VILLA",
      city: "Amalfi",
      country: "IT",
      listingPrice: 8500000,
      bedrooms: 6,
      bathrooms: 7,
      areaSqm: 800,
      notes: "Trad Rent: $15000\nAirbnb: $35000\nHidden Potential: +22%\nPlan: https://www.conceptplans.com/images/Floor-Plans/Villa-Floor-Plan-Example.jpg",
      photos: [
        "https://images.unsplash.com/photo-1516450137517-162bdfffcc47?w=1200",
        "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800"
      ]
    },
    {
      name: "Nişantaşı Heritage Suites",
      type: "APARTMENT",
      city: "Istanbul",
      country: "TR",
      listingPrice: 2200000,
      bedrooms: 3,
      bathrooms: 2,
      areaSqm: 180,
      notes: "Trad Rent: $4000\nAirbnb: $9000\nHidden Potential: +10%\nPlan: https://www.visualizingarchitecture.com/wp-content/uploads/2014/10/Floor-Plan-Visual.jpg",
      photos: [
        "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=1200",
        "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800"
      ]
    },
    {
      name: "Silicon Valley Tech-Estate",
      type: "DETACHED_HOUSE",
      city: "Palo Alto",
      country: "US",
      listingPrice: 15000000,
      bedrooms: 5,
      bathrooms: 6,
      areaSqm: 1200,
      notes: "Trad Rent: $30000\nAirbnb: $55000\nHidden Potential: +8%\nPlan: https://www.theplancollection.com/Upload/PlanImages/162/16213/Plan-Image-Main-Level-162-13.jpg",
      photos: [
        "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200",
        "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800"
      ]
    },
    {
      name: "Zen Garden Retreat",
      type: "DETACHED_HOUSE",
      city: "Kyoto",
      country: "JP",
      listingPrice: 4500000,
      bedrooms: 4,
      bathrooms: 3,
      areaSqm: 350,
      notes: "Trad Rent: $6000\nAirbnb: $18000\nHidden Potential: +30%\nPlan: https://www.archdaily.com/938555/traditional-japanese-house-floor-plan/5ea1b6f0b35765751b00009c-traditional-japanese-house-floor-plan-drawing",
      photos: [
        "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=1200",
        "https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800"
      ]
    }
  ];

  for (const propData of hfProperties) {
    const { photos, ...rest } = propData;
    
    const property = await prisma.property.create({
      data: {
        ...rest,
        orgId: org.id,
        addressLine1: `${propData.city} Luxury District`,
        listingPrice: propData.listingPrice,
        rentalYield: (propData.name === "Zen Garden Retreat" ? 8.2 : 6.5),
        region: Region.GLOBAL,
        currency: "USD",
        legalComplianceStatus: LegalComplianceStatus.VERIFIED,
        propertyPhotos: {
          create: photos.map((url, i) => ({
            url,
            isPrimary: i === 0,
            sortOrder: i,
            orgId: org.id
          }))
        }
      }
    });

    // Create a listing for each
    await prisma.listing.create({
      data: {
        id: `list-${property.id}`,
        orgId: org.id,
        propertyId: property.id,
        title: `${propData.name} - Global Investment`,
        description: `Premium high-yield opportunity in ${propData.city}.`,
        price: propData.listingPrice,
        priceCurrency: "USD",
        type: ListingType.SALE,
        status: ListingStatus.AVAILABLE
      }
    });

    console.log(`✅ Created High-Fidelity Asset: ${propData.name}`);
  }

  console.log("🚀 High-Fidelity Seeding Complete!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
