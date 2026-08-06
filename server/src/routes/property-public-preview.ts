/**
 * Public Property Preview API
 * Anonymous access to property preview with PII filtering
 * Excludes: owner name, exact address, contract details, financial information
 */

import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { cachePropertyPreview, getCachedPropertyPreview } from "../lib/cache";

export const propertyPublicPreviewRoutes = new Elysia({ 
  prefix: "/public/property" 
})

/**
 * GET /public/property/:claimToken
 * Public property preview with PII filtering (no authentication required)
 */
.get(
  "/:claimToken",
  async ({ params, set }) => {
    const { claimToken } = params;

    // Check cache first
    const cached = await getCachedPropertyPreview(claimToken);
    if (cached) {
      return cached;
    }

    // Validate token and extract property ID
    const { validateToken } = await import("../lib/token-generator");
    const validation = await validateToken(claimToken);

    if (!validation.valid) {
      set.status = 400;
      return { error: validation.error || "Invalid token" };
    }

    const payload = validation.payload;
    if (!payload.propertyId) {
      set.status = 400;
      return { error: "Property ID required" };
    }

    // Fetch property with PII filtering
    const property = await prisma.property.findUnique({
      where: { id: payload.propertyId },
      select: {
        id: true,
        title: true,
        description: true,
        neighborhood: true,
        city: true,
        country: true,
        parcelNumber: true,
        estimatedValue: true,
        propertyType: true,
        bedrooms: true,
        bathrooms: true,
        area: true,
        yearBuilt: true,
        photos: {
          take: 5,
          select: { 
            id: true,
            url: true,
            caption: true,
          },
        },
        amenities: true,
        features: true,
        // EXCLUDE PII:
        // - owner name
        // - exact address
        // - contract details
        // - financial information
        // - owner contact
      },
    });

    if (!property) {
      set.status = 404;
      return { error: "Property not found" };
    }

    // Count interested buyers (teaser)
    const interestedCount = await prisma.propertyOwnershipVerification.count({
      where: {
        propertyId: payload.propertyId,
        verificationStatus: {
          in: ['PENDING', 'VERIFIED'],
        },
      },
    });

    // Mask parcel number for privacy (show only first 4 characters)
    const maskedParcelNumber = property.parcelNumber
      ? property.parcelNumber.substring(0, 4) + '***'
      : null;

    // Build preview response with PII filtering
    const preview = {
      id: property.id,
      title: property.title,
      description: property.description,
      location: {
        neighborhood: property.neighborhood,
        city: property.city,
        country: property.country,
        // EXACT ADDRESS REMOVED FOR PRIVACY
        parcelNumber: maskedParcelNumber,
      },
      propertyDetails: {
        type: property.propertyType,
        bedrooms: property.bedrooms,
        bathrooms: property.bathrooms,
        area: property.area,
        yearBuilt: property.yearBuilt,
      },
      estimatedValue: property.estimatedValue,
      photos: property.photos,
      amenities: property.amenities,
      features: property.features,
      teaser: {
        interestedBuyers: interestedCount > 0 ? `${interestedCount} interested buyers` : 'Be the first to claim',
        claimExpires: new Date(payload.expiresAt * 1000).toISOString(),
      },
      // EXCLUDED PII FIELDS:
      // - ownerName
      // - ownerContact
      // - exactAddress
      // - contractAmount
      // - purchasePrice
      // - rentalIncome
    };

    // Cache for 1 hour
    await cachePropertyPreview(claimToken, preview, { ttl: 3600 });

    return preview;
  },
  {
    params: t.Object({
      claimToken: t.String(),
    }),
  }
)

/**
 * GET /public/property/preview/:propertyId
 * Alternative public preview using property ID (for marketing pages)
 * Limited information, no PII
 */
.get(
  "/preview/:propertyId",
  async ({ params, set }) => {
    const { propertyId } = params;

    // Check cache
    const cacheKey = `public:preview:${propertyId}`;
    const cached = await getCachedPropertyPreview(cacheKey);
    if (cached) {
      return cached;
    }

    // Fetch minimal property information
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      select: {
        id: true,
        title: true,
        neighborhood: true,
        city: true,
        country: true,
        propertyType: true,
        bedrooms: true,
        bathrooms: true,
        area: true,
        photos: {
          take: 3,
          select: { url: true },
        },
      },
    });

    if (!property) {
      set.status = 404;
      return { error: "Property not found" };
    }

    // Very limited preview for marketing
    const preview = {
      id: property.id,
      title: property.title,
      location: {
        neighborhood: property.neighborhood,
        city: property.city,
        country: property.country,
      },
      propertyDetails: {
        type: property.propertyType,
        bedrooms: property.bedrooms,
        bathrooms: property.bathrooms,
        area: property.area,
      },
      photos: property.photos.map(p => p.url),
      teaser: "Claim this property to view full details",
    };

    // Cache for 30 minutes
    await cachePropertyPreview(cacheKey, preview, { ttl: 1800 });

    return preview;
  },
  {
    params: t.Object({
      propertyId: t.String(),
    }),
  }
);
