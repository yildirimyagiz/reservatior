import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { globalTaxRegulationService } from "./globaltaxregulation";
import { AISeoTagGenerator } from "./ai/ai-seo-tag-generator";

export class PropertyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.property, 'property');
  }

  override async create(data: any, include?: any) {
    const property = await super.create(data, include);
    
    // Automatically provision tax regulations based on property country
    if (property.country) {
      await globalTaxRegulationService.autoProvision(
        property.id, 
        property.orgId, 
        property.country
      );
    }
    
    // Automatically create a Listing and generate SEO tags
    try {
      const listing = await prisma.listing.create({
        data: {
          orgId: property.orgId,
          propertyId: property.id,
          type: property.listingType || "SALE",
          status: property.listingStatus || "AVAILABLE",
          title: property.name,
          price: property.listingPrice,
          priceCurrency: property.currency
        }
      });
      
      // Asynchronously generate SEO tags
      AISeoTagGenerator.generateTagsForListing(property.id, listing.id).catch(err => {
        console.error("Background AI Tag Generation failed:", err);
      });
    } catch (e) {
      console.error("Failed to auto-create Listing for Property:", e);
    }
    
    return property;
  }
}

export const propertyService = new PropertyService();
