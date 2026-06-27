import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ReportService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.report, "report");
  }
}

export const reportService = new ReportService();
