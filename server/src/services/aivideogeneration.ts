import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AiVideoGenerationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aiVideoGeneration, "aiVideoGeneration");
  }
}

export const aiVideoGenerationService = new AiVideoGenerationService();
