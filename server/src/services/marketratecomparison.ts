import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MarketRateComparisonService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.marketRateComparison, "marketRateComparison");
  }
}

export const marketRateComparisonService = new MarketRateComparisonService();
