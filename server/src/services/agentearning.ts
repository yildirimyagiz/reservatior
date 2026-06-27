import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentEarningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agentEarning, "agentEarning");
  }
}

export const agentEarningService = new AgentEarningService();
