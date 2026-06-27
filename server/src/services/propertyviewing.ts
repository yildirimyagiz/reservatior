import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyViewingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyViewing, "propertyViewing");
  }
}

export const propertyViewingService = new PropertyViewingService();
