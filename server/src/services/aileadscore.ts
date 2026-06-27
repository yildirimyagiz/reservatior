import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AILeadScoreService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aILeadScore, "aILeadScore");
  }
}

export const aILeadScoreService = new AILeadScoreService();
