import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIMarketAnalysisService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIMarketAnalysis, "aIMarketAnalysis");
  }
}

export const aIMarketAnalysisService = new AIMarketAnalysisService();
