import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AuditLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.auditLog, "auditLog");
  }
}

export const auditLogService = new AuditLogService();
