import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIModelDeploymentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIModelDeployment, "aIModelDeployment");
  }
}

export const aIModelDeploymentService = new AIModelDeploymentService();
