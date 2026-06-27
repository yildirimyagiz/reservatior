import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIRecommendationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIRecommendation, "aIRecommendation");
  }
}

export const aIRecommendationService = new AIRecommendationService();
