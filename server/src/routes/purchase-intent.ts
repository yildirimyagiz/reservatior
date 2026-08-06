import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { purchaseIntentService } from "../services/purchase-intent";

export const purchaseIntentRoutes = new Elysia({ prefix: "/purchase-intents" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /purchase-intents
   * List purchase intents with pagination and filtering.
   */
  .get("/", async ({ orgId, db, query, set }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;
    if (orgId) where.orgId = orgId;
    if (query.status) where.status = query.status;
    if (query.readinessTier) where.readinessTier = query.readinessTier;

    const page = parseInt(query.page || "1");
    const limit = parseInt(query.limit || "20");

    const [data, total] = await Promise.all([
      (db as any).purchaseIntent.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: "desc" },
        include: {
          property: { select: { id: true, name: true, address: true } },
          tenant: { select: { id: true, firstName: true, lastName: true, email: true } },
        },
      }),
      (db as any).purchaseIntent.count({ where }),
    ]);

    return { data, total, page, limit };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      readinessTier: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Purchase Intents",
      description: "List purchase intents with pagination and filtering",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * POST /purchase-intents
   * Create a new purchase intent.
   */
  .post("/", async ({ orgId, db, body, set }: any) => {
    const service = purchaseIntentService.withDB(db as any);
    const data = await service.createIntent({
      ...body,
      orgId: body.orgId || orgId || "",
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.Optional(t.String()),
      leaseId: t.String(),
      propertyId: t.String(),
      tenantId: t.String(),
      targetPrice: t.Optional(t.Number()),
      estimatedDownPmt: t.Optional(t.Number()),
      monthlySavings: t.Optional(t.Number()),
      savingsGoal: t.Optional(t.Number()),
      mortgagePreApproved: t.Optional(t.Boolean()),
      maxMortgageAmount: t.Optional(t.Number()),
      preferredLender: t.Optional(t.String()),
      trustScoreAtIntent: t.Optional(t.Number()),
      targetPurchaseDate: t.Optional(t.String()),
      leaseEndSynchronizes: t.Optional(t.Boolean()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("RTO_MANAGE"),
    detail: {
      summary: "Create Purchase Intent",
      description: "Create a new rent-to-own purchase intent",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * GET /purchase-intents/org/:orgId
   * Get all purchase intents for an organization.
   */
  .get("/org/:orgId", async ({ db, params, query }) => {
    const service = purchaseIntentService.withDB(db as any);
    return service.getOrgIntents(params.orgId, {
      status: query.status,
      readinessTier: query.readinessTier,
      page: parseInt(query.page || "1"),
      limit: parseInt(query.limit || "20"),
    });
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Partial(t.Object({
      status: t.Optional(t.String()),
      readinessTier: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Organization Purchase Intents",
      description: "Get all purchase intents for an organization with filtering and pagination",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * GET /purchase-intents/:id
   * Get a single purchase intent.
   */
  .get("/:id", async ({ db, params, set }) => {
    const data = await (db as any).purchaseIntent.findUnique({
      where: { id: params.id },
      include: {
        property: true,
        tenant: true,
        lease: true,
        equityAccumulations: { orderBy: { periodStart: "desc" } },
        conversionWorkflow: true,
      },
    });
    if (!data) {
      set.status = 404;
      return { error: "PurchaseIntent not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Purchase Intent",
      description: "Get a single purchase intent with full details including property, tenant, lease, equity, and conversion data",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * PATCH /purchase-intents/:id
   * Update a purchase intent.
   */
  .patch("/:id", async ({ db, params, body, set }) => {
    try {
      const data = await (db as any).purchaseIntent.update({
        where: { id: params.id },
        data: {
          ...body,
          lastActivityAt: new Date(),
        },
      });
      return { data };
    } catch {
      set.status = 404;
      return { error: "PurchaseIntent not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Partial(t.Object({
      status: t.Optional(t.String()),
      readinessTier: t.Optional(t.String()),
      targetPrice: t.Optional(t.Number()),
      estimatedDownPmt: t.Optional(t.Number()),
      monthlySavings: t.Optional(t.Number()),
      savingsGoal: t.Optional(t.Number()),
      mortgagePreApproved: t.Optional(t.Boolean()),
      maxMortgageAmount: t.Optional(t.Number()),
      preferredLender: t.Optional(t.String()),
      targetPurchaseDate: t.Optional(t.String()),
      leaseEndSynchronizes: t.Optional(t.Boolean()),
      metadata: t.Optional(t.Any()),
    })),
    beforeHandle: hasPermission("RTO_MANAGE"),
    detail: {
      summary: "Update Purchase Intent",
      description: "Update an existing purchase intent",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * POST /purchase-intents/:id/savings
   * Add savings to a purchase intent.
   */
  .post("/:id/savings", async ({ db, params, body, set }) => {
    try {
      const service = purchaseIntentService.withDB(db as any);
      const data = await service.updateSavings(params.id, body.amount);
      return { data };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      amount: t.Number({ minimum: 0.01 }),
    }),
    beforeHandle: hasPermission("RTO_MANAGE"),
    detail: {
      summary: "Add Savings",
      description: "Add savings contribution to a purchase intent",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * GET /purchase-intents/:id/journey
   * Get the full journey summary for a purchase intent.
   */
  .get("/:id/journey", async ({ db, params, set }) => {
    try {
      const service = purchaseIntentService.withDB(db as any);
      return await service.getJourneySummary(params.id);
    } catch (e: any) {
      set.status = 404;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Purchase Journey",
      description: "Get the full journey summary for a purchase intent including milestones and progress",
      tags: ["Purchase Intent"]
    }
  })

  /**
   * POST /purchase-intents/:id/convert
   * Start the ownership conversion process.
   */
  .post("/:id/convert", async ({ db, params, body, set }) => {
    try {
      const service = purchaseIntentService.withDB(db as any);
      const data = await service.startConversion(params.id, body.purchasePrice, body.downPayment);
      set.status = 201;
      return { data };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      purchasePrice: t.Number({ minimum: 1 }),
      downPayment: t.Number({ minimum: 0 }),
    }),
    beforeHandle: hasPermission("RTO_MANAGE"),
    detail: {
      summary: "Convert Purchase Intent",
      description: "Start the ownership conversion process for a purchase intent",
      tags: ["Purchase Intent"]
    }
  });
