import { prismaManager } from "../src/lib/prisma";
import fs from "node:fs";
import path from "node:path";
import { PropertyType, ListingStatus, ListingType, PropertyCategory } from "@prisma/client";

// Normalize Country Names for database connection
const COUNTRY_MAP: Record<string, string> = {
  "TURKİYE": "TR",
  "TURKIYE": "TR",
  "TÜRKİYE": "TR",
  "BAE": "AE",
  "DUBAI": "AE",
  "DUBAİ": "AE",
};

// Normalize Region enum values
const REGION_ENUM_MAP: Record<string, string> = {
  "TR": "TR",
  "AE": "UAE",
};

// Simple helper to parse prices like "5.350.000 ₺", "190.000$", "300.000 USD civarı"
function parseNumericPrice(priceStr: string): number | null {
  if (!priceStr || priceStr.toLowerCase().includes("bilinmiyor") || priceStr.toLowerCase().includes("güncellendi")) {
    return null;
  }
  
  // Extract digits
  const cleanStr = priceStr.replace(/\./g, "").replace(/,/g, "");
  const match = cleanStr.match(/\d+/);
  if (match) {
    return parseInt(match[0], 10);
  }
  return null;
}

// Detect currency symbol/code
function detectCurrency(priceStr: string, countryCode: string): string {
  const str = priceStr.toUpperCase();
  if (str.includes("USD") || str.includes("$")) return "USD";
  if (str.includes("AED")) return "AED";
  if (str.includes("TL") || str.includes("₺")) return "TRY";
  
  return countryCode === "TR" ? "TRY" : (countryCode === "AE" ? "AED" : "USD");
}

// Parse bedrooms from roomType like "5+2", "3+1", "1+1"
function parseBedrooms(roomType: string): number | null {
  if (!roomType) return null;
  const match = roomType.match(/^(\d+)/);
  if (match) {
    return parseInt(match[1], 10);
  }
  return null;
}

async function importScrapedProperties(dirPath: string) {
  console.log(`🔍 Scanning directory for scraped data: ${dirPath}`);
  const items = fs.readdirSync(dirPath);

  for (const item of items) {
    const fullPath = path.join(dirPath, item);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      // Check if this directory has details.json
      const detailsPath = path.join(fullPath, "details.json");
      if (fs.existsSync(detailsPath)) {
        await processDirectory(fullPath, detailsPath);
      } else {
        // Recurse deeper
        await importScrapedProperties(fullPath);
      }
    }
  }
}

// Normalize Phone Numbers based on country
function normalizePhoneNumber(rawPhone: string, countryCode: string): string {
  let cleaned = rawPhone.replace(/\D/g, '');
  if (countryCode === "TR") {
    if (!cleaned.startsWith('90') && cleaned.length === 10) {
      cleaned = '90' + cleaned;
    } else if (cleaned.startsWith('05')) {
      cleaned = '90' + cleaned.substring(1);
    }
  } else if (countryCode === "AE") {
    if (!cleaned.startsWith('971') && cleaned.length === 9) {
      cleaned = '971' + cleaned;
    } else if (cleaned.startsWith('05')) {
      cleaned = '971' + cleaned.substring(1);
    }
  }
  return cleaned;
}

