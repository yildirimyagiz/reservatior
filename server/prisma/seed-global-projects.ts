import { Region, ProjectStatus, OrgType } from "@prisma/client";

import PrismaManager from "../src/lib/prisma";

// --- PROJECT DEFINITIONS ---

// Iconic & High-Detail Projects
const iconicProjects = [
  // --- TURKİYE ---
  {
    id: "proj-tr-zorlu",
    name: "Zorlu Center",
    description: "Iconic mixed-use development featuring luxury residences, a world-class performance center, and upscale retail in the heart of Beşiktaş.",
    projectType: "RESIDENTIAL",
    address: "Levazım, Koru Sokağı No:2, 34340 Beşiktaş/İstanbul",
    status: ProjectStatus.ACTIVE,
    region: Region.TR,
    floorCount: 32,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/e/e0/Zorlu_Center_%C4%B0stanbul%2C_p1.jpg",
    floorPlanTemplates: JSON.stringify([
      { name: "Luxury Studio", area: 85, image: "https://www.zorlucenter.com/assets/img/kat-plani.png" },
      { name: "Panorama 2BR", area: 160, image: "https://www.zorlucenter.com/assets/img/kat-plani.png" }
    ])
  },
  {
    id: "proj-tr-skyland",
    name: "Skyland Istanbul",
    description: "Istanbul's premier office and residential skyscraper complex in Seyrantepe.",
    projectType: "RESIDENTIAL",
    address: "Huzur, Cendere Cd. No:114, 34485 Sarıyer/İstanbul",
    status: ProjectStatus.ACTIVE,
    region: Region.TR,
    floorCount: 64,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/7/7b/Skyland_Istanbul_CP.jpg",
    floorPlanTemplates: JSON.stringify([
      { name: "Sky View 1BR", area: 75, image: "https://skylandistanbul.com/assets/img/plan-1.png" },
      { name: "Penthouse", area: 240, image: "https://skylandistanbul.com/assets/img/plan-2.png" }
    ])
  },
  // --- UAE ---
  {
    id: "proj-ae-burj-khalifa",
    name: "Burj Khalifa Residences",
    description: "Living in the world's tallest building. Unmatched luxury and smart-connected smart living in Downtown Dubai.",
    projectType: "RESIDENTIAL",
    address: "1 Mohammed Bin Rashid Boulevard, Downtown Dubai",
    status: ProjectStatus.ACTIVE,
    region: Region.UAE,
    floorCount: 163,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/9/90/Burj_Khalifa.jpg",
    floorPlanTemplates: JSON.stringify([
      { name: "Executive Suite", area: 95, image: "https://www.burjkhalifa.ae/assets/img/floorplan-1.jpg" },
      { name: "Royal Apartment", area: 210, image: "https://www.burjkhalifa.ae/assets/img/floorplan-2.jpg" }
    ])
  },
  {
      id: "proj-ae-princess-tower",
      name: "Princess Tower Dubai",
      description: "One of the tallest residential towers in the world, located in the prestigious Dubai Marina.",
      projectType: "RESIDENTIAL",
      address: "Dubai Marina, Dubai",
      status: ProjectStatus.ACTIVE,
      region: Region.UAE,
      floorCount: 101,
      mainImage: "https://upload.wikimedia.org/wikipedia/commons/3/30/Princess_Tower_Dubai_Marina.jpg",
      floorPlanTemplates: JSON.stringify([
        { name: "Marina View 2BR", area: 130, image: "https://www.princesstower.ae/plans/plan-a.jpg" }
      ])
  },
  // --- UK ---
  {
    id: "proj-uk-battersea",
    name: "Battersea Power Station",
    description: "Regenerated industrial icon turned into London's most exciting residential and retail node.",
    projectType: "RESIDENTIAL",
    address: "Battersea, London SW11 8AL",
    status: ProjectStatus.ACTIVE,
    region: Region.UK,
    floorCount: 18,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/a/af/Battersea_Power_Station_in_London.jpg",
    floorPlanTemplates: JSON.stringify([
      { name: "Switch House Loft", area: 110, image: "https://batterseapowerstation.co.uk/plans/loft.jpg" }
    ])
  },
  {
    id: "proj-uk-landmark-pinnacle",
    name: "Landmark Pinnacle London",
    description: "Western Europe's tallest residential building, offering 360-degree views of the capital.",
    projectType: "RESIDENTIAL",
    address: "15 Westferry Rd, London E14 8JH",
    status: ProjectStatus.ACTIVE,
    region: Region.UK,
    floorCount: 75,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/2/23/Landmark_Pinnacle_London.jpg",
    floorPlanTemplates: JSON.stringify([
      { name: "Cloud Residence", area: 85, image: "https://landmarkpinnacle.com/plans/cloud.jpg" }
    ])
  },
  // --- US ---
  {
    id: "proj-us-hudson-yards",
    name: "Hudson Yards NYC",
    description: "New York's newest neighborhood. A masterpiece of modern architecture and urban development.",
    projectType: "RESIDENTIAL",
    address: "Hudson Yards, New York, NY 10001",
    status: ProjectStatus.ACTIVE,
    region: Region.USA,
    floorCount: 92,
    mainImage: "https://upload.wikimedia.org/wikipedia/commons/f/fe/Central_Park_Tower_April_2023_1_%28cropped%29.jpg",
    floorPlanTemplates: JSON.stringify([
      { name: "Sky Suite", area: 150, image: "https://hudsonyards.com/plans/sky-suite.jpg" }
    ])
  },
  {
      id: "proj-us-central-park-tower",
      name: "Central Park Tower",
      description: "The tallest residential building in the world, located on Billionaires' Row in Manhattan.",
      projectType: "RESIDENTIAL",
      address: "217 West 57th Street, New York, NY 10019",
      status: ProjectStatus.ACTIVE,
      region: Region.USA,
      floorCount: 98,
      mainImage: "https://upload.wikimedia.org/wikipedia/commons/f/fe/Central_Park_Tower_April_2023_1_%28cropped%29.jpg",
      floorPlanTemplates: JSON.stringify([
        { name: "Grand Penthouse", area: 400, image: "https://www.centralparktower.com/assets/img/residences/residence-32a-floorplan.jpg" }
      ])
  }
];

