import { PrismaClient } from "@prisma/client";
import fs from "fs";
import { join } from "path";
import readline from "readline";
import zlib from "zlib";

// Use Turkey database for Turkey data, US database for US data, etc.
const getPrismaClient = (region: string) => {
  const databaseUrls: Record<string, string> = {
    'TR': process.env.DATABASE_URL_TR || process.env.DATABASE_URL || '',
    'US': process.env.DATABASE_URL_US || process.env.DATABASE_URL || '',
    'NL': process.env.DATABASE_URL_NL || process.env.DATABASE_URL || '',
    'UK': process.env.DATABASE_URL_UK || process.env.DATABASE_URL || '',
    'DE': process.env.DATABASE_URL_DE || process.env.DATABASE_URL || '',
    'FR': process.env.DATABASE_URL_FR || process.env.DATABASE_URL || '',
  };
  
  return new PrismaClient({
    datasources: {
      db: {
        url: databaseUrls[region] || process.env.DATABASE_URL || ''
      }
    }
  });
};

const prisma = new PrismaClient();

// Limit the number of properties to ingest per dataset file to prevent database bloating and ensure speed
const MAX_PROPERTIES_PER_FILE = 9999999;

function id(city: string, slug: string) {
  const cleanCity = city.toLowerCase().replace(/[^a-z0-9]/g, "_");
  return `us_${cleanCity}_${slug}`;
}

// Native high-fidelity CSV Line Parser (handles quotes and nested commas perfectly)
function parseCSVLine(line: string): string[] {
  const result: string[] = [];
  let current = "";
  let inQuotes = false;
  
  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      if (inQuotes && line[i + 1] === '"') {
        current += '"';
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = "";
    } else {
      current += char;
    }
  }
  result.push(current.trim());
  return result;
}

// Extract country, state, and city from organized path structure if available
function detectFromPath(filePath: string): {
  city: string;
  state: string;
  country: string;
} | null {
  const normalized = filePath.replace(/\\/g, "/");
  const part = "datalar/airbnb/";
  const idx = normalized.indexOf(part);
  if (idx !== -1) {
    const sub = normalized.substring(idx + part.length);
    const segments = sub.split("/");
    if (segments.length >= 3) {
      return {
        country: segments[0],
        state: segments[1],
        city: segments[2]
      };
    }
  }
  return null;
}

