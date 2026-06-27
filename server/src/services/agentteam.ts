import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentTeamService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agentTeam, "agentTeam");
  }
}

export const agentTeamService = new AgentTeamService();
