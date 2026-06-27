import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RecommendationResultService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.recommendationResult, "recommendationResult");
  }
}

export const recommendationResultService = new RecommendationResultService();
