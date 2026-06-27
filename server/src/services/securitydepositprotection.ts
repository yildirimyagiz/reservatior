import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SecurityDepositProtectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.securityDepositProtection, "securityDepositProtection");
  }
}

export const securityDepositProtectionService = new SecurityDepositProtectionService();
