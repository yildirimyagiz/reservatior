import { PrismaClient, Region } from "@prisma/client";

const prisma = new PrismaClient();

interface SeedProject {
  name: string;
  floorCount?: number;
  address: string;
  description: string;
  floorPlanTemplates?: any;
}

const automatedData: Record<string, SeedProject[]> = {
  TR: [
    { name: "Zorlu Center Residence", floorCount: 32, address: "Levazım, Koru Sokağı No:2, 34340 Beşiktaş/İstanbul", description: "Istanbul's premier mixed-use landmark with luxury shopping and residences.", floorPlanTemplates: { "Executive": "https://example.com/tr-zorlu-ex.png" } },
    { name: "Ciftci Towers", floorCount: 45, address: "Levazım, Beşiktaş/İstanbul", description: "Bosphorus view ultra-luxury twin towers." },
    { name: "Vadistanbul", floorCount: 20, address: "Ayazağa, Sarıyer/İstanbul", description: "Massive residential and commercial hub along the Cendere valley." },
  ],
  UAE: [
    { name: "Burj Khalifa Residences", floorCount: 163, address: "Downtown Dubai", description: "The world's tallest building, offering unparalleled luxury living." },
    { name: "Bugatti Residences Binghatti", floorCount: 42, address: "Business Bay, Dubai", description: "Hyper-luxury residence featuring car lifts into private penthouses." },
    { name: "Muraba Veil", floorCount: 73, address: "Dubai Water Canal", description: "Architectural masterpiece by RCR Arquitectes." },
  ],
  UK: [
    { name: "Battersea Power Station", floorCount: 18, address: "Battersea, London SW11", description: "Iconic industrial landmark converted into premium residences and retail." },
    { name: "One Undershaft", floorCount: 73, address: "City of London", description: "London's upcoming tallest residential and commercial tower." },
  ],
  USA: [
    { name: "Hudson Yards 30", floorCount: 103, address: "New York, NY 10001", description: "New York's largest mixed-use site and cultural hub." },
    { name: "One Domino Square", floorCount: 55, address: "Williamsburg, Brooklyn, NY", description: "Williamsburg's luxury waterfront towers." },
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
    { name: "Oakridge Park", floorCount: 44, address: "Vancouver, BC", description: "Massive mixed-use redevelopment by Westbank." },
  ],
  SG: [
    { name: "Union Square Residences", floorCount: 40, address: "District 1, Singapore", description: "Flagship luxury mixed-use hub in the CBD." },
  ],
  IT: [
    { name: "Citywave Milan", floorCount: 25, address: "CityLife, Milan", description: "Solar-powered waveshaped residential complex." },
    { name: "Olympic Village Porta Romana", floorCount: 12, address: "Milan", description: "Legacy residential district for Milano-Cortina 2026." },
  ],
  JP: [
    { name: "Azabudai Hills Residence", floorCount: 64, address: "Minato, Tokyo", description: "Japan's tallest skyscraper complex and Aman Residences host." },
    { name: "Waldorf Astoria Nihonbashi", floorCount: 52, address: "Chuo, Tokyo", description: "Luxury branded residences in the heart of historic Tokyo." },
  ],
  KR: [
    { name: "Yongsan Intl Business Dist", floorCount: 100, address: "Seoul", description: "The vertical city hub of Seoul's future transformation." },
    { name: "Eunma Gangnam Tower", floorCount: 49, address: "Daechi-dong, Seoul", description: "Iconic Gangnam landmark redevelopment." },
  ],
  AU: [
    { name: "Sydney House", floorCount: 50, address: "Pitt St, Sydney", description: "Luxury skyscraper in Sydney's central business district." },
  ],
  NL: [
    { name: "Zuidasdok Residences", floorCount: 25, address: "Amsterdam South", description: "Integrated urban living in the Netherlands' premier business district." },
  ],
  MX: [
    { name: "Reforma 222", floorCount: 31, address: "Mexico City", description: "Paseo de la Reforma flagship mixed-use project." },
  ],
  BR: [
    { name: "Reserva Raposo", floorCount: 28, address: "Sao Paulo", description: "A city within a city, one of the world's largest housing developments." },
    { name: "Porto Maravilha", floorCount: 38, address: "Rio de Janeiro", description: "Waterfront revitalisation landmark." },
  ],
  IN: [
    { name: "Lodha Altus", floorCount: 60, address: "Mumbai", description: "Ultra-luxury residential tower in India's financial capital." },
    { name: "Prestige Southern Star", floorCount: 30, address: "Bangalore", description: "Massive integrated township in India's tech hub." },
  ],
  CN: [
    { name: "Deep Water Pavilia", floorCount: 12, address: "Hong Kong South", description: "Ultra-luxury nature-integrated residence in Hong Kong." },
    { name: "One Central Park Sh", floorCount: 45, address: "Shanghai", description: "Modern luxury living in Xintiandi district." },
  ],
  TH: [
    { name: "Intercontinental Asoke", floorCount: 35, address: "Bangkok", description: "Branded luxury living in the heart of Sukhumvit." },
  ],
  MY: [
    { name: "Merdeka 118 Residences", floorCount: 118, address: "Kuala Lumpur", description: "Residences in the world's second tallest tower." },
  ],
  AR: [
    { name: "L'Avenue Libertador", floorCount: 36, address: "Palermo, Buenos Aires", description: "Zaha Hadid's masterpiece overlooking the Polo Field." },
    { name: "Alvear Tower", floorCount: 54, address: "Puerto Madero, Buenos Aires", description: "The tallest and most prestigious residential tower in Argentina." },
  ]
};

