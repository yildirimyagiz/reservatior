import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { policyService } from "../services/insurance/policy-service";
import { claimsService } from "../services/insurance/claims-service";
import { insurancePricingEngine } from "../services/insurance/pricing-engine";
import { insuranceDashboardService } from "../services/insurance/insurance-dashboard-service";
import { prisma } from "../lib/prisma";

export const insuranceRoutes = new Elysia({ prefix: "/api/v1/insurance" })
  .use(regionMiddleware)
  .use(authMiddleware)

  // ─── Providers & Products ──────────────────────────────
  .get("/providers", async ({ orgId, query }) => {
    const providers = await prisma.insuranceProvider.findMany({
      where: query.orgId ? { organizationId: query.orgId } : orgId ? { organizationId: orgId } : {},
      orderBy: { createdAt: "desc" },
    });
    return { success: true, data: providers };
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "List Insurance Providers", tags: ["Insurance OS"] },
  })

  .get("/products", async ({ orgId, query }) => {
    const products = await prisma.rentalInsuranceProduct.findMany({
      where: query.providerId ? { providerId: query.providerId } : {},
      orderBy: { createdAt: "desc" },
    });
    return { success: true, data: products };
  }, {
    query: t.Object({ providerId: t.Optional(t.String()) }),
    detail: { summary: "List Insurance Products", tags: ["Insurance OS"] },
  })

  // ─── Quotes & Policies ─────────────────────────────────
  .post("/quotes", async ({ body, orgId, region }) => {
    const quote = await policyService.createQuote({ ...body, countryCode: region === "DEFAULT" ? "US" : region });
    return { success: true, data: quote };
  }, {
    body: t.Object({
      rentalPlanId: t.String(),
      providerId: t.String(),
      productId: t.String(),
      tenantId: t.Optional(t.String()),
      landlordEntityId: t.Optional(t.String()),
      coverageAmount: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      fraudScore: t.Optional(t.Number()),
    }),
    beforeHandle: hasPermission("INSURANCE_MANAGE"),
    detail: { summary: "Create Risk-Based Quote", tags: ["Insurance OS"] },
  })

  .get("/policies", async ({ query }) => {
    const result = await policyService.listPolicies({
      orgId: query.orgId,
      status: query.status,
      page: query.page ? parseInt(query.page) : 1,
      limit: query.limit ? parseInt(query.limit) : 20,
    });
    return { success: true, ...result };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Policies", tags: ["Insurance OS"] },
  })

  .get("/policies/:id", async ({ params }) => {
    const policy = await prisma.rentalInsurancePolicy.findUnique({
      where: { id: params.id },
      include: { provider: true, product: true, claims: true },
    });
    if (!policy) return { success: false, error: "Policy not found" };
    return { success: true, data: policy };
  }, {
    detail: { summary: "Get Policy", tags: ["Insurance OS"] },
  })

  .post("/policies/:id/issue", async ({ params, body, region }) => {
    const policy = await policyService.issuePolicy({
      quoteId: params.id,
      providerName: body.providerName,
      countryCode: region === "DEFAULT" ? "US" : region,
    });
    return { success: true, data: policy };
  }, {
    body: t.Object({
      providerName: t.Optional(t.String()),
      effectiveFrom: t.Optional(t.String()),
      effectiveTo: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("INSURANCE_MANAGE"),
    detail: { summary: "Issue Policy from Quote", tags: ["Insurance OS"] },
  })

  .post("/policies/:id/cancel", async ({ params, body, region }) => {
    const policy = await policyService.cancelPolicy({
      policyId: params.id,
      reason: body.reason,
      countryCode: region === "DEFAULT" ? "US" : region,
    });
    return { success: true, data: policy };
  }, {
    body: t.Object({ reason: t.Optional(t.String()) }),
    beforeHandle: hasPermission("INSURANCE_MANAGE"),
    detail: { summary: "Cancel Policy", tags: ["Insurance OS"] },
  })

  .post("/policies/:id/payments", async ({ params, body, region }) => {
    const tx = await policyService.recordPremiumPayment({
      policyId: params.id,
      amount: body.amount,
      currency: body.currency,
      externalTransactionId: body.externalTransactionId,
      countryCode: region === "DEFAULT" ? "US" : region,
    });
    return { success: true, data: tx };
  }, {
    body: t.Object({
      amount: t.Number(),
      currency: t.Optional(t.String()),
      externalTransactionId: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("INSURANCE_MANAGE"),
    detail: { summary: "Record Premium Payment", tags: ["Insurance OS"] },
  })

  // ─── Claims ────────────────────────────────────────────
  .post("/claims", async ({ body, region }) => {
    const claim = await claimsService.submitClaim({ ...body, countryCode: region === "DEFAULT" ? "US" : region });
    return { success: true, data: claim };
  }, {
    body: t.Object({
      policyId: t.String(),
      claimType: t.String(),
      amountRequested: t.Number(),
      legalCaseId: t.Optional(t.String()),
      evidence: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("INSURANCE_MANAGE"),
    detail: { summary: "Submit Claim", tags: ["Insurance OS"] },
  })

  .get("/claims", async ({ query }) => {
    const result = await claimsService.listClaims({
      policyId: query.policyId,
      status: query.status,
      page: query.page ? parseInt(query.page) : 1,
      limit: query.limit ? parseInt(query.limit) : 20,
    });
    return { success: true, ...result };
  }, {
    query: t.Object({
      policyId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Claims", tags: ["Insurance OS"] },
  })

  .get("/claims/:id", async ({ params }) => {
    const claim = await prisma.insuranceClaim.findUnique({
      where: { id: params.id },
      include: { policy: { include: { provider: true } } },
    });
    if (!claim) return { success: false, error: "Claim not found" };
    return { success: true, data: claim };
  }, {
    detail: { summary: "Get Claim", tags: ["Insurance OS"] },
  })

  .patch("/claims/:id/status", async ({ params, body, region, user }) => {
    const claim = await claimsService.updateClaimStatus({
      claimId: params.id,
      status: body.status,
      amountApproved: body.amountApproved,
      note: body.note,
      actorId: user?.id,
      countryCode: region === "DEFAULT" ? "US" : region,
    });
    return { success: true, data: claim };
  }, {
    body: t.Object({
      status: t.Union([
        t.Literal("SUBMITTED"),
        t.Literal("UNDER_REVIEW"),
        t.Literal("APPROVED"),
        t.Literal("REJECTED"),
        t.Literal("PAID"),
        t.Literal("DISPUTED"),
      ]),
      amountApproved: t.Optional(t.Number()),
      note: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("INSURANCE_MANAGE"),
    detail: { summary: "Update Claim Status", tags: ["Insurance OS"] },
  })

  // ─── Risk Pricing ──────────────────────────────────────
  .post("/pricing/preview", async ({ body }) => {
    const result = insurancePricingEngine.calculatePremium(body);
    return { success: true, data: result };
  }, {
    body: t.Object({
      riskEngineScore: t.Optional(t.Number()),
      fraudScore: t.Optional(t.Number()),
      basePremiumRate: t.Optional(t.Number()),
      paymentHistory: t.Optional(t.Array(t.Any())),
    }),
    detail: { summary: "Preview Risk-Based Pricing", tags: ["Insurance OS"] },
  })
  .get("/dashboard", async ({ query }) => {
    if (!query.orgId) return { success: false, error: "orgId is required" };
    const data = await insuranceDashboardService.getStats(query.orgId);
    return { success: true, data };
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Insurance OS Dashboard", tags: ["Insurance OS"] },
  });
