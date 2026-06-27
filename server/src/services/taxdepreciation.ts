import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class TaxDepreciationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.taxDepreciation, "taxDepreciation");
  }
}

export const taxDepreciationService = new TaxDepreciationService();
