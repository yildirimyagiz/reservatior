import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ProjectReportService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.projectReport, "projectReport");
  }
}

export const projectReportService = new ProjectReportService();
