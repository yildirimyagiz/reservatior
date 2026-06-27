import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class TenantApplicationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.tenantApplication, "tenantApplication");
  }
}

export const tenantApplicationService = new TenantApplicationService();
