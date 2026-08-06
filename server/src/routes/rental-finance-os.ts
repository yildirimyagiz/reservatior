import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { rentalPlanService } from "../services/rental-finance/rental-plan-service";
import { rentalPaymentService } from "../services/rental-finance/rental-payment-service";
import { escrowEngine } from "../services/rental-finance/escrow-engine";
import { tenantScoreService } from "../services/rental-finance/tenant-score-service";
import { rentalRiskEngine } from "../services/rental-finance/rental-risk-engine";
import { landlordAnalyticsService } from "../services/rental-finance/landlord-analytics-service";
import { prisma } from "../lib/prisma";

export const rentalFinanceRoutes = new Elysia({ prefix: "/api/v1/rental-finance" })
  .use(regionMiddleware)
  .use(authMiddleware)

  // ─── Plans ─────────────────────────────────────────────
  .get("/plans", async ({ query }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;
    if (query.status) where.status = query.status;
    const plans = await prisma.rentalServicePlan.findMany({
      where,
      include: { rentalPayments: true, rentalEscrow: true, insurancePolicies: true },
      orderBy: { createdAt: "desc" },
    });
    return { success: true, data: plans };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
    }),
    detail: { summary: "List Rental Service Plans", tags: ["Rental Finance OS"] },
  })

  .get("/plans/:id", async ({ params }) => {
    const plan = await prisma.rentalServicePlan.findUnique({
      where: { id: params.id },
      include: { rentalPayments: true, rentalEscrow: true, insurancePolicies: true, tenant: true },
    });
    if (!plan) return { success: false, error: "Plan not found" };
    return { success: true, data: plan };
  }, {
    detail: { summary: "Get Rental Service Plan", tags: ["Rental Finance OS"] },
  })

  .post("/plans", async ({ body, orgId, region }) => {
    const payload = body as any;
    const plan = await rentalPlanService.createPlan({
      ...payload,
      effectiveTo: payload.effectiveTo ? new Date(payload.effectiveTo) : undefined,
      orgId: payload.orgId ?? orgId ?? "",
      countryCode: region === "DEFAULT" ? "US" : region,
    });
    return { success: true, data: plan };
  }, {
    body: t.Object({
      scope: t.Union([t.Literal("GLOBAL"), t.Literal("ORGANIZATION"), t.Literal("PROPERTY"), t.Literal("LEASE")]),
      orgId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      leaseId: t.Optional(t.String()),
      tenantId: t.Optional(t.String()),
      landlordEntityId: t.Optional(t.String()),
      tenantFeeRate: t.Optional(t.Number()),
      landlordFeeRate: t.Optional(t.Number()),
      protectionRate: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      effectiveTo: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Create Rental Service Plan", tags: ["Rental Finance OS"] },
  })

  .patch("/plans/:id/activate", async ({ params, region }) => {
    const plan = await rentalPlanService.activatePlan(params.id, region === "DEFAULT" ? "US" : region);
    return { success: true, data: plan };
  }, {
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Activate Plan", tags: ["Rental Finance OS"] },
  })

  .patch("/plans/:id/suspend", async ({ params }) => {
    const plan = await rentalPlanService.suspendPlan(params.id);
    return { success: true, data: plan };
  }, {
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Suspend Plan", tags: ["Rental Finance OS"] },
  })

  .patch("/plans/:id/resume", async ({ params }) => {
    const plan = await rentalPlanService.resumePlan(params.id);
    return { success: true, data: plan };
  }, {
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Resume Plan", tags: ["Rental Finance OS"] },
  })

  .patch("/plans/:id/terminate", async ({ params, region }) => {
    const plan = await rentalPlanService.terminatePlan(params.id, region === "DEFAULT" ? "US" : region);
    return { success: true, data: plan };
  }, {
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Terminate Plan", tags: ["Rental Finance OS"] },
  })

  // ─── Payments ──────────────────────────────────────────
  .post("/payments/schedule", async ({ body }) => {
    const payments = await rentalPaymentService.scheduleMonthlyPayments(body.planId);
    return { success: true, data: payments };
  }, {
    body: t.Object({ planId: t.String() }),
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Schedule Monthly Payments", tags: ["Rental Finance OS"] },
  })

  .post("/payments/process", async ({ body }) => {
    const payment = await rentalPaymentService.processPayment(body.paymentId);
    return { success: true, data: payment };
  }, {
    body: t.Object({ paymentId: t.String() }),
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Process Payment", tags: ["Rental Finance OS"] },
  })

  .post("/payments/mark-late", async ({ body }) => {
    const count = await rentalPaymentService.markLatePayments(body.graceDays ?? 3);
    return { success: true, markedLate: count };
  }, {
    body: t.Object({ graceDays: t.Optional(t.Number()) }),
    detail: { summary: "Mark Late Payments (CRON)", tags: ["Rental Finance OS"] },
  })

  .get("/payments/:planId", async ({ params }) => {
    const payments = await prisma.rentalPayment.findMany({
      where: { rentalPlanId: params.planId },
      orderBy: { scheduledDate: "asc" },
    });
    return { success: true, data: payments };
  }, {
    detail: { summary: "List Plan Payments", tags: ["Rental Finance OS"] },
  })

  // ─── Escrow ────────────────────────────────────────────
  .get("/escrow/:planId", async ({ params }) => {
    const escrow = await prisma.rentalEscrowAccount.findUnique({
      where: { rentalPlanId: params.planId },
    });
    return {
      success: true,
      balance: escrow ? Number(escrow.balance) : 0,
      heldAmount: escrow ? Number(escrow.heldAmount) : 0,
      status: escrow?.status,
    };
  }, {
    detail: { summary: "Get Plan Escrow", tags: ["Rental Finance OS"] },
  })

  .post("/escrow/:planId/release", async ({ params, user }) => {
    const escrow = await prisma.rentalEscrowAccount.findUnique({
      where: { rentalPlanId: params.planId },
    });
    if (!escrow) return { success: false, error: "Escrow not found" };
    const result = await escrowEngine.manualReleaseApprove(escrow.id, user?.id ?? "system");
    return { success: true, data: result };
  }, {
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Approve Escrow Release", tags: ["Rental Finance OS"] },
  })

  .post("/escrow/auto-release", async () => {
    const result = await escrowEngine.processAutoReleases();
    return { success: true, ...result };
  }, {
    detail: { summary: "Process Auto Releases (CRON)", tags: ["Rental Finance OS"] },
  })

  // ─── Scoring & Risk ────────────────────────────────────
  .post("/tenants/:tenantId/score", async ({ params, body }) => {
    const score = await tenantScoreService.calculateScore(params.tenantId, body.orgId);
    return { success: true, score };
  }, {
    body: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Recalculate Tenant Score", tags: ["Rental Finance OS"] },
  })

  .get("/tenants/:tenantId/risk", async ({ params }) => {
    const risk = await rentalRiskEngine.assessTenantRisk(params.tenantId);
    return { success: true, data: risk };
  }, {
    detail: { summary: "Assess Tenant Risk", tags: ["Rental Finance OS"] },
  })

  .post("/landlords/:landlordEntityId/profile", async ({ params, body }) => {
    const profile = await landlordAnalyticsService.refreshProfile(params.landlordEntityId, body.orgId);
    return { success: true, data: profile };
  }, {
    body: t.Object({ orgId: t.String() }),
    beforeHandle: hasPermission("RENTAL_FINANCE_MANAGE"),
    detail: { summary: "Refresh Landlord Profile", tags: ["Rental Finance OS"] },
  });
