import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIModelService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIModel, "aIModel");
  }
}

export const aIModelService = new AIModelService();
