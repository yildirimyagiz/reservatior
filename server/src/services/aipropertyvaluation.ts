import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIPropertyValuationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIPropertyValuation, "aIPropertyValuation");
  }
}

export const aIPropertyValuationService = new AIPropertyValuationService();
