import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { globalTaxRegulationService } from "./globaltaxregulation";

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
    
    return property;
  }
}

export const propertyService = new PropertyService();
