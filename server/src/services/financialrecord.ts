import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class FinancialRecordService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.financialRecord, "financialRecord");
  }
}

export const financialRecordService = new FinancialRecordService();
