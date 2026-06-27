import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AmenityService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.amenity, "amenity");
  }
}

export const amenityService = new AmenityService();
