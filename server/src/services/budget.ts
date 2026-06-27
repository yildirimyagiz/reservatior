import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class BudgetService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.budget, "budget");
  }
}

export const budgetService = new BudgetService();
