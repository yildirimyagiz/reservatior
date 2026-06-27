import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class InvestorPortfolioService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.investorPortfolio, "investorPortfolio");
  }
}

export const investorPortfolioService = new InvestorPortfolioService();
