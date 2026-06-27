import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VendorEarningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.vendorEarning, "vendorEarning");
  }
}

export const vendorEarningService = new VendorEarningService();
