import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyValuationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyValuation, "propertyValuation");
  }
}

export const propertyValuationService = new PropertyValuationService();
