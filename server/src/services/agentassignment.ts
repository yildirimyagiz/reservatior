import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AgentAssignmentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agentAssignment, "agentAssignment");
  }
}

export const agentAssignmentService = new AgentAssignmentService();
