import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { growthAnalyticsService, GrowthMetric, GrowthChannel } from "../services/growth-intelligence/growth-analytics.service";

/**
 * Growth Intelligence OS - AI-powered growth engine
 * Analyzes channel quality, agent performance, city growth potential, and user segment targeting
 * Extends Marketing OS and Analytics OS
 */
export const growthIntelligenceOSRoutes = new Elysia({
  prefix: "/api/v1/growth-intelligence-os",
})
  // Analyze channel quality
  .get("/channel/:channel", async ({ params }) => {
    try {
      const analysis = await growthAnalyticsService.analyzeChannelQuality(params.channel as GrowthChannel);
      return { success: true, analysis };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ channel: t.String() }),
    detail: { summary: "Analyze Channel Quality", tags: ["Growth Intelligence OS"] },
  })

  // Analyze agent performance
  .get("/agent/:agentId", async ({ params }) => {
    try {
      const insight = await growthAnalyticsService.analyzeAgentPerformance(params.agentId);
      return { success: true, insight };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ agentId: t.String() }),
    detail: { summary: "Analyze Agent Performance", tags: ["Growth Intelligence OS"] },
  })

  // Analyze city growth potential
  .get("/city/:city", async ({ params }) => {
    try {
      const opportunity = await growthAnalyticsService.analyzeCityGrowthPotential(params.city);
      return { success: true, opportunity };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ city: t.String() }),
    detail: { summary: "Analyze City Growth Potential", tags: ["Growth Intelligence OS"] },
  })

  // Analyze user segment targeting
  .get("/segment/:segment", async ({ params }) => {
    try {
      const insight = await growthAnalyticsService.analyzeUserSegmentTargeting(params.segment);
      return { success: true, insight };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ segment: t.String() }),
    detail: { summary: "Analyze User Segment Targeting", tags: ["Growth Intelligence OS"] },
  })

  // Calculate conversion rate
  .get("/conversion/:dimension", async ({ params }) => {
    try {
      const insight = await growthAnalyticsService.calculateConversionRate(params.dimension);
      return { success: true, insight };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dimension: t.String() }),
    detail: { summary: "Calculate Conversion Rate", tags: ["Growth Intelligence OS"] },
  })

  // Calculate retention rate
  .get("/retention/:dimension", async ({ params }) => {
    try {
      const insight = await growthAnalyticsService.calculateRetentionRate(params.dimension);
      return { success: true, insight };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dimension: t.String() }),
    detail: { summary: "Calculate Retention Rate", tags: ["Growth Intelligence OS"] },
  })

  // Calculate lifetime value
  .get("/ltv/:dimension", async ({ params }) => {
    try {
      const insight = await growthAnalyticsService.calculateLifetimeValue(params.dimension);
      return { success: true, insight };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dimension: t.String() }),
    detail: { summary: "Calculate Lifetime Value", tags: ["Growth Intelligence OS"] },
  })

  // Calculate acquisition cost
  .get("/cac/:dimension", async ({ params }) => {
    try {
      const insight = await growthAnalyticsService.calculateAcquisitionCost(params.dimension);
      return { success: true, insight };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dimension: t.String() }),
    detail: { summary: "Calculate Acquisition Cost", tags: ["Growth Intelligence OS"] },
  })

  // Get growth opportunities
  .get("/opportunities/:orgId", async ({ params }) => {
    try {
      const opportunities = await growthAnalyticsService.getGrowthOpportunities(params.orgId);
      return { success: true, opportunities };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Growth Opportunities", tags: ["Growth Intelligence OS"] },
  })

  // Get growth dashboard
  .get("/dashboard/:orgId", async ({ params }) => {
    try {
      const dashboard = await growthAnalyticsService.getGrowthDashboard(params.orgId);
      return { success: true, dashboard };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Growth Intelligence Dashboard", tags: ["Growth Intelligence OS"] },
  });
