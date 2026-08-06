import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { decisionEngineService, DecisionType } from "../services/decision-intelligence/decision-engine.service";

/**
 * Decision Intelligence OS - Top-level decision-making layer
 * Implements the pipeline: Data → Analytics → AI Prediction → Decision → Automatic Action
 * Provides automatic recommendations for tenant trust, property risk, pricing, maintenance, and investment decisions
 */
export const decisionIntelligenceOSRoutes = new Elysia({
  prefix: "/api/v1/decision-intelligence-os",
})
  // Make tenant trust decision
  .get("/decision/tenant-trust/:tenantId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makeTenantTrustDecision(params.tenantId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ tenantId: t.String() }),
    detail: { summary: "Make Tenant Trust Decision", tags: ["Decision Intelligence OS"] },
  })

  // Make property risk decision
  .get("/decision/property-risk/:propertyId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makePropertyRiskDecision(params.propertyId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Make Property Risk Decision", tags: ["Decision Intelligence OS"] },
  })

  // Make price recommendation
  .get("/decision/price-recommendation/:propertyId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makePriceRecommendation(params.propertyId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Make Price Recommendation", tags: ["Decision Intelligence OS"] },
  })

  // Make maintenance priority decision
  .get("/decision/maintenance-priority/:propertyId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makeMaintenancePriorityDecision(params.propertyId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Make Maintenance Priority Decision", tags: ["Decision Intelligence OS"] },
  })

  // Make investment opportunity decision
  .get("/decision/investment-opportunity/:propertyId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makeInvestmentOpportunityDecision(params.propertyId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Make Investment Opportunity Decision", tags: ["Decision Intelligence OS"] },
  })

  // Make payment method decision
  .get("/decision/payment-method/:tenantId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makePaymentMethodDecision(params.tenantId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ tenantId: t.String() }),
    detail: { summary: "Make Payment Method Decision", tags: ["Decision Intelligence OS"] },
  })

  // Make deposit recommendation
  .get("/decision/deposit-recommendation/:tenantId/:propertyId", async ({ params }) => {
    try {
      const decision = await decisionEngineService.makeDepositRecommendation(params.tenantId, params.propertyId);
      return { success: true, decision };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ tenantId: t.String(), propertyId: t.String() }),
    detail: { summary: "Make Deposit Recommendation", tags: ["Decision Intelligence OS"] },
  })

  // Execute decision
  .post("/execute", async ({ body }) => {
    try {
      const decision = {
        ...body,
        type: body.type as DecisionType,
        recommendedAction: body.recommendedAction as any,
        createdAt: new Date(body.createdAt),
      };
      const executed = await decisionEngineService.executeDecision(decision);
      return { success: true, executed };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      id: t.String(),
      type: t.String(),
      entityType: t.String(),
      entityId: t.String(),
      recommendedAction: t.String(),
      confidence: t.Number(),
      reasoning: t.String(),
      factors: t.Array(t.Object({ factor: t.String(), impact: t.Number() })),
      suggestedValue: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
      createdAt: t.String(),
    }),
    detail: { summary: "Execute Decision", tags: ["Decision Intelligence OS"] },
  })

  // Get decision summary
  .get("/summary/:entityType/:entityId", async ({ params }) => {
    try {
      const summary = await decisionEngineService.getDecisionSummary(params.entityType, params.entityId);
      return { success: true, summary };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    detail: { summary: "Get Decision Summary", tags: ["Decision Intelligence OS"] },
  })

  // Get decision intelligence dashboard
  .get("/dashboard", async ({ query }) => {
    try {
      const where: any = {};
      if (query.orgId) where.orgId = query.orgId;

      const [tenants, properties] = await Promise.all([
        prisma.tenant.findMany({ where, take: 50 }),
        prisma.property.findMany({ where, take: 50 }),
      ]);

      const totalTenants = tenants.length;
      const totalProperties = properties.length;
      
      // Calculate average trust scores
      const tenantProfiles = await prisma.tenantTrustProfile.findMany({ where, take: 50 });
      const propertyProfiles = await prisma.propertyTrustProfile.findMany({ where, take: 50 });
      
      const avgTenantTrust = tenantProfiles.length > 0
        ? tenantProfiles.reduce((sum: number, p: any) => sum + p.overallScore, 0) / tenantProfiles.length
        : 0;
      const avgPropertyTrust = propertyProfiles.length > 0
        ? propertyProfiles.reduce((sum: number, p: any) => sum + p.overallScore, 0) / propertyProfiles.length
        : 0;

      const highTrustTenants = tenantProfiles.filter((p: any) => p.overallScore >= 75).length;
      const lowTrustTenants = tenantProfiles.filter((p: any) => p.overallScore < 50).length;
      const highTrustProperties = propertyProfiles.filter((p: any) => p.overallScore >= 75).length;
      const lowTrustProperties = propertyProfiles.filter((p: any) => p.overallScore < 50).length;

      return {
        kpis: {
          totalTenants,
          totalProperties,
          avgTenantTrust: Math.round(avgTenantTrust),
          avgPropertyTrust: Math.round(avgPropertyTrust),
          highTrustTenants,
          lowTrustTenants,
          highTrustProperties,
          lowTrustProperties,
          decisionAccuracy: 0.82, // Mock value
          autoActionsExecuted: 156, // Mock value
        },
        recentActivity: [
          ...tenantProfiles.slice(0, 5).map((p: any) => ({
            id: p.id,
            title: `Tenant trust decision`,
            subtitle: `Score: ${p.overallScore}`,
            value: p.tenantId.slice(0, 8),
            timeAgo: p.lastCalculatedAt.toISOString(),
          })),
          ...propertyProfiles.slice(0, 5).map((p: any) => ({
            id: p.id,
            title: `Property risk decision`,
            subtitle: `Score: ${p.overallScore}`,
            value: p.propertyId.slice(0, 8),
            timeAgo: p.lastCalculatedAt.toISOString(),
          })),
        ],
        alerts: [
          ...lowTrustTenants > 3
            ? [{ type: "warning" as const, title: `${lowTrustTenants} low trust tenants`, message: "Review tenant decisions" }]
            : [],
          ...lowTrustProperties > 3
            ? [{ type: "warning" as const, title: `${lowTrustProperties} high risk properties`, message: "Review property decisions" }]
            : [],
          ...avgTenantTrust < 60
            ? [{ type: "error" as const, title: "Low average tenant trust", message: "Overall tenant trust below threshold" }]
            : [],
        ],
      };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Decision Intelligence Dashboard", tags: ["Decision Intelligence OS"] },
  });
