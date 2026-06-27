import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ValuationReportService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.valuationReport, "valuationReport");
  }
}

export const valuationReportService = new ValuationReportService();
