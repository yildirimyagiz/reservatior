import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyAmenityService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyAmenity, "propertyAmenity");
  }
}

export const propertyAmenityService = new PropertyAmenityService();
