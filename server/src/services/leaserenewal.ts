import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LeaseRenewalService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.leaseRenewal, "leaseRenewal");
  }
}

export const leaseRenewalService = new LeaseRenewalService();
