import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LeadSourceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.leadSource, "leadSource");
  }
}

export const leadSourceService = new LeadSourceService();
