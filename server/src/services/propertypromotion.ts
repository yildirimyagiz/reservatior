import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyPromotionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyPromotion, "propertyPromotion");
  }
}

export const propertyPromotionService = new PropertyPromotionService();