async function main() {
  console.log("🌍 GLOBAL MASTER PROJECT ATLAS COOLDOWN: INITIALIZING ALL REGIONS...");

  // Master Global Org
  const masterOrg = await prisma.organization.upsert({
    where: { id: "seed-global-org-master" },
    update: {},
    create: {
      id: "seed-global-org-master",
      name: "GLOBAL_PROPERTY_GROUPS_MASTER",
      region: Region.GLOBAL,
      type: "AGENCY",
    }
  });

  for (const [region, projects] of Object.entries(automatedData)) {
    console.log(`\n📍 Seeding Region: ${region} (${projects.length} Projects)`);
    
    // Check if regional org exists for this region
    let regionalOrg = await prisma.organization.findFirst({
        where: { region: region as any }
    });

    if (!regionalOrg && region !== 'GLOBAL') {
        // Create a temporary master org for that region if it doesn't exist
        regionalOrg = await prisma.organization.create({
            data: {
                id: `org-master-${region.toLowerCase()}`,
                name: `MASTER_ORG_${region}`,
                region: region as any,
                type: "AGENCY",
            }
        });
    }

    const orgId = regionalOrg?.id || masterOrg.id;

    for (const proj of projects) {
        const slug = proj.name.toLowerCase().replace(/_/g, '-');
        const id = `proj-auto-${region.toLowerCase()}-${slug}`;
        
        await (prisma.project as any).upsert({
            where: { id },
            update: {
                name: proj.name,
                address: proj.address,
                description: proj.description,
                floorCount: proj.floorCount,
                floorPlanTemplates: proj.floorPlanTemplates,
                orgId: orgId,
            },
            create: {
                id,
                name: proj.name,
                address: proj.address,
                description: proj.description,
                floorCount: proj.floorCount,
                floorPlanTemplates: proj.floorPlanTemplates,
                orgId: orgId,
                projectType: "RESIDENTIAL",
                status: "ACTIVE",
            }
        });
        console.log(`   ✅ [${region}] ${proj.name}`);
    }
  }

  console.log("\n✨ ATLAS REPLICATION COMPLETE: World-class real estate portfolio deployed across all regions.");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
