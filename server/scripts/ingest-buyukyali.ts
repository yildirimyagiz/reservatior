import prismaManager from "../src/lib/prisma";
import fs from "node:fs";
import path from "node:path";

const prisma = prismaManager.getClient("TR");
const DIRECTORY = "/Users/os2026/Documents/buyukyali_2019";

async function main() {
  console.log("Büyükyalı data ingestion started...");

  if (!fs.existsSync(DIRECTORY)) {
    console.error("Directory does not exist:", DIRECTORY);
    return;
  }

  // Create organization if not exists
  const org = await prisma.organization.upsert({
    where: { id: "org_buyukyali" },
    update: {},
    create: {
      id: "org_buyukyali",
      name: "Büyükyalı Yönetimi",
      type: "AGENCY",
      region: "TR",
      defaultCurrency: "TRY",
      defaultLocale: "tr-TR",
    },
  });

  // Create project
  const project = await prisma.project.upsert({
    where: { id: "proj_buyukyali" },
    update: {},
    create: {
      id: "proj_buyukyali",
      orgId: org.id,
      name: "Büyükyalı İstanbul",
      description: "Zeytinburnu / İstanbul lüks konut projesi",
      projectType: "RESIDENTIAL",
      status: "COMPLETED",
      address: "Zeytinburnu, İstanbul",
      currency: "TRY"
    }
  });

  console.log("Created project:", project.id);

  const files = fs.readdirSync(DIRECTORY);
  const pdfFiles = files.filter((f: string) => f.toLowerCase().endsWith(".pdf"));
  
  const propertiesAdded = new Set<string>();

  for (const file of pdfFiles) {
    let cleanName = file.replace(/\.pdf$/i, "").trim();
    cleanName = cleanName.replace(/\s*\(\d+\)$/, "").trim();
    cleanName = cleanName.replace(/sözleşme/i, "").replace(/szleme/i, "").trim();
    cleanName = cleanName.replace(/ofis/i, "").trim();
    
    // Find the block-unit pattern, e.g., A1-13, B3-17, E-6, D2-53, or F101
    const match = cleanName.match(/([A-Z]\d?-?\d+)/i);
    let blockUnit = "";
    let ownerName = cleanName;
    
    if (match) {
      blockUnit = match[1].toUpperCase();
      ownerName = cleanName.replace(match[1], "").replace(/\s+/g, " ").trim();
      // Remove trailing hyphens or extra spaces
      ownerName = ownerName.replace(/^-|-$/g, "").trim();
    } else {
      continue; // Skip if no block-unit found
    }

    const uniqueKey = `${ownerName}_${blockUnit}`;
    if (propertiesAdded.has(uniqueKey)) {
      continue;
    }
    propertiesAdded.add(uniqueKey);

    // Create or find Contact (Owner)
    const contactId = `contact_buyukyali_${ownerName.replace(/[^A-Z0-9]/ig, "")}`;
    const contact = await prisma.contact.upsert({
      where: { id: contactId },
      update: {},
      create: {
        id: contactId,
        orgId: org.id,
        type: "OWNER_CONTACT",
        fullName: ownerName || "Bilinmeyen",
        email: `${ownerName.replace(/[^A-Z0-9]/ig, "").toLowerCase()}@example.com`,
      }
    });

    // Extract block and unit from blockUnit, e.g. "D1-38", "F101"
    let block = "";
    let unit = "";
    const splitIndex = blockUnit.indexOf("-");
    if (splitIndex > -1) {
      block = blockUnit.substring(0, splitIndex);
      unit = blockUnit.substring(splitIndex + 1);
    } else {
      const match2 = blockUnit.match(/^([A-Z]\d?)(\d+)$/);
      if (match2) {
        block = match2[1];
        unit = match2[2];
      } else {
        unit = blockUnit;
        block = "A";
      }
    }

    const propId = `buyukyali_${block}_${unit}`;

    const property = await prisma.property.upsert({
      where: { id: propId },
      update: {},
      create: {
        id: propId,
        orgId: org.id,
        name: `Büyükyalı Blok ${block} Daire ${unit}`,
        type: "APARTMENT",
        propertyCategory: "RESIDENTIAL",
        listingType: "SALE",
        listingStatus: "AVAILABLE",
        region: "TR",
        currency: "TRY",
        addressLine1: "Büyükyalı İstanbul",
        city: "İstanbul",
        country: "TR",
        zip: "34020",
        notes: `Sahibi: ${ownerName}`, // Fallback for owner info
      }
    });

    // Also create Document entry
    await prisma.document.create({
      data: {
        orgId: org.id,
        propertyId: property.id,
        title: `${ownerName} - Blok ${block} Daire ${unit} Sözleşme`,
        documentType: "PURCHASE_AGREEMENT",
        fileUrl: path.join(DIRECTORY, file),
        fileName: file,
        fileSize: 0,
        mimeType: "application/pdf",
        checksum: "placeholder"
      }
    });

  }

  console.log(`Successfully ingested ${propertiesAdded.size} properties from Büyükyalı.`);
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
