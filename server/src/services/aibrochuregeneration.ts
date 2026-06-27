import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AiBrochureGenerationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aiBrochureGeneration, "aiBrochureGeneration");
  }
}

export const aiBrochureGenerationService = new AiBrochureGenerationService();
