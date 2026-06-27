import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentTeamMemberService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agentTeamMember, "agentTeamMember");
  }
}

export const agentTeamMemberService = new AgentTeamMemberService();
