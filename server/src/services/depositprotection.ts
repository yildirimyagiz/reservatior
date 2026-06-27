import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DepositProtectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.depositProtection, "depositProtection");
  }
}

export const depositProtectionService = new DepositProtectionService();
