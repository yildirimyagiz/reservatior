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

    // Send to Python ml-services API (POST http://localhost:8000/api/v1/brochures/generate)
    console.log("[AIBrochureEngine] Payload ready. Transmitting to ml-services brochure endpoint...");
    
    // Create a record in DB to track Brochure Generation status
    const generationRecord = await prisma.aiBrochureGeneration.create({
      data: {
        propertyId: property.id,
        status: "PENDING",
        templateId: "modern_1",
        languageVariant: "en",
      }
    });

    try {
        const response = await fetch("http://localhost:8000/api/v1/brochures/generate", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                property_id: property.id,
                template: "modern_1",
                custom_photos: property.photos.map(p => p.url),
                title: property.name,
                address: `${property.addressLine1}, ${property.city}`,
                price: property.listingPrice?.toNumber() || 0,
                bedrooms: property.bedrooms,
                bathrooms: property.bathrooms,
                sqft: property.areaSqm,
                description: "Amazing property with luxury amenities."
            })
        });

        if (!response.ok) {
            throw new Error(`Python API responded with ${response.status}: ${await response.text()}`);
        }

        const buffer = await response.arrayBuffer();
        
        // Save the generated brochure buffer to disk or upload to Cloudinary/S3
        const fs = require('fs');
        const path = require('path');
        const outDir = path.join(process.cwd(), 'data', 'brochures');
        if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });
        const filePath = path.join(outDir, `${property.id}_brochure.pdf`);
        fs.writeFileSync(filePath, Buffer.from(buffer));
        
        await prisma.aiBrochureGeneration.update({
            where: { id: generationRecord.id },
            data: { status: "COMPLETED" } // Wait, Prisma doesn't have a file URL field here, but status is updated
        });

        return {
            status: "Success",
            generationId: generationRecord.id,
            filePath: filePath,
            payload: brochurePayload
        };
    } catch (e: any) {
        console.error("[AIBrochureEngine] Failed to generate brochure:", e);
        await prisma.aiBrochureGeneration.update({
            where: { id: generationRecord.id },
            data: { status: "FAILED" }
        });
        throw e;
    }
  }
}
