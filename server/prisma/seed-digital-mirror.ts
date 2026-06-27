import { Region, ProjectStatus } from "@prisma/client";
import PrismaManager from "../src/lib/prisma";

// --- DIGITAL MIRROR: REAL WORLD ICONIC PROJECTS ---
const mirroredProjects = [
  {
    id: "proj-tr-zorlu",
    name: "Zorlu Center",
    countryCode: "TR",
    region: Region.TR,
    description: "Istanbul's premier mixed-use landmark at the junction of the Bosphorus Bridge and Büyükdere axis. A masterpiece by Emre Arolat Architecture featuring 4 iconic towers (18-22 floors) on a reconstructed topographical shell. Includes luxury residences, the Raffles Istanbul Hotel, a global-brand shopping mall, and the Zorlu Performance Arts Center (PSM).",
    address: "Levazım, Koru Sokağı No:2, 34340 Beşiktaş/İstanbul",
    floorCount: 22,
    mainImage: "https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/02-46-scaled.jpg",
    externalPhotos: JSON.stringify([
      "https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/01-49-scaled.jpg",
      "https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/05-39-scaled.jpg",
      "https://emre-arolat.fra1.digitaloceanspaces.com/wp-content/uploads/2022/04/13-30-scaled.jpg",
      "https://www.zorlucenter.com.tr/assets/img/zorlu-psm.jpg"
    ]),
    floorPlanTemplates: JSON.stringify([
      { name: "Executive 1+1", area: 117, image: "https://www.zorlucenter.com/assets/img/kat-plani-1.png" },
      { name: "Family Suite 2+1", area: 185, image: "https://www.zorlucenter.com/assets/img/kat-plani-2.png" },
      { name: "Panorama 3+1", area: 260, image: "https://www.zorlucenter.com/assets/img/kat-plani-3.png" },
      { name: "Sky Garden 4+1", area: 420, image: "https://www.zorlucenter.com/assets/img/kat-plani-4.png" },
      { name: "Grand Penthouse 5+1", area: 735, image: "https://www.zorlucenter.com/assets/img/kat-plani-5.png" }
    ]),
    amenities: JSON.stringify([
      "Raffles Hotel", 
      "Performance Arts Center (PSM)", 
      "Luxury Shopping Mall (AVM)", 
      "Indoor/Outdoor Pools", 
      "Fitness & Wellness Center", 
      "Direct Metro/Metrobüs Connection", 
      "Vertical Gardens",
      "24/7 Concierge & Security"
    ])
  },
  {
    id: "proj-tr-sapphire",
    name: "Istanbul Sapphire",
    countryCode: "TR",
    region: Region.TR,
    description: "Europe's iconic residential skyscraper in Levent. A pioneer in vertical living with integrated green spaces and 360° observation deck.",
    address: "Büyükdere Cd. No:1, 34410 Kâğıthane/İstanbul",
    floorCount: 54,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/e/e8/Istanbul_Sapphire_2014.jpg",
    externalPhotos: JSON.stringify([
      "https://upload.wikimedia.org/wikipedia/commons/3/39/Istanbul_Sapphire_Sky_Deck_View.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/f/f6/Sapphire_Shopping_Mall.jpg"
    ]),
    floorPlanTemplates: JSON.stringify([
      { name: "Sky Loft 1+1", area: 120, image: "https://www.residenceindex.com/images/floorplan/sapphire_plan_1.jpg" },
      { name: "Panorama 3+1", area: 245, image: "https://www.residenceindex.com/images/floorplan/sapphire_plan_2.jpg" }
    ]),
    amenities: JSON.stringify(["Observation Deck", "Golf Practice", "Cinema", "Shopping Mall", "Vertical Gardens", "Helipad Access"])
  },
  {
    id: "proj-tr-skyland",
    name: "Skyland Istanbul",
    countryCode: "TR",
    region: Region.TR,
    description: "Designed by Peter Vaughan (Broadway Malyan), Skyland Istanbul is a 284-meter landmark featuring the tallest towers in Turkey. A premier mixed-use complex in Seyrantepe consisting of Residential, Office, and Hotel towers. Home to the HOM Design Center and offering 360° views of the Belgrad Forest and Bosphorus.",
    address: "Huzur, Cendere Cd. No:114, 34485 Sarıyer/İstanbul",
    floorCount: 65,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/7/7b/Skyland_Istanbul_CP.jpg",
    externalPhotos: JSON.stringify([
      "https://skylandistanbul.com/assets/img/galleries/residential/1.jpg",
      "https://skylandistanbul.com/assets/img/galleries/residential/2.jpg",
      "https://skylandistanbul.com/assets/img/galleries/office/1.jpg"
    ]),
    floorPlanTemplates: JSON.stringify([
      { name: "Sky View 1+1", area: 85, image: "https://skylandistanbul.com/assets/img/plan-1.png" },
      { name: "Horizon 2+1", area: 145, image: "https://skylandistanbul.com/assets/img/plan-2.png" },
      { name: "Executive 3+1", area: 210, image: "https://skylandistanbul.com/assets/img/plan-3.png" },
      { name: "Tower Penthouse", area: 460, image: "https://skylandistanbul.com/assets/img/plan-4.png" }
    ]),
    amenities: JSON.stringify([
      "HOM Design Center", 
      "Smart Home 2.0 System", 
      "Wellness & Spa", 
      "Heliport Access", 
      "65th Floor Lounge", 
      "Belgrad Forest Views",
      "Direct E-5/TEM Connection"
    ])
  },
  {
    id: "proj-tr-emaar",
    name: "Emaar Square Istanbul",
    countryCode: "TR",
    region: Region.TR,
    description: "A major mixed-use development in Üsküdar featuring luxury residences, the Address Hotel, and one of Turkey's largest shopping malls.",
    address: "Ünalan, Libadiye Cd. No:82, 34700 Üsküdar/İstanbul",
    floorCount: 33,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/2/2c/Emaar_Square_Mall_Istanbul.jpg",
    externalPhotos: JSON.stringify([
      "https://upload.wikimedia.org/wikipedia/commons/5/5e/Emaar_Square_North_Tower.jpg",
      "https://www.emaarsquare.com.tr/assets/img/emaar-skyview.jpg"
    ]),
    floorPlanTemplates: JSON.stringify([
      { name: "Address Residence 1+1", area: 88, image: "https://www.emaarsquare.com.tr/assets/img/kat-plani-1.png" },
      { name: "Family Loft 3+1", area: 210, image: "https://www.emaarsquare.com.tr/assets/img/kat-plani-2.png" }
    ]),
    amenities: JSON.stringify(["Address Hotel", "Aquarium & Underwater Zoo", "Luxury Retail", "Cinemas", "Outdoor Pools"])
  },
  {
    id: "proj-tr-vadi",
    name: "Vadistanbul",
    countryCode: "TR",
    region: Region.TR,
    description: "A visionary urban transformation project by Artaş, Aydınlı, and Invest. Spanning 424,000 sqm across Teras, Bulvar, and Park phases. Features Turkey's first private monorail (Havaray) connecting directly to the metro. Includes the Vadistanbul Shopping Mall, high-end offices, and the Radisson Blu Hotel at the edge of the Belgrad Forest.",
    address: "Ayazağa, Cendere Cd. No:109, 34485 Sarıyer/İstanbul",
    floorCount: 20,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/e/e4/Vadi_Istanbul_Shopping_Mall.jpg",
    externalPhotos: JSON.stringify([
      "https://www.artasholding.com/Images/Proje/vadi-bulvar-1.jpg",
      "https://www.artasholding.com/Images/Proje/vadi-park-1.jpg"
    ]),
    floorPlanTemplates: JSON.stringify([
      { name: "Park Residence 2+1", area: 135, image: "https://www.artasholding.com/tr-tr/proje/vadistanbul-park/plan-1.png" },
      { name: "Teras Forest 3+1", area: 185, image: "https://www.artasholding.com/tr-tr/proje/vadistanbul-teras/plan-2.png" },
      { name: "Bulvar Office Suite", area: 120, image: "https://www.artasholding.com/tr-tr/proje/vadistanbul-bulvar/plan-3.png" }
    ]),
    amenities: JSON.stringify([
      "Private Monorail (Havaray)", 
      "Vadistanbul Shopping Mall", 
      "Radisson Blu Hotel", 
      "Bosphorus Water Flow Simulation", 
      "Forest Running Tracks", 
      "760-meter Shopping Street"
    ])
  },
  {
    id: "proj-tr-galataport",
    name: "Galataport Istanbul",
    countryCode: "TR",
    region: Region.TR,
    description: "A world-class cruise port and lifestyle destination on the Bosphorus, featuring luxury residences and the Peninsula Istanbul hotel.",
    address: "Kılıçali Paşa, Meclis-i Mebusan Cd. No:2, 34433 Beyoğlu/İstanbul",
    floorCount: 5,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/d/da/Galataport_Istanbul_2021.jpg",
    externalPhotos: JSON.stringify([
      "https://upload.wikimedia.org/wikipedia/commons/0/0a/Galataport_Cruise_Terminal.jpg",
      "https://www.galataport.com/assets/img/gallery/the-peninsula.jpg"
    ]),
    floorPlanTemplates: JSON.stringify([
      { name: "Bosphorus Suite", area: 180, image: "https://www.galataport.com/assets/img/residences/floorplan-a.jpg" },
      { name: "Garden Loft", area: 150, image: "https://www.galataport.com/assets/img/residences/floorplan-b.jpg" }
    ]),
    amenities: JSON.stringify(["Cruise Terminal", "Underground Parking", "Museums", "Promenade", "Luxury Retail"])
  },
  {
    id: "proj-ae-burj-khalifa",
    name: "Burj Khalifa Residences",
    countryCode: "AE",
    region: Region.UAE,
    description: "Living in the world's tallest building. Unmatched luxury and smart-connected living in the heart of Downtown Dubai.",
    address: "1 Mohammed Bin Rashid Boulevard, Downtown Dubai",
    floorCount: 163,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/9/93/Burj_Khalifa.jpg",
    externalPhotos: JSON.stringify(["https://www.burjkhalifa.ae/en/images/gallery/1.jpg"]),
    floorPlanTemplates: JSON.stringify([
      { name: "Signature 2+1", area: 165 },
      { name: "Sky Palace 4+1", area: 450 }
    ]),
    amenities: JSON.stringify(["Burj Club", "Atmosphere Lounge", "The Park", "Observation Deck"])
  },
  {
    id: "proj-sg-mbs",
    name: "Marina Bay Sands Residences",
    countryCode: "SG",
    region: Region.GLOBAL,
    description: "Singapore's most iconic integrated resort and luxury residential landmark with the world's largest infinity pool.",
    address: "10 Bayfront Ave, Singapore 018956",
    floorCount: 57,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/a/af/Singapore_%28SG%29%2C_Marina_Bay_Sands_Hotel_--_2019_--_4462.jpg",
    externalPhotos: JSON.stringify(["https://www.marinabaysands.com/content/dam/revamp/hotel/rooms-suites/orchid-suite.jpg"]),
    floorPlanTemplates: JSON.stringify([
      { name: "Orchid Suite", area: 110, image: "https://www.marinabaysands.com/content/dam/revamp/hotel/rooms-suites/orchid-suite-floorplan.jpg" },
      { name: "Chairman Suite", area: 600, image: "https://www.marinabaysands.com/content/dam/revamp/hotel/rooms-suites/chairman-suite-floorplan.jpg" }
    ]),
    amenities: JSON.stringify(["Infinity Pool", "SkyPark", "Casino", "Celebrity Chef Restaurants", "Convention Center"])
  },
  {
    id: "proj-us-central-park-tower",
    name: "Central Park Tower NYC",
    countryCode: "US",
    region: Region.USA,
    description: "The tallest residential building in the world, located on Billionaires' Row in Manhattan with views over Central Park.",
    address: "217 West 57th Street, New York, NY 10019",
    floorCount: 98,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/f/fe/Central_Park_Tower_April_2023_1_%28cropped%29.jpg",
    externalPhotos: JSON.stringify(["https://www.centralparktower.com/assets/img/gallery/1.jpg"]),
    floorPlanTemplates: JSON.stringify([
      { name: "Residence 32A", area: 320, image: "https://www.centralparktower.com/assets/img/residences/residence-32a-floorplan.jpg" },
      { name: "Duplex Penthouse", area: 850, image: "https://www.centralparktower.com/assets/img/residences/penthouse-floorplan.jpg" }
    ]),
    amenities: JSON.stringify(["Central Park Club", "Private Theater", "Outdoor Terrace", "Wellness Center", "Billiards Room"])
  },
  {
    id: "proj-uk-battersea",
    name: "Battersea Power Station",
    countryCode: "UK",
    region: Region.UK,
    description: "London's most iconic industrial landmark, transformed into a premium residential, retail, and office destination.",
    address: "Circus Rd W, Nine Elms, London SW11 8AL",
    floorCount: 18,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/a/af/Battersea_Power_Station_in_London.jpg",
    externalPhotos: JSON.stringify(["https://batterseapowerstation.co.uk/content/dam/bps/gallery/1.jpg"]),
    floorPlanTemplates: JSON.stringify([
      { name: "Switch House Loft", area: 140, image: "https://batterseapowerstation.co.uk/content/dam/bps/floorplans/switch-house-2br.jpg" },
      { name: "Boiler House Studio", area: 65, image: "https://batterseapowerstation.co.uk/content/dam/bps/floorplans/boiler-house-studio.jpg" }
    ]),
    amenities: JSON.stringify(["Roof Gardens", "Power Station Park", "Co-working space", "Luxury Spa", "River Bus Access"])
  }
];

