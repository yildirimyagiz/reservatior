import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIFraudDetectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIFraudDetection, "aIFraudDetection");
  }
}

export const aIFraudDetectionService = new AIFraudDetectionService();
