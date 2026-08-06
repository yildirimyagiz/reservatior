import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { predictionService, PredictionModel, PredictionHorizon } from "../services/data-intelligence/prediction.service";

/**
 * Data Intelligence OS - Predictive Analytics
 * Provides predictive analytics for rental operations.
 * Answers "what will happen?" through ML models.
 * Includes property valuation, rental prediction, vacancy prediction, tenant lifetime value, market trends, and portfolio optimization.
 */
export const dataIntelligenceOSRoutes = new Elysia({
  prefix: "/api/v1/data-intelligence-os",
})
  // Predict property valuation
  .get("/predict/property-valuation/:propertyId", async ({ params, query }) => {
    try {
      const prediction = await predictionService.predictPropertyValuation(
        params.propertyId,
        query.horizon as PredictionHorizon
      );
      return { success: true, prediction };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    query: t.Object({ horizon: t.Optional(t.String()) }),
    detail: { summary: "Predict Property Valuation", tags: ["Data Intelligence OS"] },
  })

  // Predict rental income
  .get("/predict/rental-income/:propertyId", async ({ params, query }) => {
    try {
      const prediction = await predictionService.predictRentalIncome(
        params.propertyId,
        query.horizon as PredictionHorizon
      );
      return { success: true, prediction };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    query: t.Object({ horizon: t.Optional(t.String()) }),
    detail: { summary: "Predict Rental Income", tags: ["Data Intelligence OS"] },
  })

  // Predict vacancy rate
  .get("/predict/vacancy-rate/:propertyId", async ({ params, query }) => {
    try {
      const prediction = await predictionService.predictVacancyRate(
        params.propertyId,
        query.horizon as PredictionHorizon
      );
      return { success: true, prediction };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    query: t.Object({ horizon: t.Optional(t.String()) }),
    detail: { summary: "Predict Vacancy Rate", tags: ["Data Intelligence OS"] },
  })

  // Predict tenant lifetime value
  .get("/predict/tenant-ltv/:tenantId", async ({ params, query }) => {
    try {
      const prediction = await predictionService.predictTenantLifetimeValue(
        params.tenantId,
        query.horizon as PredictionHorizon
      );
      return { success: true, prediction };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ tenantId: t.String() }),
    query: t.Object({ horizon: t.Optional(t.String()) }),
    detail: { summary: "Predict Tenant LTV", tags: ["Data Intelligence OS"] },
  })

  // Detect market trends
  .get("/predict/market-trend/:location", async ({ params, query }) => {
    try {
      const prediction = await predictionService.detectMarketTrends(
        params.location,
        query.horizon as PredictionHorizon
      );
      return { success: true, prediction };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ location: t.String() }),
    query: t.Object({ horizon: t.Optional(t.String()) }),
    detail: { summary: "Detect Market Trends", tags: ["Data Intelligence OS"] },
  })

  // Optimize portfolio
  .get("/predict/portfolio-optimization/:orgId", async ({ params, query }) => {
    try {
      const prediction = await predictionService.optimizePortfolio(
        params.orgId,
        query.horizon as PredictionHorizon
      );
      return { success: true, prediction };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    query: t.Object({ horizon: t.Optional(t.String()) }),
    detail: { summary: "Optimize Portfolio", tags: ["Data Intelligence OS"] },
  })

  // Batch predictions
  .post("/predict/batch", async ({ body }) => {
    try {
      const predictions = await predictionService.getBatchPredictions(
        body.model as PredictionModel,
        body.entityIds,
        body.horizon as PredictionHorizon
      );
      return { success: true, predictions };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      model: t.String(),
      entityIds: t.Array(t.String()),
      horizon: t.Optional(t.String()),
    }),
    detail: { summary: "Batch Predictions", tags: ["Data Intelligence OS"] },
  })

  // Get prediction summary
  .get("/summary/:model/:entityId", async ({ params }) => {
    try {
      const summary = await predictionService.getPredictionSummary(
        params.model as PredictionModel,
        params.entityId
      );
      return { success: true, summary };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ model: t.String(), entityId: t.String() }),
    detail: { summary: "Get Prediction Summary", tags: ["Data Intelligence OS"] },
  })

  // Get data intelligence dashboard
  .get("/dashboard", async ({ query }) => {
    try {
      const where: any = {};
      if (query.orgId) where.orgId = query.orgId;

      const properties = await prisma.property.findMany({
        where,
        take: 50,
      });

      const totalProperties = properties.length;
      const avgOpportunityScore = properties.length > 0
        ? properties.reduce((sum: number, p: any) => sum + (p.aiOpportunityScore || 50), 0) / properties.length
        : 0;
      const highOpportunityProperties = properties.filter((p: any) => (p.aiOpportunityScore || 0) >= 75).length;
      const lowOpportunityProperties = properties.filter((p: any) => (p.aiOpportunityScore || 0) < 50).length;

      const byCity = properties.reduce((acc: Record<string, number>, p: any) => {
        acc[p.city] = (acc[p.city] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      return {
        kpis: {
          totalProperties,
          avgOpportunityScore: Math.round(avgOpportunityScore),
          highOpportunityProperties,
          lowOpportunityProperties,
          citiesCovered: Object.keys(byCity).length,
          predictionAccuracy: 0.75, // Mock value
        },
        recentActivity: properties.slice(0, 10).map((p: any) => ({
          id: p.id,
          title: `Property ${p.name}`,
          subtitle: `Opportunity Score: ${p.aiOpportunityScore || 50}`,
          value: p.city,
          timeAgo: p.createdAt.toISOString(),
        })),
        alerts: [
          ...lowOpportunityProperties > 5
            ? [{ type: "warning" as const, title: `${lowOpportunityProperties} low opportunity properties`, message: "Review property performance" }]
            : [],
          ...avgOpportunityScore < 60
            ? [{ type: "warning" as const, title: "Low average opportunity score", message: "Overall portfolio performance below threshold" }]
            : [],
        ],
      };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Data Intelligence Dashboard", tags: ["Data Intelligence OS"] },
  });
