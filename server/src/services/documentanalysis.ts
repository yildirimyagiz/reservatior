import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DocumentAnalysisService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.documentAnalysis, "documentAnalysis");
  }
}

export const documentAnalysisService = new DocumentAnalysisService();
