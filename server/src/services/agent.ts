import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agent, "agent");
  }
}

export const agentService = new AgentService();
