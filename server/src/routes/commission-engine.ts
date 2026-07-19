import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { commissionEngine } from "../services/commission-engine";
import { prisma } from "../lib/prisma";

export const commissionEngineRoutes = new Elysia({ prefix: "/commission-engine" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    const [data, total] = await Promise.all([
      prisma.commission.findMany({
        where,
        skip: (parseInt(page) - 1) * parseInt(limit),
        take: parseInt(limit),
        orderBy: { createdAt: "desc" },
        include: { revenueShares: true },
      }),
      prisma.commission.count({ where }),
    ]);
    return {
      data,
      total,
      page: Math.floor((parseInt(page) - 1) / parseInt(limit)) + 1,
      limit: parseInt(limit),
    };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      agentId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      type: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Commissions",
      description: "List all commissions with pagination and filtering",
      tags: ["Commerce OS"]
    }
  })

  .get("/agent/:agentId", async ({ params }) => {
    return commissionEngine.getAgentSummary(params.agentId);
  }, {
    params: t.Object({ agentId: t.String() }),
    detail: {
      summary: "Get Agent Commission Summary",
      description: "Get commission summary for a specific agent",
      tags: ["Commerce OS"]
    }
  })

  .get("/platform/summary", async ({ query }) => {
    const { orgId, startDate, endDate } = query as any;
    return commissionEngine.getPlatformSummary(
      orgId,
      startDate ? new Date(startDate) : undefined,
      endDate ? new Date(endDate) : undefined
    );
  }, {
    query: t.Object({
      orgId: t.String(),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
    }),
    detail: {
      summary: "Get Platform Revenue Summary",
      description: "Get platform revenue summary from commissions",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await prisma.commission.findUnique({
      where: { id: params.id },
      include: { revenueShares: true },
    });
    if (!data) {
      set.status = 404;
      return { error: "Commission not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Commission",
      description: "Get a single commission by ID",
      tags: ["Commerce OS"]
    }
  })

  .post("/calculate", async ({ body, set }) => {
    const data = await commissionEngine.calculate(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      sourceType: t.String(),
      sourceId: t.String(),
      type: t.String(),
      basisAmount: t.Number(),
      rate: t.Number(),
      agentId: t.Optional(t.String()),
      campaignId: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Calculate Commission",
      description: "Calculate and record commission for an order/sale",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id/approve", async ({ params, set }) => {
    try {
      const data = await commissionEngine.approve(params.id);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Commission not found or approval failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Approve Commission",
      description: "Approve a commission for payment",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id/pay", async ({ params, body, set }) => {
    try {
      const data = await commissionEngine.markPaid(params.id, body.paymentRef);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Commission not found or payment marking failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ paymentRef: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Mark Commission as Paid",
      description: "Mark a commission as paid with payment reference",
      tags: ["Commerce OS"]
    }
  });
