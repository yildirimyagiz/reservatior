import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ExpenseService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.expense, "expense");
  }
}

export const expenseService = new ExpenseService();
