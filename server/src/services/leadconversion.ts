import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LeadConversionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.leadConversion, "leadConversion");
  }
}

export const leadConversionService = new LeadConversionService();