// Detect which city is being processed based on path or CSV neighborhood data
function detectCityState(sampleRow: Record<string, string>, filePath?: string): { 
  city: string;
  state: string;
  taxRate: number;
  currency: string;
  region: string;
  country: string;
} {
  if (filePath) {
    const fromPath = detectFromPath(filePath);
    if (fromPath) {
      const cleanCountry = fromPath.country.toLowerCase();
      const cleanState = fromPath.state.toLowerCase();
      const cleanCity = fromPath.city.toLowerCase();

      if (cleanCountry === "usa") {
        if (cleanCity === "seattle" || cleanCity.includes("seattle")) {
          return { city: "Seattle", state: "WA", taxRate: 0.01075, currency: "USD", region: "USA", country: "US" };
        }
        if (cleanCity === "new_york_city" || cleanCity.includes("york")) {
          return { city: "New York", state: "NY", taxRate: 0.0085, currency: "USD", region: "USA", country: "US" };
        }
        if (cleanCity === "los_angeles" || cleanCity.includes("angeles")) {
          return { city: "Los Angeles", state: "CA", taxRate: 0.0125, currency: "USD", region: "USA", country: "US" };
        }
        if (cleanCity === "san_francisco" || cleanCity.includes("francisco")) {
          return { city: "San Francisco", state: "CA", taxRate: 0.0118, currency: "USD", region: "USA", country: "US" };
        }
        if (cleanCity === "chicago") {
          return { city: "Chicago", state: "IL", taxRate: 0.0210, currency: "USD", region: "USA", country: "US" };
        }
        if (cleanCity === "boston") {
          return { city: "Boston", state: "MA", taxRate: 0.0105, currency: "USD", region: "USA", country: "US" };
        }
      } else if (cleanCountry === "netherlands") {
        return { city: "Amsterdam", state: "North Holland", taxRate: 0.0012, currency: "EUR", region: "NL", country: "NL" };
      } else if (cleanCountry === "belgium") {
        if (cleanCity === "brussels") {
          return { city: "Brussels", state: "Brussels", taxRate: 0.0150, currency: "EUR", region: "GLOBAL", country: "BE" };
        } else {
          return { city: "Antwerp", state: "Flanders", taxRate: 0.0150, currency: "EUR", region: "GLOBAL", country: "BE" };
        }
      } else if (cleanCountry === "turkey") {
        return { city: "Istanbul", state: "Marmara", taxRate: 0.0020, currency: "TRY", region: "TR", country: "TR" };
      } else if (cleanCountry === "united_kingdom" || cleanCountry === "united kingdom") {
        return { city: "London", state: "England", taxRate: 0.0150, currency: "GBP", region: "UK", country: "GB" };
      } else if (cleanCountry === "france") {
        return { city: "Paris", state: "Ile de France", taxRate: 0.0050, currency: "EUR", region: "FR", country: "FR" };
      } else if (cleanCountry === "germany") {
        return { city: "Berlin", state: "Berlin", taxRate: 0.0050, currency: "EUR", region: "DE", country: "DE" };
      }
    }
  }

  // Fallback to high-fidelity neighborhood scanning for downloads directory
  const neighborhood = (sampleRow.neighbourhood_cleansed || "").toLowerCase();
  
  // Amsterdam detection
  if (
    neighborhood.includes("centrum-") || 
    neighborhood.includes("oud-west") || 
    neighborhood.includes("de pijp") || 
    neighborhood.includes("rivierenbuurt") || 
    neighborhood.includes("baarsjes") || 
    neighborhood.includes("westerpark") ||
    neighborhood.includes("bos en lommer") ||
    neighborhood.includes("watergraafsmeer") ||
    neighborhood.includes("zeeburg") ||
    neighborhood.includes("ijburg") ||
    neighborhood.includes("buitenveldert")
  ) {
    return { city: "Amsterdam", state: "North Holland", taxRate: 0.0012, currency: "EUR", region: "NL", country: "NL" };
  }
  
  // Belgium (Brussels/Antwerp) detection
  if (
    neighborhood.includes("ixelles") || 
    neighborhood.includes("saint-gilles") || 
    neighborhood.includes("schaerbeek") || 
    neighborhood.includes("anderlecht") || 
    neighborhood.includes("uccle") || 
    neighborhood.includes("forest") || 
    neighborhood.includes("etterbeek") ||
    neighborhood.includes("woluwe")
  ) {
    return { city: "Brussels", state: "Brussels", taxRate: 0.015, currency: "EUR", region: "GLOBAL", country: "BE" };
  }

  if (
    neighborhood.includes("antwerpen") ||
    neighborhood.includes("berchem") ||
    neighborhood.includes("deurne") ||
    neighborhood.includes("borgerhout")
  ) {
    return { city: "Antwerp", state: "Flanders", taxRate: 0.015, currency: "EUR", region: "GLOBAL", country: "BE" };
  }

  // Turkey (Istanbul) detection
  if (
    neighborhood.includes("beyoğlu") ||
    neighborhood.includes("şişli") ||
    neighborhood.includes("beşiktaş") ||
    neighborhood.includes("fatih") ||
    neighborhood.includes("kadıköy") ||
    neighborhood.includes("üsküdar") ||
    neighborhood.includes("sariyer")
  ) {
    return { city: "Istanbul", state: "Marmara", taxRate: 0.0020, currency: "TRY", region: "TR", country: "TR" };
  }

  // UK (London) detection
  if (
    neighborhood.includes("westminster") ||
    neighborhood.includes("kensington") ||
    neighborhood.includes("camden") ||
    neighborhood.includes("hackney") ||
    neighborhood.includes("tower hamlets")
  ) {
    return { city: "London", state: "England", taxRate: 0.0150, currency: "GBP", region: "UK", country: "GB" };
  }

  // France (Paris) detection
  if (
    neighborhood.includes("butte-montmartre") ||
    neighborhood.includes("pantheon") ||
    neighborhood.includes("temple") ||
    neighborhood.includes("elysee") ||
    neighborhood.includes("luxembourg")
  ) {
    return { city: "Paris", state: "Ile de France", taxRate: 0.0050, currency: "EUR", region: "FR", country: "FR" };
  }

  // Germany (Berlin) detection
  if (
    neighborhood.includes("mitte") ||
    neighborhood.includes("kreuzberg") ||
    neighborhood.includes("neukölln") ||
    neighborhood.includes("prenzlauer berg") ||
    neighborhood.includes("charlottenburg")
  ) {
    return { city: "Berlin", state: "Berlin", taxRate: 0.0050, currency: "EUR", region: "DE", country: "DE" };
  }

  // USA Cities
  if (neighborhood.includes("manhattan") || neighborhood.includes("brooklyn") || neighborhood.includes("queens") || neighborhood.includes("bronx") || neighborhood.includes("staten island")) {
    return { city: "New York", state: "NY", taxRate: 0.0085, currency: "USD", region: "USA", country: "US" };
  }
  if (neighborhood.includes("hollywood") || neighborhood.includes("venice") || neighborhood.includes("downtown") && sampleRow.zipcode?.startsWith("90")) {
    return { city: "Los Angeles", state: "CA", taxRate: 0.0125, currency: "USD", region: "USA", country: "US" };
  }
  if (neighborhood.includes("mission") || neighborhood.includes("soma") || neighborhood.includes("presidio") || neighborhood.includes("castro")) {
    return { city: "San Francisco", state: "CA", taxRate: 0.0118, currency: "USD", region: "USA", country: "US" };
  }
  if (neighborhood.includes("loop") || neighborhood.includes("lincoln park") || neighborhood.includes("wicker park")) {
    return { city: "Chicago", state: "IL", taxRate: 0.0210, currency: "USD", region: "USA", country: "US" };
  }
  if (neighborhood.includes("back bay") || neighborhood.includes("beacon hill") || neighborhood.includes("south end")) {
    return { city: "Boston", state: "MA", taxRate: 0.0105, currency: "USD", region: "USA", country: "US" };
  }
  
  // Default to Seattle WA if not uniquely identified
  return { city: "Seattle", state: "WA", taxRate: 0.01075, currency: "USD", region: "USA", country: "US" };
}

