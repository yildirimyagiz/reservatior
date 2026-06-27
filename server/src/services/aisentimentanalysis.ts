import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AISentimentAnalysisService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aISentimentAnalysis, "aISentimentAnalysis");
  }
}

export const aISentimentAnalysisService = new AISentimentAnalysisService();
