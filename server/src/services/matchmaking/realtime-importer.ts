import { prismaManager } from "../../lib/prisma";
import fs from "node:fs";
import path from "node:path";
import { PropertyType, ListingStatus, ListingType, PropertyCategory } from "@prisma/client";

const COUNTRY_MAP: Record<string, string> = {
  "TURKİYE": "TR",
  "TURKIYE": "TR",
  "TÜRKİYE": "TR",
  "BAE": "AE",
  "UAE": "AE",
  "DUBAI": "AE",
  "DUBAİ": "AE",
};

const REGION_ENUM_MAP: Record<string, string> = {
  "TR": "TR",
  "AE": "UAE",
};

function parseNumericPrice(priceStr: string): number | null {
  if (!priceStr || priceStr.toLowerCase().includes("bilinmiyor") || priceStr.toLowerCase().includes("güncellendi")) {
    return null;
  }
  const cleanStr = priceStr.replace(/\./g, "").replace(/,/g, "");
  const match = cleanStr.match(/\d+/);
  if (match) {
    return parseInt(match[0], 10);
  }
  return null;
}

function detectCurrency(priceStr: string, countryCode: string): string {
  const str = priceStr.toUpperCase();
  if (str.includes("USD") || str.includes("$")) return "USD";
  if (str.includes("AED")) return "AED";
  if (str.includes("TL") || str.includes("₺")) return "TRY";
  return countryCode === "TR" ? "TRY" : (countryCode === "AE" ? "AED" : "USD");
}

function parseBedrooms(roomType: string): number | null {
  if (!roomType) return null;
  const match = roomType.match(/^(\d+)/);
  if (match) {
    return parseInt(match[1], 10);
  }
  return null;
}

function normalizePhoneNumber(rawPhone: string, countryCode: string): string {
  let cleaned = rawPhone.replace(/\D/g, "");
  if (countryCode === "TR") {
    if (!cleaned.startsWith("90") && cleaned.length === 10) {
      cleaned = "90" + cleaned;
    } else if (cleaned.startsWith("05")) {
      cleaned = "90" + cleaned.substring(1);
    }
  } else if (countryCode === "AE") {
    if (!cleaned.startsWith("971") && cleaned.length === 9) {
      cleaned = "971" + cleaned;
    } else if (cleaned.startsWith("05")) {
      cleaned = "971" + cleaned.substring(1);
    }
  }
  return cleaned;
}

function classifyMessage(text: string, dirPath: string): "DEMAND" | "SUPPLY" {
  const textLower = text.toLowerCase();
  const pathLower = dirPath.toLowerCase();

  if (
    pathLower.includes("arayış") || 
    pathLower.includes("aranıyor") ||
    textLower.includes("arayış") || 
    textLower.includes("arıyorum") || 
    textLower.includes("aranıyor") || 
    textLower.includes("lazım") || 
    textLower.includes("gerekli") || 
    textLower.includes("looking for") || 
    textLower.includes("want to rent") || 
    textLower.includes("want to buy")
  ) {
    return "DEMAND";
  }
  return "SUPPLY";
}

