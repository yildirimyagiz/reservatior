import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { reoPortfolioService } from "../services/reo-portfolio";

export const reoPortfolioRoutes = new Elysia({ prefix: "/institutional-portfolios" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /institutional-portfolios
   * List institutional portfolios with pagination and filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    if (orgId) where.orgId = orgId;

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const take = parseInt(limit);

    const [data, total] = await Promise.all([
      (db as any).institutionalPortfolio.findMany({
        where,
        skip,
        take,
        orderBy: { createdAt: "desc" },
        include: { holdings: true },
      }),
      (db as any).institutionalPortfolio.count({ where }),
    ]);

    return { data, total, page: parseInt(page), limit: take };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      ownerType: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Institutional Portfolios",
      description: "List institutional REO portfolios with pagination and filtering",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * POST /institutional-portfolios
   * Create a new institutional portfolio.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const service = reoPortfolioService.withDB(db as any);
    const data = await service.createPortfolio({
      ...body,
      orgId: body.orgId || orgId,
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.Optional(t.String()),
      name: t.String(),
      description: t.Optional(t.String()),
      ownerType: t.String(),
      primaryCountry: t.Optional(t.String()),
      primaryRegion: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Create Institutional Portfolio",
      description: "Create a new institutional REO portfolio",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * GET /institutional-portfolios/:id
   * Get a single portfolio with holdings.
   */
  .get("/:id", async ({ db, params, set }) => {
    const data = await (db as any).institutionalPortfolio.findUnique({
      where: { id: params.id },
      include: {
        holdings: {
          include: { property: true },
        },
        reoProperties: true,
      },
    });
    if (!data) {
      set.status = 404;
      return { error: "Portfolio not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Institutional Portfolio",
      description: "Get a single institutional portfolio with holdings and REO properties",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * PATCH /institutional-portfolios/:id
   * Update an institutional portfolio.
   */
  .patch("/:id", async ({ db, params, body, set }) => {
    try {
      const data = await (db as any).institutionalPortfolio.update({
        where: { id: params.id },
        data: body,
      });
      return { data };
    } catch {
      set.status = 404;
      return { error: "Portfolio not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Partial(t.Object({
      name: t.Optional(t.String()),
      description: t.Optional(t.String()),
      ownerType: t.Optional(t.String()),
      primaryCountry: t.Optional(t.String()),
      primaryRegion: t.Optional(t.String()),
      status: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    })),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Update Institutional Portfolio",
      description: "Update an existing institutional portfolio",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * POST /institutional-portfolios/:id/holdings
   * Add a property as a portfolio holding.
   */
  .post("/:id/holdings", async ({ orgId, db, params, body, set }) => {
    try {
      const service = reoPortfolioService.withDB(db as any);
      const data = await service.addProperty(params.id, body.propertyId, {
        orgId: body.orgId || orgId,
        purchasePrice: body.purchasePrice,
        currentValue: body.currentValue,
        equityStake: body.equityStake,
        monthlyIncome: body.monthlyIncome,
        occupancyStatus: body.occupancyStatus,
        leaseEndDate: body.leaseEndDate ? new Date(body.leaseEndDate) : undefined,
        metadata: body.metadata,
      });
      set.status = 201;
      return { data };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      orgId: t.Optional(t.String()),
      propertyId: t.String(),
      purchasePrice: t.Number(),
      currentValue: t.Number(),
      equityStake: t.Optional(t.Number()),
      monthlyIncome: t.Optional(t.Number()),
      occupancyStatus: t.Optional(t.String()),
      leaseEndDate: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Add Portfolio Holding",
      description: "Add a property as a holding to an institutional portfolio",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * PATCH /institutional-portfolios/:id/holdings/:holdingId
   * Update a portfolio holding.
   */
  .patch("/:id/holdings/:holdingId", async ({ db, params, body, set }) => {
    try {
      const holding = await (db as any).portfolioHolding.findUnique({
        where: { id: params.holdingId },
      });
      if (!holding || holding.portfolioId !== params.id) {
        set.status = 404;
        return { error: "Holding not found in this portfolio" };
      }

      const currentValue = body.currentValue ?? Number(holding.currentValue);
      const purchasePrice = Number(holding.purchasePrice);
      const data = await (db as any).portfolioHolding.update({
        where: { id: params.holdingId },
        data: {
          ...body,
          unrealizedGain: currentValue - purchasePrice,
          annualIncome: (body.monthlyIncome ?? Number(holding.monthlyIncome)) * 12,
        },
      });
      return { data };
    } catch {
      set.status = 404;
      return { error: "Holding not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String(), holdingId: t.String() }),
    body: t.Partial(t.Object({
      currentValue: t.Optional(t.Number()),
      monthlyIncome: t.Optional(t.Number()),
      equityStake: t.Optional(t.Number()),
      occupancyStatus: t.Optional(t.String()),
      leaseEndDate: t.Optional(t.String()),
      isActive: t.Optional(t.Boolean()),
      metadata: t.Optional(t.Any()),
    })),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Update Portfolio Holding",
      description: "Update a portfolio holding with automatic recalculation of unrealized gain and annual income",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * POST /institutional-portfolios/:id/recalculate
   * Recalculate all portfolio metrics from holdings.
   */
  .post("/:id/recalculate", async ({ db, params, set }) => {
    try {
      const service = reoPortfolioService.withDB(db as any);
      const data = await service.calculatePortfolioMetrics(params.id);
      return { data };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Recalculate Portfolio Metrics",
      description: "Recalculate all portfolio metrics from its holdings",
      tags: ["REO Portfolio"]
    }
  });

// ─── REO Properties ──────────────────────────────────────────

export const reoPropertyRoutes = new Elysia({ prefix: "/reo-properties" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /reo-properties
   * List REO properties with pagination and filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    if (orgId) where.orgId = orgId;

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const take = parseInt(limit);

    const [data, total] = await Promise.all([
      (db as any).rEOProperty.findMany({
        where,
        skip,
        take,
        orderBy: { createdAt: "desc" },
        include: {
          property: { select: { id: true, name: true, address: true } },
          portfolio: { select: { id: true, name: true } },
        },
      }),
      (db as any).rEOProperty.count({ where }),
    ]);

    return { data, total, page: parseInt(page), limit: take };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      propertyType: t.Optional(t.String()),
      portfolioId: t.Optional(t.String()),
    })),
    detail: {
      summary: "List REO Properties",
      description: "List REO (Real Estate Owned) properties with pagination and filtering",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * POST /reo-properties
   * Create a new REO property record.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const service = reoPortfolioService.withDB(db as any);
    const data = await service.createREOProperty({
      ...body,
      orgId: body.orgId || orgId,
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      portfolioId: t.Optional(t.String()),
      status: t.String(),
      propertyType: t.String(),
      loanId: t.Optional(t.String()),
      borrowerName: t.Optional(t.String()),
      originalLoanAmount: t.Optional(t.Number()),
      outstandingBalance: t.Optional(t.Number()),
      asIsValue: t.Optional(t.Number()),
      afterRepairValue: t.Optional(t.Number()),
      estimatedRepairCost: t.Optional(t.Number()),
      lastAppraisalDate: t.Optional(t.String()),
      appraisalCompany: t.Optional(t.String()),
      assetManagerId: t.Optional(t.String()),
      propertyManagerId: t.Optional(t.String()),
      maintenanceVendorId: t.Optional(t.String()),
      carryingCost: t.Optional(t.Number()),
      insuranceCost: t.Optional(t.Number()),
      taxLiability: t.Optional(t.Number()),
      targetDisposalDate: t.Optional(t.String()),
      dispositionStrategy: t.Optional(t.String()),
      expectedRecoveryRate: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Create REO Property",
      description: "Create a new REO (Real Estate Owned) property record",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * GET /reo-properties/:id
   * Get a single REO property.
   */
  .get("/:id", async ({ db, params, set }) => {
    const data = await (db as any).rEOProperty.findUnique({
      where: { id: params.id },
      include: {
        property: true,
        portfolio: true,
      },
    });
    if (!data) {
      set.status = 404;
      return { error: "REO property not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get REO Property",
      description: "Get a single REO property with full details",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * PATCH /reo-properties/:id
   * Update an REO property.
   */
  .patch("/:id", async ({ db, params, body, set }) => {
    try {
      const data = await (db as any).rEOProperty.update({
        where: { id: params.id },
        data: body,
      });
      return { data };
    } catch {
      set.status = 404;
      return { error: "REO property not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Partial(t.Object({
      status: t.Optional(t.String()),
      propertyType: t.Optional(t.String()),
      loanId: t.Optional(t.String()),
      borrowerName: t.Optional(t.String()),
      originalLoanAmount: t.Optional(t.Number()),
      outstandingBalance: t.Optional(t.Number()),
      asIsValue: t.Optional(t.Number()),
      afterRepairValue: t.Optional(t.Number()),
      estimatedRepairCost: t.Optional(t.Number()),
      assetManagerId: t.Optional(t.String()),
      propertyManagerId: t.Optional(t.String()),
      carryingCost: t.Optional(t.Number()),
      insuranceCost: t.Optional(t.Number()),
      taxLiability: t.Optional(t.Number()),
      targetDisposalDate: t.Optional(t.String()),
      dispositionStrategy: t.Optional(t.String()),
      expectedRecoveryRate: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
    })),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Update REO Property",
      description: "Update an existing REO property record",
      tags: ["REO Portfolio"]
    }
  })

  /**
   * POST /reo-properties/:id/status
   * Update REO status with timeline tracking.
   */
  .post("/:id/status", async ({ db, params, body, set }) => {
    try {
      const service = reoPortfolioService.withDB(db as any);
      const data = await service.updateREOStatus(params.id, body.status, {
        notes: body.notes,
        changedBy: body.changedBy,
      });
      return { data };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      status: t.String(),
      notes: t.Optional(t.String()),
      changedBy: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("REO_MANAGE"),
    detail: {
      summary: "Update REO Status",
      description: "Update REO property status with timeline tracking",
      tags: ["REO Portfolio"]
    }
  });

// ─── Combined Org Summary ────────────────────────────────────

export const reoOrgRoutes = new Elysia({ prefix: "/reo" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /reo/org/:orgId
   * All REO properties and portfolio summaries for an organization.
   */
  .get("/org/:orgId", async ({ db, params }) => {
    const service = reoPortfolioService.withDB(db as any);
    return service.getOrgPortfolioSummary(params.orgId);
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: {
      summary: "Get Organization REO Summary",
      description: "Get all REO properties and portfolio summaries for an organization",
      tags: ["REO Portfolio"]
    }
  });
