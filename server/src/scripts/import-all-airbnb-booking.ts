import prismaManager from "../lib/prisma";
import * as fs from "node:fs";
import { join } from "node:path";

const AIRBNB_ROOT = "/Users/os2026/Downloads/Reservatior/server/data/airbnb";
const MAX_PROPERTIES_PER_CITY = 200; // Limit per city to speed up seed and save resources

const FOLDER_TO_REGION: Record<string, string> = {
  usa: "US",
  france: "FR",
  belgium: "BE", // Fallbacks to US database automatically
  turkey: "TR",
  netherlands: "NL",
  germany: "DE",
  united_kingdom: "UK",
  spain: "ES",
  italy: "IT",
  australia: "AU",
  thailand: "TH",
  greece: "GR", // Fallbacks to US database automatically
  belize: "BZ"  // Fallbacks to US database automatically
};

const REGION_META: Record<string, { currency: string; locale: string }> = {
  US: { currency: "USD", locale: "en-US" },
  TR: { currency: "TRY", locale: "tr-TR" },
  UK: { currency: "GBP", locale: "en-GB" },
  DE: { currency: "EUR", locale: "de-DE" },
  FR: { currency: "EUR", locale: "fr-FR" },
  ES: { currency: "EUR", locale: "es-ES" },
  IT: { currency: "EUR", locale: "it-IT" },
  NL: { currency: "EUR", locale: "nl-NL" },
  CA: { currency: "CAD", locale: "en-CA" },
  MX: { currency: "MXN", locale: "es-MX" },
  BR: { currency: "BRL", locale: "pt-BR" },
  AR: { currency: "ARS", locale: "es-AR" },
  AU: { currency: "AUD", locale: "en-AU" },
  NZ: { currency: "NZD", locale: "en-NZ" },
  JP: { currency: "JPY", locale: "ja-JP" },
  KR: { currency: "KRW", locale: "ko-KR" },
  CN: { currency: "CNY", locale: "zh-CN" },
  IN: { currency: "INR", locale: "hi-IN" },
  SG: { currency: "SGD", locale: "en-SG" },
  MY: { currency: "MYR", locale: "ms-MY" },
  TH: { currency: "THB", locale: "th-TH" },
  AE: { currency: "AED", locale: "ar-AE" },
  SA: { currency: "SAR", locale: "ar-SA" }
};

function getRegionMeta(region: string): { currency: string; locale: string } {
  return REGION_META[region] || { currency: "USD", locale: "en-US" };
}

// Recursively find all listings.csv files
function getListingsFiles(dir: string, filesList: string[] = []): string[] {
  if (!fs.existsSync(dir)) return filesList;
  const items = fs.readdirSync(dir, { withFileTypes: true });
  for (const item of items) {
    const fullPath = join(dir, item.name);
    if (item.isDirectory()) {
      getListingsFiles(fullPath, filesList);
    } else if (item.isFile() && item.name === "listings.csv") {
      filesList.push(fullPath);
    }
  }
  return filesList;
}

