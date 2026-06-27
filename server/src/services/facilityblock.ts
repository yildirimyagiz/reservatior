import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class FacilityBlockService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.facilityBlock, "facilityBlock");
  }
}

export const facilityBlockService = new FacilityBlockService();