async function main() {
  console.log("🏙️ DIGITAL MIRRORING: SYNCING REAL-WORLD PROJECTS TO GLOBAL INFRASTRUCTURE...");

  for (const proj of mirroredProjects) {
    // We update the country-specific DB, the US DB, and the base DB (DEFAULT)
    // To get the true base DB from PrismaManager, we can pass an empty string or a code that doesn't exist in regions-config
    const targetCountries = [proj.countryCode, "US", "BASE"];
    
    for (const country of targetCountries) {
      try {
        // If country is BASE, we want to use the default DATABASE_URL from .env
        // PrismaManager uses process.env[`DATABASE_URL_${upperCode}`] || process.env.DATABASE_URL
        // Since DATABASE_URL_BASE doesn't exist, it will fallback to DATABASE_URL
        const prisma = PrismaManager.getClient(country);
        
        console.log(`\n🏗️  Mirroring: ${proj.name} -> Target DB: ${country}`);

        await prisma.project.upsert({
          where: { id: proj.id },
          update: {
            name: proj.name,
            description: proj.description,
            address: proj.address,
            orgId: "seed-global-org-master"
          },
          create: {
            id: proj.id,
            name: proj.name,
            orgId: "seed-global-org-master",
            description: proj.description,
            address: proj.address,
            projectType: "RESIDENTIAL",
            status: ProjectStatus.ACTIVE
          }
        });
        console.log(`   ✅ Success: ${proj.name} synced to ${country}`);
      } catch (error: unknown) {
        // Skip errors for non-existent DBs in dev
        const errorMessage = error instanceof Error ? error.message : String(error);
        if (!errorMessage.includes("No database URL found")) {
           console.error(`   ❌ Failed to mirror ${proj.name} in ${country}: ${errorMessage}`);
        }
      }
    }
  }

  console.log("\n✨ DIGITAL MIRRORING COMPLETE.");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await PrismaManager.disconnectAll();
  });