async function processDirectory(dirPath: string, detailsPath: string) {
  try {
    const detailsRaw = fs.readFileSync(detailsPath, "utf-8");
    const details = JSON.parse(detailsRaw);

    const country = details.country || "TURKİYE";
    const countryCode = COUNTRY_MAP[country.toUpperCase()] || "TR";
    const prisma = prismaManager.getClient(countryCode);

    // Create Organization for WhatsApp imports in this region
    const orgId = `org_whatsapp_${countryCode.toLowerCase()}`;
    const orgName = `WhatsApp Scraped Listings (${countryCode})`;
    
    await prisma.organization.upsert({
      where: { id: orgId },
      update: {},
      create: {
        id: orgId,
        name: orgName,
        type: "AGENCY",
        region: REGION_ENUM_MAP[countryCode] as any,
        defaultCurrency: countryCode === "TR" ? "TRY" : "USD",
      },
    });

    // Handle User & Contact Ingestion
    let userId: string | null = null;
    const contactName = details.contactName || "Bilinmeyen Gönderici";
    const contactPhone = details.contactPhone || "";

    if (contactPhone && contactPhone !== "Bilinmiyor") {
      const normalizedPhone = normalizePhoneNumber(contactPhone, countryCode);

      try {
        // Find existing user by phone
        let user = await prisma.user.findFirst({
          where: { phone: normalizedPhone }
        });

        if (user) {
          // Update name if changed
          user = await prisma.user.update({
            where: { id: user.id },
            data: { name: contactName }
          });
        } else {
          // Generate unique email based on name, fallback to phone
          let email = `${normalizedPhone}@reservatior.com`;

          let cleanName = contactName;
          const charMap: Record<string, string> = {
            'ç': 'c', 'ğ': 'g', 'ı': 'i', 'ö': 'o', 'ş': 's', 'ü': 'u',
            'Ç': 'c', 'Ğ': 'g', 'İ': 'i', 'Ö': 'o', 'Ş': 's', 'Ü': 'u'
          };
          for (const [tr, en] of Object.entries(charMap)) {
            cleanName = cleanName.replaceAll(tr, en);
          }
          cleanName = cleanName
            .toLowerCase()
            .trim()
            .replace(/[^a-z0-9\s]/g, '')
            .replace(/\s+/g, '.');

          if (cleanName && cleanName !== 'bilinmeyen.gonderici' && cleanName !== 'bilinmiyor' && cleanName !== 'bilinmeyen') {
            const baseEmail = `${cleanName}@reservatior.com`;
            // Check email uniqueness
            const emailExists = await prisma.user.findUnique({
              where: { email: baseEmail }
            });
            if (emailExists) {
              email = `${cleanName}.${normalizedPhone.slice(-4)}@reservatior.com`;
            } else {
              email = baseEmail;
            }
          }

          user = await prisma.user.create({
            data: {
              email,
              name: contactName,
              phone: normalizedPhone,
              locale: countryCode === "TR" ? "tr-TR" : "en-US",
            },
          });
        }
        userId = user.id;

        // Create Contact record as Owner
        await prisma.contact.upsert({
          where: { id: `contact_wa_${normalizedPhone}` },
          update: {
            fullName: contactName,
            phone: normalizedPhone,
            email: user.email,
          },
          create: {
            id: `contact_wa_${normalizedPhone}`,
            orgId: orgId,
            type: "OWNER_CONTACT",
            fullName: contactName,
            phone: normalizedPhone,
            email: user.email,
          },
        });
      } catch (userErr: any) {
        console.warn(`⚠️ User/Contact upsert warning for ${contactName} (${normalizedPhone}):`, userErr.message);
      }
    }

    // Load description/body from any .txt files in the directory
    let notes = "";
    const filesInDir = fs.readdirSync(dirPath);
    const txtFiles = filesInDir.filter(f => f.endsWith(".txt"));
    for (const txtFile of txtFiles) {
      notes += fs.readFileSync(path.join(dirPath, txtFile), "utf-8") + "\n";
    }
    notes = notes.trim() || `WhatsApp Scraped Listing: ${details.projectName}`;

    // Append contact details to notes
    if (contactPhone) {
      notes += `\n\n[İlan Sahibi İletişim Bilgileri]\nİsim: ${contactName}\nTelefon: ${contactPhone}`;
    }

    // Clean price
    const rawPrice = details.price || "";
    const price = parseNumericPrice(rawPrice);
    const currency = detectCurrency(rawPrice, countryCode);

    // Determine type (Apartment / Detached House)
    let type: PropertyType = PropertyType.APARTMENT;
    if (details.projectName?.toLowerCase().includes("villa") || notes.toLowerCase().includes("villa")) {
      type = PropertyType.DETACHED_HOUSE;
    }

    const bedrooms = parseBedrooms(details.roomType);

    // Generate unique ID based on details.projectName & folder name to avoid duplicates
    const folderName = path.basename(dirPath);
    const uniqueId = `wa_${folderName.replace(/[^A-Za-z0-9]/g, "_")}`;

    console.log(`📦 Importing: ${details.projectName || folderName} (${countryCode}) -> ID: ${uniqueId}`);

    const property = await prisma.property.upsert({
      where: { id: uniqueId },
      update: {
        listingPrice: price,
        currency: currency,
        notes: notes,
        createdBy: userId,
      },
      create: {
        id: uniqueId,
        orgId: orgId,
        name: details.projectName || "WhatsApp Emlak İlanı",
        type: type,
        propertyCategory: PropertyCategory.RESIDENTIAL,
        listingType: ListingType.SALE,
        listingStatus: ListingStatus.AVAILABLE,
        region: REGION_ENUM_MAP[countryCode] as any,
        currency: currency,
        addressLine1: `${details.district || "Bilinmeyen İlçe"}, ${details.city || "İstanbul"}`,
        city: details.city || "İstanbul",
        country: countryCode,
        notes: notes,
        bedrooms: bedrooms,
        listingPrice: price,
        createdBy: userId,
      },
    });

    // Handle Media Files (Photos & Videos) Ingestion
    const dataRoot = path.join(process.cwd(), "data");
    const relativeDirPath = path.relative(dataRoot, dirPath);
    const mediaFiles = fs.readdirSync(dirPath);

    // Photos
    const photoExtensions = [".jpg", ".jpeg", ".png"];
    const photos = mediaFiles.filter(file => {
      const ext = path.extname(file).toLowerCase();
      return photoExtensions.includes(ext);
    });

    if (photos.length > 0) {
      console.log(`📸 Found ${photos.length} photos for property ${uniqueId}`);
      for (let i = 0; i < photos.length; i++) {
        const filename = photos[i];
        const publicUrl = `/data/${relativeDirPath}/${filename}`;

        await prisma.photo.upsert({
          where: { url: publicUrl },
          update: {
            propertyId: property.id,
            featured: i === 0,
          },
          create: {
            url: publicUrl,
            type: "GALLERY",
            featured: i === 0,
            propertyId: property.id,
            originalName: filename,
          },
        });
      }
    }

    // Videos
    const videos = mediaFiles.filter(file => {
      const ext = path.extname(file).toLowerCase();
      return ext === ".mp4";
    });

    if (videos.length > 0 && userId) {
      console.log(`🎥 Found ${videos.length} videos for property ${uniqueId}`);
      
      // Find or create Agent record
      let agent = await prisma.agent.findFirst({
        where: { ownerId: userId }
      });
      if (!agent) {
        agent = await prisma.agent.create({
          data: {
            name: contactName,
            email: `${normalizePhoneNumber(contactPhone, countryCode)}@reservatior.com`,
            phoneNumber: normalizePhoneNumber(contactPhone, countryCode),
            ownerId: userId,
            status: "ACTIVE" as any,
          }
        });
      }

      for (const filename of videos) {
        const publicUrl = `/data/${relativeDirPath}/${filename}`;
        const videoId = `video_wa_${uniqueId}_${filename.replace(/[^A-Za-z0-9]/g, "_")}`;

        await prisma.agentVideo.upsert({
          where: { id: videoId },
          update: {
            propertyId: property.id,
            videoUrl: publicUrl,
            status: "completed",
          },
          create: {
            id: videoId,
            orgId: orgId,
            agentId: agent.id,
            vendorId: "vendor_whatsapp",
            propertyId: property.id,
            title: details.projectName || "WhatsApp Video Turu",
            videoUrl: publicUrl,
            status: "completed",
          },
        });
      }
    }

    console.log(`✅ Successfully imported: ${uniqueId}`);

  } catch (error: any) {
    console.error(`❌ Error processing directory ${dirPath}:`, error.message);
  }
}

async function main() {
  const dataPath = path.join(process.cwd(), "data");
  if (!fs.existsSync(dataPath)) {
    console.error(`❌ Data directory not found: ${dataPath}`);
    process.exit(1);
  }

  console.log("🟢 Starting WhatsApp Scraped Listings Ingestion...");
  
  // We scan BAE and TURKİYE folders
  const turkiyePath = path.join(dataPath, "TURKİYE");
  const baePath = path.join(dataPath, "BAE");

  if (fs.existsSync(turkiyePath)) {
    await importScrapedProperties(turkiyePath);
  }
  if (fs.existsSync(baePath)) {
    await importScrapedProperties(baePath);
  }

  console.log("\n🎉 WhatsApp listings import finished!");
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
