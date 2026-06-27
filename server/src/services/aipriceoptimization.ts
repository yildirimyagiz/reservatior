import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIPriceOptimizationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIPriceOptimization, "aIPriceOptimization");
  }
}

export const aIPriceOptimizationService = new AIPriceOptimizationService();