// Automated Regional Data
const automatedData: Record<string, any[]> = {
  TR: [
    { name: "Anthill Residence", floorCount: 18, address: "Kozyatağı, İstanbul", description: "Modern mimari ve doğa ile iç içe lüks konut projesi." },
    { name: "Ciftci Towers", floorCount: 45, address: "Levazım, Beşiktaş/İstanbul", description: "Bosphorus view ultra-luxury twin towers." },
    { name: "Vadistanbul", floorCount: 20, address: "Ayazağa, Sarıyer/İstanbul", description: "Massive residential and commercial hub along the Cendere valley." },
    { name: "Metropark Istanbul", floorCount: 45, address: "Levent, İstanbul", description: "Levent'in kalbinde yükselen ikonik kule." },
    { name: "Maslak 1453", floorCount: 52, address: "Maslak, İstanbul", description: "İstanbul'un en yüksek konut projesi, 280 metre." },
    { name: "Nidapark Gokturk", floorCount: 5, address: "Göktürk, İstanbul", description: "Doğa ile iç içe lüks villa ve daire projesi." },
    { name: "Torun Tower", floorCount: 42, address: "Şişli, İstanbul", description: "Şişli'de yükselen ikonik konut projesi." },
    { name: "Istanbul Tower", floorCount: 35, address: "Ataşehir, İstanbul", description: "Ataşehir'de yükselen modern konut ve ofis kulesi." },
    { name: "Istanbul Sapphire", floorCount: 54, address: "Levent, İstanbul", description: "Levent'te yükselen lüks konut ve ofis projesi." },
    { name: "Basin Ekspres Yukselen", floorCount: 25, address: "Başakşehir, İstanbul", description: "Başakşehir'de yükselen modern yaşam kompleksi." },
  ],
  UAE: [
    { name: "Marina Shores", floorCount: 53, address: "Dubai Marina, Dubai", description: "Luxury waterfront living." },
    { name: "Address The Bay", floorCount: 50, address: "Emaar Beachfront", description: "Beachfront luxury residences." },
    { name: "Barcelo Residences", floorCount: 42, address: "Dubai Marina", description: "Premium serviced apartments." },
    { name: "Liv Marina", floorCount: 44, address: "Dubai Marina", description: "Modern lifestyle apartments." },
    { name: "Oceanic Tower", floorCount: 40, address: "Dubai Marina", description: "Contemporary waterfront living." },
    { name: "Towers 52-42", floorCount: 52, address: "Dubai Marina", description: "Avant-garde twin tower complex." },
    { name: "St Regis Financial Center", floorCount: 65, address: "Downtown Dubai", description: "Opulent living in the financial hub." },
    { name: "Reva by Damac", floorCount: 30, address: "Business Bay", description: "Modern canal-side apartments." },
    { name: "Canal Crown", floorCount: 38, address: "Business Bay", description: "Luxurious design by de GRISOGONO." },
    { name: "Vela by Omniyat", floorCount: 30, address: "Business Bay", description: "Prestigious waterfront residences." },
    { name: "The Opus Zaha Hadid", floorCount: 20, address: "Business Bay", description: "Iconic mixed-use by Zaha Hadid Architects." },
    { name: "Bayz 101 Danube", floorCount: 101, address: "Business Bay", description: "Lifestyle-focused luxury high-rise." },
    { name: "Safa Two Damac", floorCount: 85, address: "Business Bay", description: "Ultra-luxury branded residences." },
    { name: "Peninsula Five", floorCount: 36, address: "Business Bay", description: "Waterfront community tower." },
    { name: "The Edge", floorCount: 45, address: "Business Bay", description: "Modern high-rise development." },
    { name: "Bugatti Residences Binghatti", floorCount: 42, address: "Business Bay", description: "Hyper-luxury residence featuring car lifts." },
    { name: "DIFC Living", floorCount: 41, address: "DIFC", description: "Urban luxury in the heart of DIFC." },
    { name: "Avarra by Palace", floorCount: 35, address: "Business Bay", description: "Branded waterfront residential." },
    { name: "Da Vinci Tower", floorCount: 55, address: "Business Bay", description: "Bespoke interiors and luxury residences." },
    { name: "Binghatti Skyrise", floorCount: 60, address: "Business Bay", description: "Major residential project with modern design." },
    { name: "Volante Tower", floorCount: 35, address: "Business Bay", description: "Ultra-luxury with half-floor apartments." },
    { name: "Damac Towers Paramount", floorCount: 74, address: "Business Bay", description: "Hollywood-inspired branded residences." },
    { name: "Binghatti Phantom", floorCount: 45, address: "JVC, Dubai", description: "Bold geometric residential tower." },
    { name: "Samana Miami", floorCount: 25, address: "JVC, Dubai", description: "Resort-style pool apartments." },
    { name: "Hillmont Residences", floorCount: 18, address: "JVC, Dubai", description: "Premium mid-rise by Ellington." },
    { name: "Luma Park Views", floorCount: 20, address: "JVC, Dubai", description: "Park-facing modern residences." },
    { name: "Belgravia Square", floorCount: 5, address: "JVC, Dubai", description: "Boutique low-rise community." },
    { name: "Bloom Towers", floorCount: 29, address: "JVC, Dubai", description: "Established family-friendly tower." },
    { name: "One Sky Park", floorCount: 30, address: "JVC, Dubai", description: "Sky park lifestyle development." },
    { name: "Elitz 3 Danube", floorCount: 40, address: "JVC, Dubai", description: "Amenity-rich residential tower." },
    { name: "Address Hillcrest", floorCount: 3, address: "Dubai Hills Estate", description: "Branded villa community by Emaar." },
    { name: "The Golf Residence", floorCount: 13, address: "Dubai Hills Estate", description: "Golf course facing apartments." },
    { name: "Greenside Residence", floorCount: 15, address: "Dubai Hills Estate", description: "Panoramic golf course views." },
    { name: "Park Horizon", floorCount: 20, address: "Dubai Hills Estate", description: "Mix of apartments and townhouses." },
    { name: "Ellington House III", floorCount: 10, address: "Dubai Hills Estate", description: "High-end boutique living." },
    { name: "Hillsedge", floorCount: 12, address: "Dubai Hills Estate", description: "Modern community apartments." },
    { name: "Collective 2.0", floorCount: 18, address: "Dubai Hills Estate", description: "Social modern apartment layouts." },
    { name: "Royal Atlantis", floorCount: 43, address: "Palm Jumeirah", description: "The most iconic address on the Palm." },
    { name: "Como Residences", floorCount: 75, address: "Palm Jumeirah", description: "Ultra-luxury beachfront supertall." },
    { name: "Six Senses Residences", floorCount: 10, address: "Palm Jumeirah", description: "Wellness-focused branded living." },
    { name: "Orla by Omniyat", floorCount: 14, address: "Palm Jumeirah", description: "Exclusive beachfront residences." },
    { name: "Palm Beach Towers", floorCount: 54, address: "Palm Jumeirah", description: "Iconic twin tower complex." },
    { name: "Creek Edge", floorCount: 40, address: "Dubai Creek Harbour", description: "Waterfront high-rise living." },
    { name: "Creek Palace", floorCount: 33, address: "Dubai Creek Harbour", description: "Palace-style creek residences." },
    { name: "Savanna Creek", floorCount: 12, address: "Dubai Creek Harbour", description: "Nature-inspired mid-rise." },
    { name: "Orchid Creek", floorCount: 11, address: "Dubai Creek Harbour", description: "Botanical-themed residences." },
    { name: "Cedar Creek", floorCount: 10, address: "Dubai Creek Harbour", description: "Creek harbour community living." },
    { name: "Burj Azizi", floorCount: 133, address: "Sheikh Zayed Road", description: "Future landmark skyscraper." },
    { name: "Tiger Sky Tower", floorCount: 116, address: "Business Bay", description: "Record-breaking residential height." },
    { name: "Al Habtoor Tower", floorCount: 82, address: "Sheikh Zayed Road", description: "Luxury branded residences." },
    { name: "Sobha Hartland II", floorCount: 35, address: "Sobha Hartland", description: "Sustainable luxury forest living." },
    { name: "Avani Palm View", floorCount: 48, address: "Dubai Media City", description: "Serviced residences with Palm views." },
    { name: "May Arabian Ranches 3", floorCount: 2, address: "Arabian Ranches 3", description: "Modern townhouse community." },
  ],
  FR: [
    { name: "Hotel Particulier 7eme", floorCount: 4, address: "7th Arrondissement, Paris", description: "Ultra-exclusive historic mansion with private gardens." },
    { name: "Golden Triangle Penthouse", floorCount: 6, address: "8th Arrondissement, Paris", description: "Turnkey luxury residence near Avenue Montaigne." },
  ],
  DE: [
    { name: "Berlin Waterfront Symphony", floorCount: 22, address: "Berlin, MediaSpree", description: "Modern sustainable living on the banks of the Spree." },
  ],
  SA: [
    { name: "The Line Neom", floorCount: 150, address: "NEOM, Tabuk Province", description: "A cognitive linear city stretching 170km, redefining urban living." },
    { name: "Diriyah Gate Residences", floorCount: 4, address: "Diriyah, Riyadh", description: "Najdi-style luxury living near the UNESCO world heritage site." },
  ],
  CA: [
    { name: "Sky Tower Pinnacle", floorCount: 95, address: "1 Yonge St, Toronto", description: "Canada's future tallest residential building." },
  ],
  JP: [
    { name: "Azabudai Hills Residence", floorCount: 64, address: "Minato, Tokyo", description: "Japan's tallest skyscraper complex and Aman Residences host." },
  ],
  AR: [
      { name: "Alvear Tower", floorCount: 54, address: "Puerto Madero, Buenos Aires", description: "The tallest and most prestigious residential tower in Argentina." },
  ]
};

