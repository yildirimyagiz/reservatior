import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LegalComplianceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.legalCompliance, "legalCompliance");
  }
}

export const legalComplianceService = new LegalComplianceService();
