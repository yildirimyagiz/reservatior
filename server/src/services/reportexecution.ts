import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ReportExecutionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.reportExecution, "reportExecution");
  }
}

export const reportExecutionService = new ReportExecutionService();
