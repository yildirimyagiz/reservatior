import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIPredictionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIPrediction, "aIPrediction");
  }
}

export const aIPredictionService = new AIPredictionService();
