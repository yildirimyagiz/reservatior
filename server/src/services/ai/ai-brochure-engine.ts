import { prisma } from "../../lib/prisma";

/**
 * AIBrochureEngine bridges the gap between the NodeJS application and the Python ML-Services.
 * It compiles all property data, images, and valuation details into a structured Payload
 * that the python backend can convert into a high-quality PDF/Video Brochure.
 */
export class AIBrochureEngine {
  /**
   * Prepares a property to be generated into a Brochure by the ML Services.
   */
  static async prepareBrochureData(propertyId: string) {
    console.log(`[AIBrochureEngine] Compiling brochure data for property ${propertyId}...`);
    
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: {
        location: true,
        amenities: { include: { amenity: true } },
        valuations: { orderBy: { valuationDate: 'desc' }, take: 1 },
        photos: true,
      }
    });

    if (!property) throw new Error("Property not found");

    // Retrieve the latest AI valuation to include in the brochure
    const latestValuation = property.valuations?.[0] || null;

    const brochurePayload = {
      propertyId: property.id,
      title: property.name,
      address: `${property.addressLine1}, ${property.city}`,
      specs: {
        bedrooms: property.bedrooms,
        bathrooms: property.bathrooms,
        areaSqm: property.areaSqm,
        yearBuilt: property.yearBuilt,
      },
      financials: {
        listingPrice: property.listingPrice?.toNumber() || 0,
        currency: property.currency,
        aiEstimatedValue: latestValuation ? latestValuation.value : null,
        aiConfidenceScore: latestValuation ? latestValuation.confidence : null,
      },
      amenities: property.amenities.map(a => a.amenity.name),
      // In a real system, we would pass S3/Cloudinary URLs to the Python ml-services
      imageUrls: property.photos.map(p => p.url),
      instructions: "Generate a premium Dark & Gold themed PDF brochure highlighting the AI Valuation and Luxury amenities.",
    };

    // Simulate sending to Python ml-services API (e.g., POST http://localhost:8000/api/brochure/generate)
    console.log("[AIBrochureEngine] Payload ready. Transmitting to ml-services/classifier & video-neural-engine...");
    
    // Create a record in DB to track Brochure Generation status
    // Utilizing the AiBrochureGeneration model in Prisma
    const generationRecord = await prisma.aiBrochureGeneration.create({
      data: {
        propertyId: property.id,
        orgId: property.orgId,
        status: "PENDING",
        layoutType: "LUXURY_DARK_GOLD",
        language: "en",
        generationDate: new Date(),
      }
    });

    return {
      status: "Processing by ML Services",
      generationId: generationRecord.id,
      payload: brochurePayload
    };
  }
}