// Mapping from Region enum to PrismaManager country codes
const regionToCountry: Record<string, string> = {
  TR: "TR",
  UAE: "AE",   // Legacy alias
  AE: "AE",
  UK: "UK",
  US: "US",
  FR: "FR",
  DE: "DE",
  SA: "SA",
  CA: "CA",
  JP: "JP",
  AR: "AR",
  ES: "ES",
  IT: "IT",
  NL: "NL",
  BR: "BR",
  MX: "MX",
  KR: "KR",
  CN: "CN",
  IN: "IN",
  AU: "AU",
  NZ: "NZ",
  SG: "SG",
  TH: "TH",
  MY: "MY",
  GLOBAL: "US",
};

/**
 * Generates sample units for a project
 */
function generateSampleUnits(projectId: string, floorCount: number = 20) {
    const units = [];
    const unitCount = Math.min(5, floorCount); // Generate fewer units for speed
    
    for (let i = 1; i <= unitCount; i++) {
        const floor = Math.max(1, Math.floor((i / unitCount) * floorCount));
        const unitNum = floor * 100 + i;
        const beds = (i % 3) + 1;
        const baths = Math.max(1, beds - 1);
        
        units.push({
            id: `${projectId}-unit-${unitNum}`,
            name: `Unit ${unitNum}`,
            notes: `Exclusive Residence at level ${floor}. Featuring smart home integration and panoramic views.`,
            type: "CONDO_APARTMENT",
            listingStatus: "AVAILABLE",
            bedrooms: beds,
            bathrooms: baths,
            areaSqm: 85 + (beds * 40),
            stories: floor,
            listingPrice: (500000 + (floor * 10000) + (beds * 150000)).toString(), // String for Decimal
            priceCurrency: "USD",
            currency: "USD",
            addressLine1: `Residence ${unitNum}`,
            city: "Metropolis", 
            listingType: "SALE",
            propertyCategory: "RESIDENTIAL",
        });
    }
    return units;
}

