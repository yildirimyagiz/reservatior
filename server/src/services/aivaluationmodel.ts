import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIValuationModelService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIValuationModel, "aIValuationModel");
  }
}

export const aIValuationModelService = new AIValuationModelService();
