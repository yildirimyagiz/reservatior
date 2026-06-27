import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LeadService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.lead, "lead");
  }
}

export const leadService = new LeadService();
