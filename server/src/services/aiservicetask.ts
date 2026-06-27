import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AiServiceTaskService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aiServiceTask, "aiServiceTask");
  }
}

export const aiServiceTaskService = new AiServiceTaskService();
