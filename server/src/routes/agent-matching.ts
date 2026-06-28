import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentMatchingService, LeadMatchingParams, AgentPerformanceData } from "../services/agent-matching";

export const agentMatchingRoutes = new Elysia({ prefix: "/agent-matching" })
  .use(authMiddleware)

  /**
   * POST /agent-matching/match
   * Takes lead details + an array of available agents, returning the 3 segmented candidates.
   */
  .post("/match", async ({ body, set }) => {
    const { leadParams, availableAgents } = body;
    try {
      const candidates = await agentMatchingService.matchLeadToAgents(
        leadParams as LeadMatchingParams,
        availableAgents as AgentPerformanceData[]
      );
      return { success: true, candidates };
    } catch (e: any) {
      set.status = 500;
      return { error: e.message || "Failed to match agents" };
    }
  }, {
    body: t.Object({
      leadParams: t.Object({
        region: t.String(),
        propertyType: t.String(),
        activityLevel: t.String()
      }),
      availableAgents: t.Array(t.Object({
        agentId: t.String(),
        name: t.String(),
        responseSpeedMinutes: t.Number(),
        successRate: t.Number(),
        availability: t.Boolean(),
        recentActivityScore: t.Number()
      }))
    })
  })

  /**
   * POST /agent-matching/select
   * Registers user choice and consumes the selected agent's visibility budget.
   */
  .post("/select", async ({ body, set, orgId }) => {
    const { agentId } = body;
    try {
      const updatedBudget = await agentMatchingService.selectAgentAndConsumeBudget(agentId);
      
      // Emit matching audit event
      const { prismaManager } = await import("../lib/prisma");
      const prisma = prismaManager.getClient();
      
      await prisma.auditLog.create({
        data: {
          action: "AGENT_SELECTED_MATCH",
          entityType: "Agent",
          entityId: agentId,
          details: `Agent selected through matching engine. Current budget utilization: ${updatedBudget.used}/${updatedBudget.budget}`,
          orgId: orgId || "GLOBAL"
        }
      }).catch(console.warn);

      return { success: true, data: updatedBudget };
    } catch (e: any) {
      set.status = 500;
      return { error: e.message || "Failed to select agent" };
    }
  }, {
    body: t.Object({
      agentId: t.String()
    })
  });
