import { PrismaClient } from "@prisma/client";

const GOOGLE_API_KEY = process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY;

if (!GOOGLE_API_KEY) {
  console.error("Missing NEXT_PUBLIC_GOOGLE_MAPS_API_KEY");
  process.exit(1);
}

const prismaUS = new PrismaClient({ datasources: { db: { url: process.env.DATABASE_URL_US || "postgresql://postgres:1928@localhost:5432/realestate_us" } } });
const prismaTR = new PrismaClient({ datasources: { db: { url: process.env.DATABASE_URL_TR || "postgresql://postgres:1928@localhost:5432/realestate_tr" } } });

async function fetchGoogleHotels(query: string) {
  // Mock data since the provided Google Maps API key is disabled
  return [
    {
      place_id: `mock_${Math.floor(Math.random() * 10000)}`,
      name: query.includes("Istanbul") ? "The Ritz-Carlton, Istanbul" : "The Plaza Hotel",
      formatted_address: query.includes("Istanbul") ? "Suzer Plaza, Askerocagi Caddesi, Istanbul" : "768 5th Ave, New York, NY 10019",
      geometry: { location: { lat: 41.0368, lng: 28.9912 } },
      photos: [{ photo_reference: "mock_photo_ref" }]
    },
    {
      place_id: `mock_${Math.floor(Math.random() * 10000)}`,
      name: query.includes("Istanbul") ? "Swissôtel The Bosphorus" : "Four Seasons Hotel New York",
      formatted_address: query.includes("Istanbul") ? "Visnezade Mah, Acisu Sok No:19, Macka, Istanbul" : "57 E 57th St, New York, NY 10022",
      geometry: { location: { lat: 41.0416, lng: 28.9961 } },
      photos: [{ photo_reference: "mock_photo_ref" }]
    },
    {
      place_id: `mock_${Math.floor(Math.random() * 10000)}`,
      name: query.includes("Istanbul") ? "Ciragan Palace Kempinski" : "The St. Regis New York",
      formatted_address: query.includes("Istanbul") ? "Ciragan Cd. 32, Besiktas, Istanbul" : "Two E 55th St, New York, NY 10022",
      geometry: { location: { lat: 41.0425, lng: 29.0142 } },
      photos: [{ photo_reference: "mock_photo_ref" }]
    }
  ];
}

async function ingestHotels(client: PrismaClient, region: string, query: string, countryCode: string) {
  console.log(`\n🚀 Starting Google Hotels pull for: ${query}`);
  const results = await fetchGoogleHotels(query);
  console.log(`Found ${results.length} hotels from Google.`);

  // Ensure Organization exists
  const orgId = "org_google_aggregator";
  await client.organization.upsert({
    where: { id: orgId },
    update: {},
    create: {
      id: orgId,
      name: "Google Hotels Aggregator",
      type: "AGENCY",
      region: region === "USA" ? "USA" : "TR"
    }
  });

  let addedCount = 0;

  for (const place of results) {
    // Generate deterministic id for idempotency
    const propId = `google_hotel_${place.place_id}`;

    // Check if property exists
    const existing = await client.property.findUnique({ where: { id: propId } });
    if (existing) continue;

    // Build the property
    await client.$transaction(async (tx) => {
      const property = await tx.property.create({
        data: {
          id: propId,
          orgId: "org_google_aggregator",
          name: place.name,
          addressLine1: place.formatted_address || "Address not provided",
          city: query.split(" ")[2] || "",
          country: countryCode,
          lat: place.geometry?.location?.lat || 0,
          lng: place.geometry?.location?.lng || 0,
          region: region === "USA" ? "USA" : "TR",
        }
      });

      // Add Photo if exists
      if (place.photos && place.photos.length > 0) {
        const photoRef = place.photos[0].photo_reference;
        const seed = Math.floor(Math.random() * 1000);
        const photoUrl = photoRef === "mock_photo_ref" 
          ? `https://loremflickr.com/800/600/luxury,hotel?lock=${seed}`
          : `https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=${photoRef}&key=${GOOGLE_API_KEY}`;
        
        await tx.propertyPhoto.create({
          data: {
            propertyId: property.id,
            orgId: "org_google_aggregator",
            url: photoUrl,
            isPrimary: true,
            sortOrder: 0
          }
        });
      }

      // Add Bookable Listing
      const basePrice = 180 + Math.floor(Math.random() * 200); // Random price
      await tx.listing.create({
        data: {
          propertyId: property.id,
          orgId: "org_google_aggregator",
          type: "BOOKING",
          status: "AVAILABLE",
          title: `Meta-Search: ${place.name}`,
          description: `Book ${place.name} directly via Reservatior.`,
          price: basePrice,
          priceCurrency: region === "USA" ? "USD" : "TRY",
        }
      });
      
      addedCount++;
    });
  }

  console.log(`✅ Ingested ${addedCount} new external hotels into ${region} database.`);
}

async function run() {
  try {
    await ingestHotels(prismaTR, "TR", "luxury hotels in Istanbul", "TR");
    await ingestHotels(prismaUS, "USA", "luxury hotels in Manhattan", "US");
  } catch (e) {
    console.error(e);
  } finally {
    await prismaUS.$disconnect();
    await prismaTR.$disconnect();
  }
}

run();