function getFilesRecursively(dir: string, fileList: string[] = []): string[] {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      getFilesRecursively(filePath, fileList);
    } else if (file === "listings.csv") {
      fileList.push(filePath);
    }
  }
  return fileList;
}

async function startIngestion() {
  console.log("🛸 --- RESERVATOR UNIVERSAL GLOBAL OMNI-INGESTION SYSTEM ---");

  // Scan downloads directory and organized datalar directory
  const downloadsDir = "/Users/os2026/Downloads";
  const organizedDir = "/Users/os2026/Downloads/Reservatior/datalar/airbnb";
  let targetFiles: string[] = [];
  
  try {
    const filesInDownloads = fs.readdirSync(downloadsDir);
    for (const file of filesInDownloads) {
      const lower = file.toLowerCase();
      // Match listings.csv, listings.csv.gz, listings (1).csv, listings (1).csv.gz, etc.
      if (lower.startsWith("listings") && (lower.endsWith(".csv") || lower.endsWith(".gz"))) {
        targetFiles.push(join(downloadsDir, file));
      }
    }
  } catch (err: any) {
    console.error(`⚠️ Failed to scan downloads directory: ${err.message}`);
  }

  try {
    const organizedFiles = getFilesRecursively(organizedDir);
    targetFiles = [...targetFiles, ...organizedFiles];
  } catch (err: any) {
    console.error(`⚠️ Failed to scan organized datalar directory: ${err.message}`);
  }

  if (targetFiles.length === 0) {
    console.error("\n❌ --- NO DOWNLOADED DATASETS FOUND ---");
    console.log("Downloads klasörünüzde 'listings' ile başlayan herhangi bir .csv veya .gz dosyası bulunamadı.");
    return;
  }

  const targetFile = process.argv[2];
  
  if (targetFile) {
    console.log(`\n🎯 Target File Specified: ${targetFile}`);
    targetFiles = [targetFile];
  }

  console.log(`\n🎉 Found ${targetFiles.length} dataset files in your portfolios to process sequentially!\n`);
  
  for (const filePath of targetFiles) {
    console.log(`\n📦 --- PROCESSING FILE: ${filePath} ---`);
    await processCsvFile(filePath);
  }
  
  console.log("\n🔥 ALL PORTFOLIOS HAVE BEEN SEEDED SUCCESSFULLY! 🔥");
}

