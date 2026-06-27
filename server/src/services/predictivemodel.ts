import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PredictiveModelService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.predictiveModel, "predictiveModel");
  }
}

export const predictiveModelService = new PredictiveModelService();
