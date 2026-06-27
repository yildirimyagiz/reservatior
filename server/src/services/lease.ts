import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LeaseService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.lease, "lease");
  }
}

export const leaseService = new LeaseService();
