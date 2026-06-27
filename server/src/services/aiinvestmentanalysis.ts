import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIInvestmentAnalysisService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIInvestmentAnalysis, "aIInvestmentAnalysis");
  }
}

export const aIInvestmentAnalysisService = new AIInvestmentAnalysisService();
