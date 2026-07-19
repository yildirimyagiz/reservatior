import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { commerceAgentService } from "../services/commerce-agent";

export const commerceAgentRoutes = new Elysia({ prefix: "/commerce-agents" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return commerceAgentService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Commerce Agents",
      description: "List all commerce agents with pagination",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await commerceAgentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Agent not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Commerce Agent",
      description: "Get a single agent by ID",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id/performance", async ({ params, set }) => {
    const data = await commerceAgentService.getPerformanceStats(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Agent not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Agent Performance",
      description: "Get agent performance stats (sales, revenue, ratings)",
      tags: ["Commerce OS"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await commerceAgentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      email: t.String(),
      phone: t.Optional(t.String()),
      imageUrl: t.Optional(t.String()),
      licenseNumber: t.Optional(t.String()),
      agencyName: t.Optional(t.String()),
      specializations: t.Optional(t.Any()),
      baseCommissionRate: t.Optional(t.Number()),
      bonusThreshold: t.Optional(t.Number()),
      bonusRate: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Create Commerce Agent",
      description: "Register a new agent partner",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await commerceAgentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Agent not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      email: t.Optional(t.String()),
      phone: t.Optional(t.String()),
      imageUrl: t.Optional(t.String()),
      licenseNumber: t.Optional(t.String()),
      agencyName: t.Optional(t.String()),
      specializations: t.Optional(t.Any()),
      baseCommissionRate: t.Optional(t.Number()),
      bonusThreshold: t.Optional(t.Number()),
      bonusRate: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Update Commerce Agent",
      description: "Update an existing agent",
      tags: ["Commerce OS"]
    }
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await commerceAgentService.delete(params.id);
      return { success: true, message: "Agent deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Agent not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Delete Commerce Agent",
      description: "Delete an agent",
      tags: ["Commerce OS"]
    }
  });
