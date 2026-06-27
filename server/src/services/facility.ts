import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class FacilityService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.facility, "facility");
  }
}

export const facilityService = new FacilityService();