// Async stream-based CSV row parser that pauses read stream to process async callbacks sequentially
async function forEachRow(
  filePath: string,
  callback: (row: Record<string, string>, index: number) => Promise<boolean> // return false to stop processing early
): Promise<void> {
  return new Promise((resolve, reject) => {
    const stream = fs.createReadStream(filePath, { encoding: "utf8" });
    let headers: string[] = [];
    let rowCells: string[] = [];
    let currentCell = "";
    let inQuotes = false;
    let rowIndex = 0;
    let promiseChain = Promise.resolve();
    let shouldStop = false;

    stream.on("data", (chunk: string) => {
      if (shouldStop) {
        stream.destroy();
        return;
      }
      stream.pause();

      promiseChain = (async () => {
        for (let i = 0; i < chunk.length; i++) {
          const char = chunk[i];
          if (char === '"') {
            if (inQuotes && chunk[i + 1] === '"') {
              currentCell += '"';
              i++;
            } else {
              inQuotes = !inQuotes;
            }
          } else if (char === ',' && !inQuotes) {
            rowCells.push(currentCell.trim());
            currentCell = "";
          } else if ((char === '\n' || char === '\r') && !inQuotes) {
            if (char === '\r' && chunk[i + 1] === '\n') {
              i++;
            }
            rowCells.push(currentCell.trim());
            currentCell = "";
            
            if (rowCells.length > 0 && rowCells.some(c => c !== "")) {
              if (headers.length === 0) {
                headers = rowCells.map(h => h.toLowerCase().replace(/['"]+/g, ''));
              } else {
                const row: Record<string, string> = {};
                headers.forEach((header, index) => {
                  row[header] = (rowCells[index] || "").replace(/['"]+/g, '');
                });
                const keepGoing = await callback(row, rowIndex++);
                if (!keepGoing) {
                  shouldStop = true;
                  stream.destroy();
                  return;
                }
              }
            }
            rowCells = [];
          } else {
            currentCell += char;
          }
        }
      })()
        .then(() => {
          if (!shouldStop) {
            stream.resume();
          }
        })
        .catch((err) => {
          stream.destroy();
          reject(err);
        });
    });

    stream.on("end", () => {
      if (shouldStop) {
        resolve();
        return;
      }
      promiseChain.then(() => {
        if (rowCells.length > 0 && headers.length > 0) {
          const row: Record<string, string> = {};
          headers.forEach((header, index) => {
            row[header] = (rowCells[index] || "").replace(/['"]+/g, '');
          });
          callback(row, rowIndex++).then(() => resolve()).catch(reject);
        } else {
          resolve();
        }
      }).catch(reject);
    });

    stream.on("error", (err) => {
      reject(err);
    });
  });
}

async function run() {
  console.log("🌎 ==================================================");
  console.log("🚀 --- GLOBAL AIRBNB BOOKING INGESTION ENGINE ---");
  console.log("🌎 ==================================================\n");

  const listingsFiles = getListingsFiles(AIRBNB_ROOT);
  console.log(`Found ${listingsFiles.length} listings.csv files to process.\n`);

  for (const filePath of listingsFiles) {
    const parts = filePath.split("/");
    const airbnbIdx = parts.indexOf("airbnb");
    const countryFolder = parts[airbnbIdx + 1];
    const stateFolder = parts[airbnbIdx + 2];
    const cityFolder = parts[airbnbIdx + 3];

    const region = FOLDER_TO_REGION[countryFolder] || "US";
    const prisma = prismaManager.getClient(region);
    const meta = getRegionMeta(region);

    const prettyCity = cityFolder.replace(/_/g, " ").toUpperCase();
    const prettyCountry = countryFolder.replace(/_/g, " ").toUpperCase();

    // Map connection region (e.g., US) to the correct DB Region enum value (e.g., USA, FR, DE...)
    const enumRegion = region === "US" ? "USA" : region;
    const finalRegion = ["TR", "UAE", "UK", "USA", "RU", "CN", "GLOBAL", "FR", "DE", "SA", "CA", "SG", "ES", "IT", "JP", "KR", "AU", "NZ", "NL", "MX", "BR", "IN", "TH", "MY", "AR"].includes(enumRegion) 
      ? enumRegion 
      : "GLOBAL";

    console.log(`📍 Processing: ${prettyCity} (${prettyCountry}) -> Region [${region}] (Enum: ${finalRegion})`);
    console.log(`📂 Path: ${filePath}`);

    // Create a dynamic, robust agency organization for Airbnb in this region
    const orgId = `org_airbnb_${region.toLowerCase()}`;
    const orgName = `Airbnb - ${prettyCity} Portfolio`;

    let org;
    try {
      org = await prisma.organization.upsert({
        where: { id: orgId },
        update: {},
        create: {
          id: orgId,
          name: orgName,
          type: "AGENCY",
          region: finalRegion as any,
          defaultCurrency: meta.currency,
          defaultLocale: meta.locale,
          taxReportingEnabled: true,
          complianceTracking: true,
        }
      });
    } catch (e: any) {
      console.error(`❌ Failed to create/resolve organization for region ${region}: ${e.message}`);
      continue;
    }

    let successCount = 0;
    let errorCount = 0;

    await forEachRow(filePath, async (row, index) => {
      if (successCount >= MAX_PROPERTIES_PER_CITY) {
        return false; // Stop processing this file
      }

      try {
        const rawId = row.id;
        const hostId = row.host_id;
        const hostName = row.host_name || "Airbnb Host";
        if (!rawId || !hostId) return true; // skip invalid rows

        const propId = `airbnb_${rawId}`;
        const contactId = `contact_airbnb_${hostId}`;
        const title = row.name || `Airbnb Property #${rawId}`;
        const price = parseFloat(row.price?.replace(/[^0-9.]/g, "") || "150");
        const lat = parseFloat(row.latitude);
        const lng = parseFloat(row.longitude);
        const roomType = row.room_type || "Entire home/apt";
        const neighbourhood = row.neighbourhood_cleansed || row.neighbourhood || "Central";

        if (isNaN(lat) || isNaN(lng)) return true; // skip rows without coords

        // 1. Upsert Host Contact
        await prisma.contact.upsert({
          where: { id: contactId },
          update: { fullName: hostName },
          create: {
            id: contactId,
            orgId: org.id,
            type: "OWNER_CONTACT",
            fullName: hostName,
            email: `${hostId}@airbnb.com`,
          }
        });

        // 2. Upsert Neighborhood
        let neighborhoodRecord = null;
        if (neighbourhood) {
          neighborhoodRecord = await prisma.neighborhood.upsert({
            where: {
              orgId_name: {
                orgId: org.id,
                name: neighbourhood
              }
            },
            update: {},
            create: {
              orgId: org.id,
              name: neighbourhood,
              city: cityFolder,
              state: stateFolder,
            }
          });
        }

        // 3. Upsert Location
        const location = await prisma.location.upsert({
          where: { id: `loc_${propId}` },
          update: {
            addressLine1: `${neighbourhood} District`,
            city: cityFolder,
            country: region,
            latitude: lat,
            longitude: lng,
          },
          create: {
            id: `loc_${propId}`,
            orgId: org.id,
            addressLine1: `${neighbourhood} District`,
            city: cityFolder,
            country: region,
            latitude: lat,
            longitude: lng,
          }
        });

        // 4. Upsert Property as BOOKING listingType
        await prisma.property.upsert({
          where: { id: propId },
          update: {
            name: title.substring(0, 100),
            type: roomType.toLowerCase().includes("entire") ? "APARTMENT" : "STUDIO",
            propertyCategory: "RESIDENTIAL",
            listingType: "BOOKING", // Set listingType to BOOKING as requested
            listingStatus: "AVAILABLE",
            region: finalRegion as any,
            currency: meta.currency,
            addressLine1: `${neighbourhood} District`,
            city: cityFolder,
            state: stateFolder,
            country: region,
            notes: `Room type: ${roomType}`,
            listingPrice: price,
            locationId: location.id,
            neighborhoodId: neighborhoodRecord?.id || null,
          },
          create: {
            id: propId,
            orgId: org.id,
            name: title.substring(0, 100),
            type: roomType.toLowerCase().includes("entire") ? "APARTMENT" : "STUDIO",
            propertyCategory: "RESIDENTIAL",
            listingType: "BOOKING", // Set listingType to BOOKING as requested
            listingStatus: "AVAILABLE",
            region: finalRegion as any,
            currency: meta.currency,
            addressLine1: `${neighbourhood} District`,
            city: cityFolder,
            state: stateFolder,
            country: region,
            notes: `Room type: ${roomType}`,
            listingPrice: price,
            createdBy: contactId,
            locationId: location.id,
            neighborhoodId: neighborhoodRecord?.id || null,
          }
        });

        // 5. Optionally upsert document for the primary picture URL
        if (row.picture_url || (row.latitude && row.longitude)) {
          // If TR/Turkey, we can use Yandex Static API. Otherwise, fall back to Google Maps.
          let finalFileUrl = row.picture_url;
          if (!finalFileUrl) {
            if (region.toLowerCase() === "turkey" || region.toLowerCase() === "tr") {
              // Yandex Static Maps API
              const apiKey = process.env.YANDEX_MAPS_API_KEY || "f6288c69-ddb9-45e8-aef6-23fa621af12b";
              finalFileUrl = `https://static-maps.yandex.ru/v1?ll=${row.longitude},${row.latitude}&z=15&size=600,450&theme=light&pt=${row.longitude},${row.latitude},pm2rdl&apikey=${apiKey}`;
            } else {
              // Google Static Maps API
              const apiKey = process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || "";
              finalFileUrl = `https://maps.googleapis.com/maps/api/staticmap?center=${row.latitude},${row.longitude}&zoom=15&size=600x400&maptype=roadmap&markers=color:red%7C${row.latitude},${row.longitude}&key=${apiKey}`;
            }
          }
          
          await prisma.document.upsert({
            where: { id: `doc_${propId}` },
            update: { fileUrl: finalFileUrl },
            create: {
              id: `doc_${propId}`,
              orgId: org.id,
              propertyId: propId,
              title: `${title.substring(0, 60)} - Location Map`,
              documentType: "CERTIFICATE", // Correct DocumentTypeUSA value
              fileUrl: finalFileUrl,
              mimeType: "image/jpeg",
              fileSize: 0,
              checksum: "placeholder",
              fileName: "location_map.jpg",
            }
          });
        }

        successCount++;
        if (successCount % 50 === 0) {
          console.log(`   Ingested ${successCount} listings...`);
        }
      } catch (err: any) {
        errorCount++;
      }
      return true; // continue processing
    });

    console.log(`   ✅ Ingestion completed for ${prettyCity}. Success: ${successCount}, Skips/Errors: ${errorCount}\n`);
  }

  console.log("🏁 Global Ingestion finished successfully. 🚀");
}

run().catch(console.error);