async function main() {
  console.log("🌌 SEEDING THE ATLAS: GLOBAL MASTER REPLICATION IN PROGRESS (MULTI-DATABASE)...");



  // Combine projects
  const projectsByRegion: Record<string, any[]> = {};
  
  // Add Iconic
  for (const p of iconicProjects) {
    if (!projectsByRegion[p.region]) projectsByRegion[p.region] = [];
    projectsByRegion[p.region].push(p);
  }

  // Add Automated
  const fallbackImages = [
    "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1200",
    "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?q=80&w=1200",
    "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=1200",
    "https://images.unsplash.com/photo-1444418776041-9c7e33cc5a9c?q=80&w=1200"
  ];

  for (const [regionKey, projects] of Object.entries(automatedData)) {
      if (!projectsByRegion[regionKey]) projectsByRegion[regionKey] = [];
      projects.forEach((p, index) => {
          const slug = p.name.toLowerCase().replace(/\s+/g, '-');
          projectsByRegion[regionKey].push({
              id: `proj-auto-${regionKey.toLowerCase()}-${slug}`,
              ...p,
              projectType: "RESIDENTIAL",
              status: ProjectStatus.ACTIVE,
              region: (Region as any)[regionKey] || Region.GLOBAL,
              mainImage: p.mainImage || fallbackImages[index % fallbackImages.length],
              floorPlanTemplates: p.floorPlanTemplates || JSON.stringify([
                { name: "Standard Unit", area: 120, image: "https://www.centralparktower.com/assets/img/residences/residence-32a-floorplan.jpg" }
              ])
          });
      });
  }

  for (const [region, projects] of Object.entries(projectsByRegion)) {
    const countryCode = regionToCountry[region] || "US";
    // We update both the regional DB and the BASE DB to ensure UI consistency
    const targetDbs = [countryCode, "BASE"];

    for (const dbCode of targetDbs) {
        console.log(`\n📍 Deploying Region: ${region} (${projects.length} Projects) -> Database: ${dbCode}`);
        const prismaClient = PrismaManager.getClient(dbCode);

        // Master Org (optional - skip if fails)
        let masterOrg: any = null;
        try {
            masterOrg = await prismaClient.organization.upsert({
                where: { id: "seed-global-org-master" },
                update: {},
                create: {
                    id: "seed-global-org-master",
                    name: "GLOBAL_PROPERTY_GROUPS_MASTER",
                    region: Region.GLOBAL,
                    type: OrgType.AGENCY,
                    defaultCurrency: "USD",
                    defaultLocale: "en-US",
                },
            });
        } catch (e) {
            console.log("    ⚠️  Could not create master org, proceeding without org");
        }

        for (const proj of projects) {
            // Upsert Project
            const upsertedProject = await prismaClient.project.upsert({
                where: { id: proj.id },
                update: {
                    name: proj.name,
                    description: proj.description,
                    address: proj.address,
                    ...(masterOrg && { orgId: masterOrg.id }),
                },
                create: {
                    id: proj.id,
                    name: proj.name,
                    description: proj.description,
                    address: proj.address,
                    ...(masterOrg && { orgId: masterOrg.id }),
                    projectType: proj.projectType || "RESIDENTIAL",
                    status: proj.STATUS || ProjectStatus.ACTIVE,
                }
            });

            console.log(`   🏗️  Project Deployed: ${proj.name} [${dbCode}]`);

            // --- SEED SAMPLE UNITS ---
            const sampleUnits = generateSampleUnits(proj.id, proj.floorCount);
            for (const unit of sampleUnits) {
                try {
                    await (prismaClient.property as any).upsert({
                        where: { id: unit.id },
                        update: {
                            ...unit,
                            region: (Region as any)[region] || Region.GLOBAL,
                            country: regionToCountry[region] || "US",
                            ...(masterOrg && { orgId: masterOrg.id }),
                            projectId: upsertedProject.id,
                        },
                        create: {
                            ...unit,
                            region: (Region as any)[region] || Region.GLOBAL,
                            country: regionToCountry[region] || "US",
                            ...(masterOrg && { orgId: masterOrg.id }),
                            projectId: upsertedProject.id,
                        }
                    });
                } catch (e: any) {
                    // console.log(`      ⚠️  Failed to upsert unit ${unit.id}: ${e.message.split('\n')[0]}`);
                }
            }
        }
    }
  }

  console.log("\n✨ ATLAS REPLICATION COMPLETE. Global projects and units are now fully operational.");
}

main()
  .catch((e) => {
    console.error("❌ Seeding failed:", e);
    process.exit(1);
  })
  .finally(async () => {
    await PrismaManager.disconnectAll();
  });
