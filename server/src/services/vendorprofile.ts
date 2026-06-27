import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VendorProfileService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.vendorProfile, "vendorProfile");
  }
}

export const vendorProfileService = new VendorProfileService();
