import { Elysia, t } from "elysia";
import { aiAgentOrchestratorService, AgentRole, AgentStatus, TaskPriority, TaskStatus } from "../services/ai-agent/agent-orchestrator.service";

/**
 * AI Agent OS - AI agent management and orchestration
 * Manages AI agents for various roles: Leasing Agent, Property Manager, Financial Analyst, Compliance Agent
 * Extends AI OS and Decision Intelligence OS
 */
export const aiAgentOSRoutes = new Elysia({
  prefix: "/api/v1/ai-agent-os",
})
  // Create agent
  .post("/agent", async ({ body }) => {
    try {
      const agent = await aiAgentOrchestratorService.createAgent(
        body.role as AgentRole,
        body.name,
        body.capabilities
      );
      return { success: true, agent };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      role: t.String(),
      name: t.String(),
      capabilities: t.Array(t.String()),
    }),
    detail: { summary: "Create AI Agent", tags: ["AI Agent OS"] },
  })

  // Get agent
  .get("/agent/:agentId", async ({ params }) => {
    try {
      const agent = await aiAgentOrchestratorService.getAgent(params.agentId);
      return { success: true, agent };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ agentId: t.String() }),
    detail: { summary: "Get AI Agent", tags: ["AI Agent OS"] },
  })

  // Get available agents for role
  .get("/agents/available/:role", async ({ params }) => {
    try {
      const agents = await aiAgentOrchestratorService.getAvailableAgents(params.role as AgentRole);
      return { success: true, agents };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ role: t.String() }),
    detail: { summary: "Get Available Agents", tags: ["AI Agent OS"] },
  })

  // Assign task to agent
  .post("/task", async ({ body }) => {
    try {
      const task = await aiAgentOrchestratorService.assignTask(
        body.agentId,
        body.type,
        body.priority as TaskPriority,
        body.input
      );
      return { success: true, task };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      agentId: t.String(),
      type: t.String(),
      priority: t.String(),
      input: t.Any(),
    }),
    detail: { summary: "Assign Task to Agent", tags: ["AI Agent OS"] },
  })

  // Get agent performance
  .get("/agent/:agentId/performance", async ({ params }) => {
    try {
      const performance = await aiAgentOrchestratorService.getAgentPerformance(params.agentId);
      return { success: true, performance };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ agentId: t.String() }),
    detail: { summary: "Get Agent Performance", tags: ["AI Agent OS"] },
  })

  // Scale agents
  .post("/agents/scale", async ({ body }) => {
    try {
      const scaled = await aiAgentOrchestratorService.scaleAgents(
        body.role as AgentRole,
        body.targetCount
      );
      return { success: true, scaled };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      role: t.String(),
      targetCount: t.Number(),
    }),
    detail: { summary: "Scale Agents", tags: ["AI Agent OS"] },
  })

  // Get agent dashboard
  .get("/dashboard", async () => {
    try {
      const dashboard = await aiAgentOrchestratorService.getAgentDashboard();
      return { success: true, dashboard };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "AI Agent Dashboard", tags: ["AI Agent OS"] },
  });