export class RealtimeImporter {
  /**
   * Imports scraped group chat details and text logs into the database in real-time.
   */
  static async importScrapedDirectory(dirPath: string, detailsPath: string) {
    try {
      const detailsRaw = fs.readFileSync(detailsPath, "utf-8");
      const details = JSON.parse(detailsRaw);

      const country = details.country || "TURKİYE";
      const countryCode = COUNTRY_MAP[country.toUpperCase()] || "TR";
      const prisma = prismaManager.getClient(countryCode);

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

      // Load description text
      let notes = "";
      const filesInDir = fs.readdirSync(dirPath);
      const txtFiles = filesInDir.filter(f => f.endsWith(".txt"));
      for (const txtFile of txtFiles) {
        notes += fs.readFileSync(path.join(dirPath, txtFile), "utf-8") + "\n";
      }
      notes = notes.trim() || `WhatsApp Scraped Item: ${details.projectName || path.basename(dirPath)}`;

      const contactName = details.contactName || "Bilinmeyen Gönderici";
      const contactPhone = details.contactPhone || "";
      const normalizedPhone = contactPhone && contactPhone !== "Bilinmiyor" 
        ? normalizePhoneNumber(contactPhone, countryCode) 
        : "";

      const classification = classifyMessage(notes + " " + (details.projectName || ""), dirPath);

      if (classification === "DEMAND") {
        const bedrooms = parseBedrooms(details.roomType);
        const rawPrice = details.price || "";
        const price = parseNumericPrice(rawPrice);
        const currency = detectCurrency(rawPrice, countryCode);

        const nameParts = contactName.split(" ");
        const firstName = nameParts[0] || "WhatsApp Group";
        const lastName = nameParts.slice(1).join(" ") || "User";

        const uniqueLeadId = `lead_wa_${path.basename(dirPath).replace(/[^A-Za-z0-9]/g, "_")}`;
        
        let fullNotes = notes;
        if (contactPhone) {
          fullNotes += `\n\n[İletişim Bilgileri]\nİsim: ${contactName}\nTelefon: ${contactPhone}`;
        }

        await prisma.lead.upsert({
          where: { id: uniqueLeadId },
          update: {
            budget: price,
            notes: JSON.stringify({
              scrapedText: fullNotes,
              roomType: details.roomType,
              district: details.district,
              city: details.city,
              projectName: details.projectName,
              bedrooms,
              currency,
            }),
          },
          create: {
            id: uniqueLeadId,
            orgId: orgId,
            firstName,
            lastName,
            phone: normalizedPhone || null,
            budget: price,
            timeline: "WhatsApp Scraped Demand",
            status: "NEW",
            sourceDetail: `Scraped WhatsApp Group (${details.district || "Genel"})`,
            notes: JSON.stringify({
              scrapedText: fullNotes,
              roomType: details.roomType,
              district: details.district,
              city: details.city,
              projectName: details.projectName,
              bedrooms,
              currency,
            }),
          }
        });

        console.log(`🎯 Realtime Importer: Imported DEMAND (Lead) -> ID: ${uniqueLeadId} [${countryCode}]`);
        return { type: "DEMAND", id: uniqueLeadId };

      } else {
        let userId: string | null = null;
        if (normalizedPhone) {
          try {
            let user = await prisma.user.findFirst({
              where: { phone: normalizedPhone }
            });

            if (user) {
              user = await prisma.user.update({
                where: { id: user.id },
                data: { name: contactName }
              });
            } else {
              let email = `${normalizedPhone}@reservatior.com`;
              let cleanName = contactName;
              const charMap: Record<string, string> = {
                'ç': 'c', 'ğ': 'g', 'ı': 'i', 'ö': 'o', 'ş': 's', 'ü': 'u',
                'Ç': 'c', 'Ğ': 'g', 'İ': 'i', 'Ö': 'o', 'Ş': 's', 'Ü': 'u'
              };
              for (const [tr, en] of Object.entries(charMap)) {
                cleanName = cleanName.replaceAll(tr, en);
              }
              cleanName = cleanName.toLowerCase().trim().replace(/[^a-z0-9\s]/g, '').replace(/\s+/g, '.');

              if (cleanName && cleanName !== 'bilinmeyen.gonderici' && cleanName !== 'bilinmiyor') {
                const baseEmail = `${cleanName}@reservatior.com`;
                const emailExists = await prisma.user.findUnique({ where: { email: baseEmail } });
                email = emailExists ? `${cleanName}.${normalizedPhone.slice(-4)}@reservatior.com` : baseEmail;
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

            await prisma.contact.upsert({
              where: { id: `contact_wa_${normalizedPhone}` },
              update: { fullName: contactName, phone: normalizedPhone, email: user.email },
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
            console.warn(`⚠️ User/Contact upsert warning:`, userErr.message);
          }
        }

        const rawPrice = details.price || "";
        const price = parseNumericPrice(rawPrice);
        const currency = detectCurrency(rawPrice, countryCode);
        const bedrooms = parseBedrooms(details.roomType);

        let type: PropertyType = PropertyType.APARTMENT;
        if (details.projectName?.toLowerCase().includes("villa") || notes.toLowerCase().includes("villa")) {
          type = PropertyType.DETACHED_HOUSE;
        }

        const uniqueId = `wa_${path.basename(dirPath).replace(/[^A-Za-z0-9]/g, "_")}`;
        let fullNotes = notes;
        if (contactPhone) {
          fullNotes += `\n\n[İlan Sahibi İletişim Bilgileri]\nİsim: ${contactName}\nTelefon: ${contactPhone}`;
        }

        const property = await prisma.property.upsert({
          where: { id: uniqueId },
          update: {
            listingPrice: price,
            currency: currency,
            notes: fullNotes,
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
            notes: fullNotes,
            bedrooms: bedrooms,
            listingPrice: price,
            createdBy: userId,
          },
        });

        // Photos Ingestion
        const dataRoot = path.join(process.cwd(), "data");
        const relativeDirPath = path.relative(dataRoot, dirPath);
        const mediaFiles = fs.readdirSync(dirPath);

        const photos = mediaFiles.filter(file => {
          const ext = path.extname(file).toLowerCase();
          return [".jpg", ".jpeg", ".png"].includes(ext);
        });

        if (photos.length > 0) {
          for (let i = 0; i < photos.length; i++) {
            const filename = photos[i];
            const publicUrl = `/data/${relativeDirPath}/${filename}`;
            await prisma.photo.upsert({
              where: { url: publicUrl },
              update: { propertyId: property.id, featured: i === 0 },
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

        // Videos Ingestion
        const videos = mediaFiles.filter(file => path.extname(file).toLowerCase() === ".mp4");
        if (videos.length > 0 && userId) {
          // Ensure VideoVendor exists first
          await prisma.videoVendor.upsert({
            where: { email: "vendor@whatsapp.com" },
            update: {},
            create: {
              id: "vendor_whatsapp",
              orgId: orgId,
              name: "WhatsApp Video Service",
              email: "vendor@whatsapp.com",
              status: "ACTIVE" as any,
            }
          });

          let agent = await prisma.agent.findFirst({ where: { ownerId: userId } });
          if (!agent) {
            agent = await prisma.agent.create({
              data: {
                name: contactName,
                email: `${normalizedPhone || "unknown"}@reservatior.com`,
                phoneNumber: normalizedPhone || "unknown",
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
              update: { propertyId: property.id, videoUrl: publicUrl },
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

        console.log(`📦 Realtime Importer: Imported SUPPLY (Property) -> ID: ${uniqueId} [${countryCode}]`);
        return { type: "SUPPLY", id: uniqueId };
      }
    } catch (e: any) {
      console.error(`❌ Realtime Importer error for ${dirPath}:`, e.message);
      return null;
    }
  }
}
