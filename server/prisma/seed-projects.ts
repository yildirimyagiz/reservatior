import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // We'll try to find a TR org or any org
  const org = await prisma.organization.findFirst({
    where: { region: "TR" }
  }) || await prisma.organization.findFirst();

  if (!org) {
    console.error("❌ No organization found to link projects.");
    return;
  }

  const user = await prisma.user.findFirst() || { id: "0" };

  const projects = [
    {
      id: "project-tr-001",
      name: "Skyline Residences TR",
      description: "Smart-integrated residential complex in the heart of Istanbul. Features AI-managed climate nodes and holographic security layers.",
      projectType: "RESIDENTIAL",
      address: "İstiklal Caddesi No:10, Beyoğlu, İstanbul",
      status: "ACTIVE",
      budget: 15000000,
      currency: "USD",
      managerId: user.id,
    },
    {
      id: "project-tr-002",
      name: "Bodrum Modular Villas",
      description: "Next-gen modular vacation homes with quick-deploy structural units and solar-glass surfaces.",
      projectType: "RESIDENTIAL",
      address: "Yalıkavak, Bodrum, Muğla",
      status: "PLANNING",
      budget: 5000000,
      currency: "USD",
      managerId: user.id,
    },
    {
      id: "project-tr-003",
      name: "Anatolia Commercial Hub",
      description: "State-of-the-art commercial node for high-frequency startups and smart data centers.",
      projectType: "COMMERCIAL",
      address: "Çankaya, Ankara",
      status: "ACTIVE",
      budget: 25000000,
      currency: "USD",
      managerId: user.id,
    }
  ];

  for (const proj of projects) {
    await prisma.project.upsert({
      where: { id: proj.id },
      update: proj,
      create: {
        ...proj,
        orgId: org.id,
      }
    });
  }

  console.log(`✅ Seeded ${projects.length} real estate projects for ${org.name}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
