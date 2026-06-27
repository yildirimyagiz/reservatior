import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentVideoService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agentVideo, "agentVideo");
  }
}

export const agentVideoService = new AgentVideoService();
