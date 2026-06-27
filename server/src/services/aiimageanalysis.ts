import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIImageAnalysisService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIImageAnalysis, "aIImageAnalysis");
  }
}

export const aIImageAnalysisService = new AIImageAnalysisService();
