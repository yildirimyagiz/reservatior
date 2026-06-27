import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentPerformanceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agentPerformance, "agentPerformance");
  }
}

export const agentPerformanceService = new AgentPerformanceService();
