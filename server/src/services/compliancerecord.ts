import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ComplianceRecordService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.complianceRecord, "complianceRecord");
  }
}

export const complianceRecordService = new ComplianceRecordService();
