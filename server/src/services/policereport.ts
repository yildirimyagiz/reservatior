import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PoliceReportService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.policeReport, "policeReport");
  }
}

export const policeReportService = new PoliceReportService();
