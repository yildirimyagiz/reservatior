import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MarketInsightService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.marketInsight, "marketInsight");
  }
}

export const marketInsightService = new MarketInsightService();
