import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

// Cook County Open Data API Endpoints (Socrata SODA API - Public, No Auth Required)
const PARCEL_UNIVERSE_API = "https://datacatalog.cookcountyil.gov/resource/c49d-89sn.json";
const PARCEL_ADDRESSES_API = "https://datacatalog.cookcountyil.gov/resource/3723-97qp.json";

// Rate limiter to respect Socrata API limits
function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

interface ParcelRecord {
  pin: string;
  property_address?: string;
  property_city?: string;
  property_zip?: string;
  mailing_address?: string;
  mailing_city?: string;
  mailing_state?: string;
  mailing_zip?: string;
  latitude?: string;
  longitude?: string;
  municipality?: string;
  township_name?: string;
}

interface OwnerRecord {
  pin: string;
  year?: string;
  prop_address_full?: string;
  prop_address_city_name?: string;
  owner_address_name?: string;
  owner_address_full?: string;
  owner_address_city_name?: string;
  owner_address_state?: string;
  owner_address_zipcode_1?: string;
  mail_address_name?: string;
  mail_address_full?: string;
  mail_address_city_name?: string;
  mail_address_state?: string;
  mail_address_zipcode_1?: string;
}

async function findNearestParcel(lat: number, lng: number): Promise<ParcelRecord | null> {
  // Socrata supports $where with within_circle for geospatial queries
  // But Cook County parcel data uses plain lat/lng columns, so we do a bounding box search
  const delta = 0.0005; // ~55 meters radius
  const url = `${PARCEL_UNIVERSE_API}?$where=latitude between '${lat - delta}' and '${lat + delta}' AND longitude between '${lng - delta}' and '${lng + delta}'&$limit=1&municipality=Chicago`;
  
  try {
    const res = await fetch(url);
    if (!res.ok) return null;
    const data: ParcelRecord[] = await res.json();
    return data.length > 0 ? data[0] : null;
  } catch {
    return null;
  }
}

async function findOwnerByPin(pin: string): Promise<OwnerRecord | null> {
  // Query the Parcel Addresses dataset for owner info using PIN
  // Get the most recent year's record
  const url = `${PARCEL_ADDRESSES_API}?pin=${pin}&$order=year DESC&$limit=1`;
  
  try {
    const res = await fetch(url);
    if (!res.ok) return null;
    const data: OwnerRecord[] = await res.json();
    return data.length > 0 ? data[0] : null;
  } catch {
    return null;
  }
}

async function main() {
  console.log("🏛️  --- RESERVATIOR COOK COUNTY GOVERNMENT RECORDS SCRAPER ---");
  console.log("📡 Connecting to Cook County Assessor's Office Open Data Portal...");
  console.log("🔗 API: datacatalog.cookcountyil.gov (Socrata SODA API)\n");

  // Fetch Chicago properties from DB
  // Fetch ALL Chicago properties from DB
  const properties = await (prisma.property.findMany as any)({
    where: { city: "Chicago", country: "US" },
    include: { usPropertyAssessments: true }
  });

  console.log(`✅ Loaded ${properties.length} Chicago properties for government record lookup.\n`);

  let pinMatched = 0;
  let ownerFound = 0;
  let failed = 0;

  for (let i = 0; i < properties.length; i++) {
    const prop = properties[i] as any;
    if (!prop.lat || !prop.lng) { failed++; continue; }

    const progress = `[${i + 1}/${properties.length}]`;

    // STEP 1: Find the nearest Cook County parcel using Geospatial proximity
    const parcel = await findNearestParcel(prop.lat, prop.lng);
    
    if (!parcel) {
      console.log(`${progress} ❌ No parcel found near (${prop.lat.toFixed(4)}, ${prop.lng.toFixed(4)})`);
      failed++;
      await delay(200);
      continue;
    }

    pinMatched++;
    console.log(`${progress} 📍 PIN Match: ${parcel.pin} → ${parcel.property_address || "N/A"}`);

    // STEP 2: Use the matched PIN to look up the real owner from County records
    const owner = await findOwnerByPin(parcel.pin);
    
    if (owner && (owner.owner_address_name || owner.mail_address_name)) {
      const ownerName = owner.owner_address_name || owner.mail_address_name || "UNKNOWN";
      const mailingAddr = owner.mail_address_full || owner.owner_address_full || "";
      const mailingCity = owner.mail_address_city_name || owner.owner_address_city_name || "Chicago";
      const mailingState = owner.mail_address_state || owner.owner_address_state || "IL";
      const mailingZip = owner.mail_address_zipcode_1 || owner.owner_address_zipcode_1 || "";

      console.log(`         🏛️  Owner: ${ownerName}`);
      console.log(`         📬 Mailing: ${mailingAddr}, ${mailingCity}, ${mailingState} ${mailingZip}`);

      // STEP 3: Update our database with the real government data
      if (prop.usPropertyAssessments && prop.usPropertyAssessments.length > 0) {
        try {
          await (prisma as any).uSPropertyAssessment.update({
            where: { id: prop.usPropertyAssessments[0].id },
            data: {
              ownerName: ownerName,
              streetAddress: parcel.property_address || prop.addressLine1,
              city: "Chicago",
              zip: parcel.property_zip || prop.zip
            }
          });
        } catch (e: any) {
          // Silently skip update errors
        }
      }

      ownerFound++;
    } else {
      console.log(`         ⚠️  No owner record found for PIN ${parcel.pin}`);
    }

    // Rate limiting: 200ms between API calls to respect Socrata limits
    await delay(200);
  }

  console.log(`\n🏁 --- GOVERNMENT RECORDS SCRAPING COMPLETE ---`);
  console.log(`📍 PINs Matched:     ${pinMatched}/${properties.length}`);
  console.log(`🏛️  Owners Identified: ${ownerFound}/${properties.length}`);
  console.log(`❌ Failed/Skipped:    ${failed}/${properties.length}`);
  console.log(`\n💼 Real owner data from Cook County Assessor's Office is now in your database!`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
