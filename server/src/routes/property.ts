import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { propertyService } from "../services/property";
import { 
  PropertyPlainInputCreate, 
  PropertyPlainInputUpdate 
} from "../../generated/prismabox/Property";
import { OwnershipDocumentType } from "@prisma/client";

export const propertyRoutes = new Elysia({ prefix: "/property" })
  .use(regionMiddleware)

  /**
   * GET /property
   * Retrieves all Property with pagination and basic filtering.
   */
  .get("/", async ({ query, db }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    const regionDb = db as any;
    
    // Use direct queries for relationships to avoid cross-database schema issues
    const properties = await regionDb.property.findMany({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
    
    // Manually fetch related data
    const propertyIds = properties.map((p: any) => p.id);
    const photos = await regionDb.propertyPhoto.findMany({
      where: { propertyId: { in: propertyIds } },
      orderBy: { isPrimary: 'desc' }
    });
    
    // Group photos by propertyId
    const photosByProperty = new Map();
    photos.forEach((photo: any) => {
      if (!photosByProperty.has(photo.propertyId)) {
        photosByProperty.set(photo.propertyId, []);
      }
      photosByProperty.get(photo.propertyId).push(photo);
    });
    
    // Attach photos to properties
    const propertiesWithPhotos = properties.map((property: any) => ({
      ...property,
      photos: (photosByProperty.get(property.id) || []).slice(0, 5)
    }));
    
    const total = await regionDb.property.count({ where });
    
    return { 
      data: propertiesWithPhotos, 
      total, 
      page: Math.floor((parseInt(page) - 1) / parseInt(limit)) + 1,
      limit: parseInt(limit) 
    };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * GET /property/:id
   * Retrieves a single Property by ID.
   */
  .get("/:id", async ({ params, set, db }) => {
    const regionDb = db as any;
    
    console.log(`[Property Detail] Fetching property ${params.id}`);
    console.log(`[Property Detail] Database connection type: ${regionDb.constructor.name}`);
    
    // Intercept B2B Hotel IDs (HB-*, EPS-*, WB-*, HD-*)
    const b2bPrefixes = ["HB-", "EPS-", "WB-", "HD-"];
    if (b2bPrefixes.some(prefix => params.id.startsWith(prefix))) {
      console.log(`[Property Detail] Intercepted B2B hotel: ${params.id}`);
      
      // Lookup from aggregator catalog
      const { B2BHotelAggregator } = await import("../services/b2b-hotel-aggregator");
      const allResults = await B2BHotelAggregator.searchHotels({
        destination: "turkey",
        checkIn: new Date().toISOString().split('T')[0],
        checkOut: new Date(Date.now() + 86400000).toISOString().split('T')[0],
        guests: 2
      });
      
      const hotel = allResults.find(h => h.id === params.id);
      
      if (hotel) {
        return {
          id: hotel.id,
          name: hotel.name,
          description: hotel.description,
          listingType: "BOOKING",
          listingStatus: "AVAILABLE",
          propertyCategory: "HOTEL",
          listingPrice: hotel.grossPrice,
          currency: hotel.currency,
          photos: hotel.photos.map(url => ({ url })),
          features: hotel.amenities,
          city: hotel.city,
          country: hotel.country,
          lat: hotel.lat,
          lng: hotel.lng,
          notes: `Exclusive B2B Deal from ${hotel.provider}. SafeStay™ Escrow protected.`,
          isB2B: true,
          b2bProvider: hotel.provider,
          rating: hotel.rating,
          bedrooms: 1,
          bathrooms: 1,
          areaSqm: 45
        };
      }
      
      // Fallback for unknown B2B IDs
      set.status = 404;
      return { error: "B2B hotel not found in current inventory." };
    }
    
    // Use direct query for property
    const property = await regionDb.property.findUnique({
      where: { id: params.id },
    });
    
    if (!property) {
      set.status = 404;
      return { error: "Property not found" };
    }
    
    console.log(`[Property Detail] Property found: ${property.name}`);
    
    // Manually fetch related data
    console.log(`[Property Detail] Fetching photos for property ${params.id}`);
    const photos = await regionDb.propertyPhoto.findMany({
      where: { propertyId: params.id },
      orderBy: { sortOrder: 'asc' },
    });
    
    console.log(`[Property Detail] Fetched ${photos.length} photos for property ${params.id}`);
    
    const videoContents = await regionDb.videoContent.findMany({
      where: { propertyId: params.id },
    });
    
    const propertyAmenities = await regionDb.propertyAmenity.findMany({
      where: { propertyId: params.id },
      take: 3,
      include: { amenity: true },
    });
    
    const neighborhood = (property as any).neighborhoodId 
      ? await regionDb.neighborhood.findUnique({
          where: { id: (property as any).neighborhoodId },
        })
      : null;
    
    const listings = await regionDb.listing.findMany({
      where: { propertyId: params.id },
    });
    
    const org = await regionDb.organization.findUnique({
      where: { id: (property as any).orgId },
    });
    
    const floorPlans = await regionDb.floorPlan.findMany({
      where: { propertyId: params.id },
    });
    
    const data = {
      ...property,
      photos,
      videoContents,
      amenities: propertyAmenities,
      neighborhood,
      listings,
      org,
      floorPlans,
    };
    
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * GET /property/:id/photos
   * Retrieves all photos for a property.
   */
  .get("/:id/photos", async ({ params, db }) => {
    // Use direct query to avoid relationship issues with Turkish database
    const photos = await (db as any).propertyPhoto.findMany({
      where: { propertyId: params.id },
      orderBy: { isPrimary: 'desc' },
    });
    return { data: photos || [] };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * GET /property/:id/videos
   * Retrieves all videos for a property.
   */
  .get("/:id/videos", async ({ params, db }) => {
    const property = await propertyService.withDB(db as any).getById(params.id, { agentVideos: true });
    return { data: property?.agentVideos || [] };
  }, {
    params: t.Object({ id: t.String() })
  })

  .use(authMiddleware)

  /**
   * POST /property
   * Creates a new Property.
   */
  .post("/", async ({ body, set, db }) => {
    const data = await propertyService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyPlainInputCreate
  })

  /**
   * PATCH /property/:id
   * Updates an existing Property.
   */
  .patch("/:id", async ({ params, body, set, db }) => {
    try {
      const data = await propertyService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Property not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyPlainInputUpdate
  })

  /**
   * DELETE /property/:id
   * Deletes a Property.
   */
  .delete("/:id", async ({ params, set, db }) => {
    try {
      await propertyService.withDB(db as any).delete(params.id);
      return { success: true, message: "Property deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Property not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /property/:id/claim
   * Submits an ownership claim for a property.
   */
  .post("/:id/claim", async ({ params, body, set, db, userId, orgId }) => {
    try {
      const property = await db.property.findUnique({
        where: { id: params.id }
      });

      if (!property) {
        set.status = 404;
        return { error: "Property not found" };
      }

      // Default org if not available from JWT
      let targetOrgId = orgId;
      if (!targetOrgId) {
        const defaultOrg = await db.organization.findFirst();
        targetOrgId = defaultOrg?.id;
      }
      
      if (!targetOrgId) {
        set.status = 500;
        return { error: "No organization found to attach the claim." };
      }

      // Create Verification request with Document records
      const verification = await db.propertyOwnershipVerification.create({
        data: {
          propertyId: params.id,
          orgId: targetOrgId,
          currentOwnerId: userId,
          verificationMethod: "DOCUMENT_UPLOAD",
          verificationStatus: "PENDING",
          verificationNotes: body.notes || "User submitted ownership claim from client UI.",
          documents: {
            create: body.documents.map(doc => ({
              documentType: doc.documentType as any,
              fileName: doc.fileName || "document.pdf",
              filePath: doc.fileUrl,
              fileSize: 1024,
              mimeType: "application/pdf",
              checksum: "hash_placeholder",
              uploadMethod: "CLIENT_UPLOAD",
              validationStatus: "PENDING",
              accessLevel: "RESTRICTED",
              isPublic: false,
              orgId: targetOrgId
            }))
          }
        },
        include: {
          documents: true
        }
      });

      // Also create Document records for tracking
      for (const doc of body.documents) {
        await db.document.create({
          data: {
            orgId: targetOrgId,
            title: doc.fileName || "Uploaded Document",
            documentType: "VERIFICATION" as any,
            fileUrl: doc.fileUrl,
            fileName: doc.fileName || "document.pdf",
            fileSize: 1024,
            mimeType: "application/pdf",
            checksum: "hash_placeholder",
            analysisStatus: "PENDING"
          }
        });
      }

      set.status = 201;
      return { success: true, data: verification };
    } catch (e: any) {
      console.error("Error creating ownership claim:", e);
      set.status = 500;
      return { error: "Failed to create ownership claim", details: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      notes: t.Optional(t.String()),
      documents: t.Array(t.Object({
        documentType: t.String(), // Identity, TitleDeed, etc. mapped to OwnershipDocumentType enum
        fileUrl: t.String(),
        fileName: t.Optional(t.String())
      }))
    })
  })

  /**
   * GET /property/:id/affiliate-offers
   * Retrieves simulated Metasearch/Affiliate offers along with Reservatior wholesale price.
   */
  .get("/:id/affiliate-offers", async ({ params, db }) => {
    const property = await (db as any).property.findUnique({
      where: { id: params.id },
      include: { listings: true }
    });

    if (!property) return { error: "Property not found" };
    
    // Only return offers if it's an external aggregator hotel
    if (property.orgId !== "org_google_aggregator") {
      return { data: [] };
    }

    const basePrice = property.listings?.[0]?.price ? Number(property.listings[0].price) : 200;
    const currency = property.listings?.[0]?.priceCurrency || "USD";

    // Simulate varying prices for OTAs
    const offers = [
      {
        provider: "Reservatior",
        logoUrl: "https://upload.wikimedia.org/wikipedia/commons/2/21/Solid_black.svg", // Placeholder for Reservatior Logo
        price: Math.floor(basePrice * 0.90), // The Wholesale Best Deal
        currency: currency,
        url: "",
        isBestDeal: true,
        isInternal: true
      },
      {
        provider: "Agoda",
        logoUrl: "https://upload.wikimedia.org/wikipedia/commons/c/ce/Agoda_transparent_logo.png",
        price: Math.floor(basePrice * 0.95), 
        currency: currency,
        url: `https://www.agoda.com/search?text=${encodeURIComponent(property.name)}`,
        isBestDeal: false,
        isInternal: false
      },
      {
        provider: "Booking.com",
        logoUrl: "https://upload.wikimedia.org/wikipedia/commons/b/b2/Booking.com_Logo_2022.svg",
        price: Math.floor(basePrice * 1.05),
        currency: currency,
        url: `https://www.booking.com/searchresults.html?ss=${encodeURIComponent(property.name)}`,
        isBestDeal: false,
        isInternal: false
      },
      {
        provider: "Expedia",
        logoUrl: "https://upload.wikimedia.org/wikipedia/commons/5/58/Expedia_logo.svg",
        price: Math.floor(basePrice * 1.08),
        currency: currency,
        url: `https://www.expedia.com/Hotel-Search?destination=${encodeURIComponent(property.city)}`,
        isBestDeal: false,
        isInternal: false
      }
    ];

    // Sort by price
    offers.sort((a, b) => a.price - b.price);

    return { data: offers };
  }, {
    params: t.Object({ id: t.String() })
  });
