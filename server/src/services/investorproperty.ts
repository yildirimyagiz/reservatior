import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class InvestorPropertyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.investorProperty, "investorProperty");
  }
}

export const investorPropertyService = new InvestorPropertyService();
