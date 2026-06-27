import prismaManager from "../lib/prisma";
import * as fs from "node:fs";
import * as path from "node:path";
import { parse } from "csv-parse/sync";

// Hedef klasör (USA için organize edilmiş datalar)
const USA_DIR = "/Users/os2026/Downloads/Reservatior/datalar/airbnb/usa";

// ABD Eyalet / Şehir Geocoding hataları için fallback region
const REGION = "US";
const ORG_ID = "org_airbnb_us";

/** 
 * Yardımcı Fonksiyon: CSV'deki tüm dosyaları bul 
 */
function findCsvFiles(dir: string, fileList: string[] = []): string[] {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findCsvFiles(filePath, fileList);
    } else if (filePath.endsWith(".csv")) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

/** 
 * Organizasyonu güvenceye al (Airbnb US) 
 */
async function upsertOrganization(prisma: any) {
  return prisma.organization.upsert({
    where: { id: ORG_ID },
    update: {},
    create: {
      id: ORG_ID,
      name: "Airbnb – United States",
      type: "AGENCY",
      region: "USA",
      defaultCurrency: "USD",
      defaultLocale: "en-US",
    },
  });
}

/**
 * Adres ve lokasyon verisini upsert et
 */
async function upsertLocation(prisma: any, propertyId: string, row: any) {
  const lat = parseFloat(row.latitude) || 0;
  const lng = parseFloat(row.longitude) || 0;
  const city = row.neighbourhood_cleansed || row.city || "Unknown City";
  const stateName = row.state || "WA"; // Default WA for demonstration, but should come from path/row
  
  const locId = `loc_airbnb_${propertyId}`;

  return prisma.location.upsert({
    where: { id: locId },
    update: {
      latitude: lat,
      longitude: lng,
    },
    create: {
      id: locId,
      orgId: ORG_ID,
      addressLine1: row.street || `${city} Area`,
      city: city,
      stateName: stateName,
      country: "US",
      latitude: lat,
      longitude: lng,
    },
  });
}

/**
 * Contact Modeli: Posta yolu ile ulaşabilmek için mülk sahibi/host'u kaydet
 */
async function upsertOwnerContact(prisma: any, propertyId: string, row: any) {
  const hostId = row.host_id || `unknown_host_${propertyId}`;
  const hostName = row.host_name || "Unknown Host";
  const contactId = `contact_airbnb_${hostId}`;

  return prisma.contact.upsert({
    where: { id: contactId },
    update: {},
    create: {
      id: contactId,
      orgId: ORG_ID,
      type: "OWNER_CONTACT", // Mülk sahibi potansiyel bir müşteri
      fullName: hostName,
      // Gelecekte TaxRecord'dan adres, e-posta, telefon bulunursa buraya eklenecek
      notes: "Airbnb üzerinden çekildi. King County vergi kayıtları üzerinden posta adresi ve direkt iletişim bilgileri hedeflenmektedir.",
    },
  });
}

/**
 * Property modelini upsert et
 */
async function upsertProperty(prisma: any, propertyId: string, row: any, locationId: string) {
  const name = row.name || `Property ${propertyId}`;
  const bedrooms = parseInt(row.bedrooms) || 0;
  const bathrooms = parseFloat(row.bathrooms) || 0;
  
  // Fiyat ayrıştırma
  let rawPrice = row.price || "0";
  rawPrice = rawPrice.replace(/[^0-9.]/g, "");
  const price = parseFloat(rawPrice) || 0;

  return prisma.property.upsert({
    where: { id: propertyId },
    update: {
      listingPrice: price,
    },
    create: {
      id: propertyId,
      orgId: ORG_ID,
      name,
      type: "APARTMENT", 
      propertyCategory: "RESIDENTIAL",
      listingType: "RENT",
      listingStatus: "AVAILABLE",
      region: "USA",
      currency: "USD",
      addressLine1: "",
      city: row.neighbourhood_cleansed || "",
      country: "US",
      bedrooms,
      bathrooms,
      locationId: locationId,
      listingPrice: price,
      notes: "Room type: " + (row.room_type || ""),
    },
  });
}

/**
 * USPublicTaxRecord (Gelecekte Tax ID ile güncellenmek üzere stub/placeholder at)
 */
async function upsertTaxRecordPlaceholder(prisma: any, propertyId: string, contactId: string) {
  // parcelNumber Airbnb'de direkt yok. Geocoding API (örn. King County GIS) ile 
  // lat/lng üzerinden daha sonra doldurulacak bir yer tutucu atıyoruz.
  const taxRecordId = `tax_placeholder_${propertyId}`;
  const parcelNumber = `PENDING_${propertyId}`; // Daha sonra batch job ile King County'den çekilecek
  
  // TaxRecord
  await prisma.uSPublicTaxRecord.upsert({
    where: {
      parcelNumber_taxYear: {
        parcelNumber: parcelNumber,
        taxYear: new Date().getFullYear(),
      }
    },
    update: {},
    create: {
      id: taxRecordId,
      orgId: ORG_ID,
      propertyId: propertyId,
      parcelNumber: parcelNumber,
      taxYear: new Date().getFullYear(),
      taxStatus: "PENDING_SYNC",
      countyName: "King", // Hedef: King County (Seattle)
      stateName: "WA",
    }
  });

  // Assessment Modeli (İlgili mülkün vergi değerlendirme raporları için placeholder)
  await prisma.uSPropertyAssessment.upsert({
    where: {
      parcelNumber_assessmentYear: {
        parcelNumber: parcelNumber,
        assessmentYear: new Date().getFullYear(),
      }
    },
    update: {},
    create: {
      orgId: ORG_ID,
      propertyId: propertyId,
      parcelNumber: parcelNumber,
      assessmentYear: new Date().getFullYear(),
      countyName: "King",
      stateName: "WA",
    }
  });
}

async function processCsvFile(prisma: any, filePath: string) {
  const raw = fs.readFileSync(filePath, "utf8");
  const rows: any[] = parse(raw, { columns: true, skip_empty_lines: true });

  for (const row of rows) {
    const airbnbId = row.id?.toString();
    if (!airbnbId) continue;

    const propertyId = `airbnb_us_${airbnbId}`;
    
    try {
      // 1. Lokasyon
      const loc = await upsertLocation(prisma, propertyId, row);
      
      // 2. Mülk Sahibi İletişim Profili (Gelecekte posta atılacak)
      const contact = await upsertOwnerContact(prisma, propertyId, row);

      // 3. Mülk
      await upsertProperty(prisma, propertyId, row, loc.id);

      // 4. Emlak Vergisi ve King County bağlantı noktası
      await upsertTaxRecordPlaceholder(prisma, propertyId, contact.id);

    } catch (err) {
      console.error(`Error processing listing ${airbnbId}:`, err);
    }
  }
}

async function main() {
  console.log("🇺🇸 Başlıyor: USA Airbnb Datası Ingestion ve King County Tax Hazırlığı...");
  
  const prisma = prismaManager.getClient(REGION);
  await upsertOrganization(prisma);

  const csvFiles = findCsvFiles(USA_DIR);
  console.log(`Bulunan CSV Dosyası: ${csvFiles.length}`);

  for (const file of csvFiles) {
    console.log(`📄 İşleniyor: ${file.split("/").pop()}`);
    await processCsvFile(prisma, file);
  }

  console.log("✅ Tüm USA Airbnb mülkleri sisteme aktarıldı, vergi kayıt eşleştirme mekanizması kuruldu.");
}

main().catch(console.error).finally(() => process.exit(0));
