import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AiExtractedDataService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aiExtractedData, "aiExtractedData");
  }
}

export const aiExtractedDataService = new AiExtractedDataService();
