import prismaManager from "../lib/prisma";
import * as fs from "node:fs";
import * as path from "node:path";
import { parse } from "csv-parse/sync"; // npm i -D csv-parse
import { v4 as uuidv4 } from "uuid"; // npm i -D uuid

// Root folder containing all country sub‑folders (germany, france, etc.)
const AIRBNB_ROOT = "/Users/os2026/Downloads/Reservatior/datalar/airbnb";

/** Mapping from Airbnb "country" field (or folder name) to our Prisma region code */
const COUNTRY_TO_REGION: Record<string, string> = {
  Germany: "DE",
  France: "FR",
  Netherlands: "NL",
  "United Kingdom": "UK",
  United_States: "US",
  Canada: "CA",
  Turkey: "TR",
  // add more as needed
};

/** Returns the Prisma client for the given region (fallback to TR) */
function getPrismaForRegion(region: string) {
  return prismaManager.getClient(region as any) || prismaManager.getClient("TR");
}

/** Upserts an Organization per country (e.g., "Airbnb – Germany") */
async function upsertOrganization(prisma: any, region: string) {
  const orgId = `org_airbnb_${region.toLowerCase()}`;
  const name = `Airbnb – ${region}`;
  return prisma.organization.upsert({
    where: { id: orgId },
    update: {},
    create: {
      id: orgId,
      name,
      type: "AGENCY",
      region,
      defaultCurrency: region === "DE" ? "EUR" : "USD",
      defaultLocale: region === "DE" ? "de-DE" : "en-US",
    },
  });
}

/** Upserts a host (Contact) */
async function upsertContact(prisma: any, orgId: string, hostId: string, hostName: string) {
  const contactId = `contact_airbnb_${hostId}`;
  return prisma.contact.upsert({
    where: { id: contactId },
    update: { fullName: hostName },
    create: {
      id: contactId,
      orgId,
      type: "OWNER_CONTACT",
      fullName: hostName,
      email: `${hostId}@airbnb.com`,
    },
  });
}

/** Upserts a Location */
async function upsertLocation(prisma: any, orgId: string, propId: string, listing: any) {
  const city = listing.city?.trim() ?? "";
  const latitude = parseFloat(listing.latitude) || 0;
  const longitude = parseFloat(listing.longitude) || 0;
  const country = (listing.country ?? listing.country_code ?? "TR").trim();
  const addressLine1 = city;
  return prisma.location.upsert({
    where: { id: `loc_${propId}` },
    update: { addressLine1, city, country, latitude, longitude },
    create: {
      id: `loc_${propId}`,
      orgId,
      addressLine1,
      city,
      country,
      latitude,
      longitude,
    },
  });
}

/** Upserts a Property (listing) */
async function upsertProperty(
  prisma: any,
  orgId: string,
  contactId: string,
  listing: any,
  region: string
) {
  const propId = `airbnb_${listing.id}`;
  const price = parseFloat(listing.price) || 0;
  const title = listing.name?.trim() ?? "Untitled Listing";
  const roomType = listing.room_type?.trim() ?? "UNKNOWN";

  const location = await upsertLocation(prisma, orgId, propId, listing);

  return prisma.property.upsert({
    where: { id: propId },
    update: {
      name: title,
      type: "APARTMENT",
      propertyCategory: "RESIDENTIAL",
      listingType: "RENT",
      listingStatus: "AVAILABLE",
      region,
      currency: region === "DE" ? "EUR" : "USD",
      addressLine1: listing.city?.trim() ?? "",
      city: listing.city?.trim() ?? "",
      country: region,
      notes: `Room type: ${roomType}`,
      listingPrice: price,
      locationId: location.id,
    },
    create: {
      id: propId,
      orgId,
      name: title,
      type: "APARTMENT",
      propertyCategory: "RESIDENTIAL",
      listingType: "RENT",
      listingStatus: "AVAILABLE",
      region,
      currency: region === "DE" ? "EUR" : "USD",
      addressLine1: listing.city?.trim() ?? "",
      city: listing.city?.trim() ?? "",
      country: region,
      notes: `Room type: ${roomType}`,
      listingPrice: price,
      createdBy: contactId,
      locationId: location.id,
    },
  });
}

/** Optional: store the main picture as a Document */
async function upsertDocument(
  prisma: any,
  orgId: string,
  propertyId: string,
  imageUrl: string | undefined,
  title: string
) {
  if (!imageUrl) return;
  await prisma.document.upsert({
    where: { id: `doc_airbnb_${propertyId}` },
    update: { fileUrl: imageUrl },
    create: {
      id: `doc_airbnb_${propertyId}`,
      orgId,
      propertyId,
      title: `${title} – Fotoğraf`,
      documentType: "CERTIFICATE",

      fileUrl: imageUrl,
      mimeType: "image/jpeg",
      fileSize: 0,
      checksum: "placeholder",
      fileName: title,
    },
  });
}

async function processCsvFile(filePath: string) {
  const raw = fs.readFileSync(filePath, "utf8");
  const rows: any[] = parse(raw, { columns: true, skip_empty_lines: true });

  for (const row of rows) {
    const countryRaw = (row.country ?? row.country_code ?? "").trim();
    const region = COUNTRY_TO_REGION[countryRaw] || "TR"; // default fallback
    const prisma = getPrismaForRegion(region);
    const org = await upsertOrganization(prisma, region);

    const hostId = row.host_id?.trim();
    const hostName = row.host_name?.trim() ?? "Airbnb Host";
    if (!hostId) continue; // sanity

    const contact = await upsertContact(prisma, org.id, hostId, hostName);
    const property = await upsertProperty(prisma, org.id, contact.id, row, region);
    await upsertDocument(prisma, org.id, property.id, row.picture_url?.trim(), row.name?.trim());
  }
}

async function run() {
  console.log("🔎 Starting multi‑country Airbnb ingestion …");
  const subfolders = fs.readdirSync(AIRBNB_ROOT, { withFileTypes: true })
    .filter((d) => d.isDirectory())
    .map((d) => d.name);

  // Also include CSV files directly under the root folder
  const rootFiles = fs.readdirSync(AIRBNB_ROOT).filter((f) => f.endsWith('.csv'));

  // Walk through each country folder (if exists) and its CSVs
  for (const folder of subfolders) {
    const folderPath = path.join(AIRBNB_ROOT, folder);
    const csvFiles = fs.readdirSync(folderPath).filter((f) => f.endsWith('.csv'));
    for (const csv of csvFiles) {
      console.log(`📄 Processing ${folder}/${csv}`);
      await processCsvFile(path.join(folderPath, csv));
    }
  }

  // Process CSVs that sit directly under the root (no sub‑folder)
  for (const csv of rootFiles) {
    console.log(`📄 Processing root ${csv}`);
    await processCsvFile(path.join(AIRBNB_ROOT, csv));
  }

  console.log("✅ All Airbnb CSVs have been ingested.");
}

run()
  .catch(console.error)
  .finally(() => {
    // Disconnect all Prisma clients used (they are singleton per region)
    // Since PrismaManager does not expose its client map, we simply rely on process exit to close connections.
  });