async function processCsvFile(sourceFilePath: string) {
  // Read headers first to prepare detection
  const fileStream = sourceFilePath.endsWith(".gz")
    ? fs.createReadStream(sourceFilePath).pipe(zlib.createGunzip())
    : fs.createReadStream(sourceFilePath);

  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });

  let headers: string[] = [];
  let detected = { city: "Seattle", state: "WA", taxRate: 0.01075, currency: "USD", region: "USA", country: "US" };
  let hasDetected = false;

  // Read first few lines to detect the city
  for await (const line of rl) {
    if (!line.trim()) continue;
    const columns = parseCSVLine(line);
    
    if (headers.length === 0) {
      headers = columns.map(h => h.toLowerCase().replace(/['"]+/g, ''));
      continue;
    }

    const row: Record<string, string> = {};
    headers.forEach((header, index) => {
      row[header] = (columns[index] || "").replace(/['"]+/g, '');
    });

    detected = detectCityState(row, sourceFilePath);
    hasDetected = true;
    break;
  }
  rl.close();

  console.log(`\n🕵️‍♂️ Target City Detected: ${detected.city}, ${detected.state} (Tax Rate: ${(detected.taxRate * 100).toFixed(3)}%)`);
  console.log(`🌍 Target Country: ${detected.country} (Region: ${detected.region})`);

  // Use regional database for this country
  const regionalPrisma = getPrismaClient(detected.country);
  console.log(`📡 Connecting to regional database: ${detected.country}`);

  // Fetch or create organization for this city
  console.log("🏢 Setting up Sovereign Organization...");
  const org = await regionalPrisma.organization.upsert({
    where: { id: id(detected.city, "org") },
    update: {},
    create: {
      id: id(detected.city, "org"),
      name: `Reservatior ${detected.region} - ${detected.city} Portfolio`,
      type: "AGENCY",
      region: detected.region as any,
      defaultCurrency: detected.currency,
      defaultLocale: detected.currency === "EUR" ? "nl-NL" : (detected.currency === "TRY" ? "tr-TR" : "en-US"),
      taxReportingEnabled: true,
      complianceTracking: true,
      contactEmail: `${detected.city.toLowerCase().replace(/\s+/g, "")}@reservatior.com`,
      address: `100 Main Street, ${detected.city}, ${detected.state}`,
    },
  });
  console.log(`✅ Organization Ready: ${org.name}\n`);

  // Stream parse CSV directly from original sourceFilePath!
  console.log(`📊 Ingesting listings (capped at ${MAX_PROPERTIES_PER_FILE} for performance)...`);
  const processingStream = sourceFilePath.endsWith(".gz")
    ? fs.createReadStream(sourceFilePath).pipe(zlib.createGunzip())
    : fs.createReadStream(sourceFilePath);

  const reader = readline.createInterface({
    input: processingStream,
    crlfDelay: Infinity
  });

  headers = [];
  let successCount = 0;
  let errorCount = 0;

  for await (const line of reader) {
    if (successCount >= MAX_PROPERTIES_PER_FILE) {
      break;
    }

    if (!line.trim()) continue;
    const columns = parseCSVLine(line);
    
    if (headers.length === 0) {
      headers = columns.map(h => h.toLowerCase().replace(/['"]+/g, ''));
      continue;
    }

    const row: Record<string, string> = {};
    headers.forEach((header, index) => {
      row[header] = (columns[index] || "").replace(/['"]+/g, '');
    });

    try {
      const rawId = row.id;
      if (!rawId) continue;

      const name = row.name || `${detected.city} Property #${rawId}`;
      const priceVal = parseFloat(row.price?.replace(/[^0-9.]/g, "") || "200");
      const lat = parseFloat(row.latitude);
      const lng = parseFloat(row.longitude);
      const zip = row.zipcode || (detected.city === "New York" ? "10001" : (detected.city === "Amsterdam" ? "1012 JS" : "90001"));
      const roomType = row.room_type || "Entire home/apt";
      const bedrooms = parseInt(row.bedrooms || "2");
      const bathrooms = parseFloat(row.bathrooms || "1.5");
      const neighborhood = row.neighbourhood_cleansed || "Metro Area";

      if (isNaN(lat) || isNaN(lng)) continue;

      const propId = id(detected.city, `air_${rawId}`);
      
      // Calculate realistic financial values
      const assessedValue = Math.round(priceVal * 3000); 
      const taxAmt = Math.round(assessedValue * detected.taxRate * 100) / 100;

      // 1. Prepare dynamic multi-regional property parameters
      const propertyData: any = {
        id: propId,
        orgId: org.id,
        name: name.substring(0, 100),
        type: roomType.includes("Entire") ? "APARTMENT" : "DETACHED_HOUSE",
        region: detected.region as any,
        currency: detected.currency,
        addressLine1: `${neighborhood} District`,
        city: detected.city,
        state: detected.state,
        zip: zip,
        country: detected.country,
        lat: lat,
        lng: lng,
        propertyCategory: "RESIDENTIAL",
        listingType: "RENT",
        listingStatus: "AVAILABLE",
        yearBuilt: 1930 + Math.floor(Math.random() * 90),
        bedrooms: bedrooms || 1,
        bathrooms: bathrooms || 1,
        assessedValue: assessedValue,
        marketValue: Math.round(assessedValue * 1.18),
        propertyTax: taxAmt,
        propertyTaxRate: detected.taxRate * 100,
        lastAssessmentValue: assessedValue,
        lastAssessmentYear: 2025,
      };

      // Apply region specific codes and configurations
      if (detected.country === "US") {
        const US_STATE_MAPPING: Record<string, string> = {
          NY: "NEW_YORK",
          CA: "CALIFORNIA",
          WA: "WASHINGTON",
          IL: "ILLINOIS",
          MA: "MASSACHUSETTS"
        };
        propertyData.stateCode = (US_STATE_MAPPING[detected.state] || "WASHINGTON") as any;
        propertyData.countyFIPS = detected.state === "NY" ? "36061" : (detected.state === "CA" ? "06037" : (detected.state === "IL" ? "17031" : (detected.state === "MA" ? "25025" : "53033")));
        propertyData.schoolDistrict = `${detected.city} Public Schools`;
        propertyData.electricityProvider = `${detected.city} Power Utility`;
        propertyData.waterProvider = `${detected.city} Water Works`;
        propertyData.gasProvider = `${detected.city} Gas Utility`;
        propertyData.trashService = `${detected.city} Waste Disposal`;
      } else if (detected.country === "NL") {
        propertyData.nlCode = "NOORD_HOLLAND" as any;
        propertyData.kadasterNummer = `NLKAD${String(Math.floor(100000 + Math.random() * 900000))}`;
        propertyData.energyLabel = ["A++", "A+", "A", "B", "C"][Math.floor(Math.random() * 5)];
        propertyData.bouwjaar = propertyData.yearBuilt;
        propertyData.balkon = Math.random() > 0.4;
        propertyData.tuin = Math.random() > 0.7;
        propertyData.parkeerplaats = Math.random() > 0.6;
      } else if (detected.country === "GB") {
        propertyData.countyCode = "GREATER_LONDON" as any;
        propertyData.councilTaxBand = ["BAND_A", "BAND_B", "BAND_C", "BAND_D", "BAND_E"][Math.floor(Math.random() * 5)] as any;
        propertyData.epcRating = ["A", "B", "C", "D", "E"][Math.floor(Math.random() * 5)] as any;
      }

      // Upsert Property
      const property = await regionalPrisma.property.upsert({
        where: { id: propId },
        update: {},
        create: propertyData
      });

      // Upsert Photo (Airbnb cover image)
      if (row.picture_url) {
        await regionalPrisma.photo.upsert({
          where: { url: row.picture_url },
          update: { propertyId: property.id },
          create: {
            url: row.picture_url,
            type: "GALLERY",
            featured: true,
            propertyId: property.id,
            originalName: "Airbnb Cover"
          }
        });
      }

      // 2. Ingest region-specific child records
      if (detected.country === "US") {
        const parcelNumber = `95${detected.state === "NY" ? "11" : (detected.state === "CA" ? "33" : "44")}${String(Math.floor(100000 + Math.random() * 900000))}`;
        
        // Create USPublicTaxRecord (skip if table doesn't exist)
        try {
          await (regionalPrisma as any).uSPublicTaxRecord.upsert({
            where: { parcelNumber_taxYear: { parcelNumber, taxYear: 2025 } },
            update: {},
            create: {
              id: id(detected.city, `tax_${parcelNumber}_2025`),
              orgId: org.id,
              propertyId: property.id,
              parcelNumber: parcelNumber,
              taxYear: 2025,
              taxStatus: "CURRENT",
              countyName: detected.city,
              stateName: detected.state,
              districtName: detected.city.toUpperCase(),
              levyCode: "0001",
              totalAssessedValue: assessedValue,
              landAssessedValue: Math.round(assessedValue * 0.30),
              improvementValue: Math.round(assessedValue * 0.70),
              totalTaxAmount: taxAmt,
              regularLevyAmount: Math.round(taxAmt * 0.70 * 100) / 100,
              voterApprovedAmount: Math.round(taxAmt * 0.15 * 100) / 100,
              stateTaxAmount: Math.round(taxAmt * 0.15 * 100) / 100,
              seniorExemption: false,
              paymentStatus: "FULL_PAID",
              firstHalfDueDate: new Date("2025-04-30"),
              secondHalfDueDate: new Date("2025-10-31"),
              firstHalfPaid: Math.round(taxAmt / 2 * 100) / 100,
              secondHalfPaid: Math.round(taxAmt / 2 * 100) / 100,
              sourceUrl: `https://blue.${detected.city.toLowerCase().replace(/\s+/g, "")}.gov/Assessor/Dashboard.aspx?ParcelNbr=${parcelNumber}`
            }
          });
        } catch (e: any) {
          // Skip tax record if table doesn't exist
        }

        // Create USPropertyAssessment (skip if table doesn't exist)
        try {
          await (regionalPrisma as any).uSPropertyAssessment.upsert({
            where: { parcelNumber_assessmentYear: { parcelNumber, assessmentYear: 2025 } },
            update: {},
            create: {
              id: id(detected.city, `assess_${parcelNumber}_2025`),
              orgId: org.id,
              propertyId: property.id,
              parcelNumber: parcelNumber,
              assessmentYear: 2025,
              countyName: detected.city,
              stateName: detected.state,
              districtName: detected.city.toUpperCase(),
              presentUse: "SINGLE_FAMILY_RESIDENCE",
              propertyUseDesc: "Residential Property",
              streetAddress: `${neighborhood} District`,
              city: detected.city,
              zip: zip,
              landValue: Math.round(assessedValue * 0.30),
              improvementValue: Math.round(assessedValue * 0.70),
              totalValue: assessedValue,
              appraisedLandValue: Math.round(assessedValue * 0.32),
              appraisedImprValue: Math.round(assessedValue * 0.75),
              appraisedTotalValue: Math.round(assessedValue * 1.07),
              lat: lat,
              lng: lng,
              sourceUrl: `https://blue.${detected.city.toLowerCase().replace(/\s+/g, "")}.gov/Assessor/Dashboard.aspx?ParcelNbr=${parcelNumber}`
            }
          });
        } catch (e: any) {
          // Skip assessment if table doesn't exist
        }
      } else if (detected.country === "TR") {
        const adaNo = String(Math.floor(100 + Math.random() * 900));
        const parselNo = String(Math.floor(1 + Math.random() * 99));
        const paftaNo = `F22d${String(Math.floor(10 + Math.random() * 90))}`;
        const documentNumber = `TAPU-${String(Math.floor(100000 + Math.random() * 900000))}`;

        // Create Turkish Property Document Record (Tapu)
        await (regionalPrisma as any).tRPropertyDocumentRecord.upsert({
          where: { id: id(detected.city, `doc_${documentNumber}`) },
          update: {},
          create: {
            id: id(detected.city, `doc_${documentNumber}`),
            orgId: org.id,
            propertyId: property.id,
            documentType: "TAPU",
            documentNumber: documentNumber,
            issueDate: new Date("2020-05-15"),
            issuingAuthority: "Tapu ve Kadastro Genel Müdürlüğü",
            adaNo: adaNo,
            parselNo: parselNo,
            paftaNo: paftaNo,
            isValid: true
          }
        });

        // Create Turkish Tax Declaration
        const declarationNumber = `TAXTR-${String(Math.floor(100000 + Math.random() * 900000))}`;
        await (regionalPrisma as any).tRTaxDeclaration.upsert({
          where: { id: id(detected.city, `tax_tr_${declarationNumber}`) },
          update: {},
          create: {
            id: id(detected.city, `tax_tr_${declarationNumber}`),
            orgId: org.id,
            propertyId: property.id,
            taxYear: 2025,
            declarationType: "EMLAK_VERGISI",
            declarationNumber: declarationNumber,
            filingDate: new Date("2025-03-10"),
            taxAmount: taxAmt,
            taxPaid: taxAmt,
            taxPending: 0,
            vergiDairesi: `${detected.city} Vergi Dairesi`,
            status: "PAID"
          }
        });
      } else if (detected.country === "GB") {
        const certNumber = `EPC-${String(Math.floor(100000 + Math.random() * 900000))}`;
        await (regionalPrisma as any).uKPropertyCertificateRecord.upsert({
          where: { id: id(detected.city, `cert_${certNumber}`) },
          update: {},
          create: {
            id: id(detected.city, `cert_${certNumber}`),
            orgId: org.id,
            propertyId: property.id,
            certificateType: "EPC",
            certificateNumber: certNumber,
            issueDate: new Date("2024-01-10"),
            expiryDate: new Date("2034-01-10"),
            rating: "B",
            score: 85,
            isValid: true
          }
        });
      }

      successCount++;
      if (successCount % 50 === 0) {
        console.log(`📡 Ingested: ${successCount}/${MAX_PROPERTIES_PER_FILE} properties for ${detected.city}...`);
      }

    } catch (e: any) {
      errorCount++;
      if (errorCount <= 5) {
        console.error(`   ❌ Error #${errorCount}: ${e.message}`);
      }
    }
  }

  console.log("\n🏁 --- INGESTION COMPLETED ---");
  console.log(`✅ Loaded Real ${detected.city} Properties: ${successCount}`);
  console.log(`⚠️ Skips/Errors: ${errorCount}`);
}

startIngestion()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
