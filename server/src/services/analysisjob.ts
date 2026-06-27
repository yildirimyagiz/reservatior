import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AnalysisJobService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.analysisJob, "analysisJob");
  }
}

export const analysisJobService = new AnalysisJobService();
