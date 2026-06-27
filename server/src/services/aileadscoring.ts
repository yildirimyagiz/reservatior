import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AILeadScoringService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aILeadScoring, "aILeadScoring");
  }
}

export const aILeadScoringService = new AILeadScoringService();
