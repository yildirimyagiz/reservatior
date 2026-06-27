import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CommissionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.commission, "commission");
  }
}

export const commissionService = new CommissionService();
