import Elysia, { t } from "elysia";
import { PricingIntelligence } from "../services/ai/pricing-intelligence";
import type { PricePrediction } from "../services/ai/pricing-intelligence";
import { prisma as db } from "../lib/prisma";

class PricingIntelligenceService {
  static simulateScenarios(
    propertyId: string,
    scenarios: { name: string; priceAdjustmentPct: number }[]
  ): {
    propertyId: string;
    simulatedAt: Date;
    scenarios: {
      name: string;
      priceAdjustmentPct: number;
      adjustedPrice: number;
      projectedOccupancyPct: number;
      projectedMonthlyRevenue: number;
      projectedAnnualRevenue: number;
      risk: "LOW" | "MEDIUM" | "HIGH";
    }[];
    recommended: string;
  } {
    const results = scenarios.map((scenario) => {
      const basePrice = 1000;
      const adjustedPrice = basePrice * (1 + scenario.priceAdjustmentPct / 100);
      const occupancyDrop = Math.max(0, scenario.priceAdjustmentPct * 0.8);
      const projectedOccupancyPct = Math.min(100, Math.max(20, 85 - occupancyDrop));
      const projectedMonthlyRevenue = adjustedPrice * (projectedOccupancyPct / 100);
      const projectedAnnualRevenue = projectedMonthlyRevenue * 12;

      let risk: "LOW" | "MEDIUM" | "HIGH" = "LOW";
      if (scenario.priceAdjustmentPct > 15 || scenario.priceAdjustmentPct < -20) {
        risk = "HIGH";
      } else if (scenario.priceAdjustmentPct > 8 || scenario.priceAdjustmentPct < -10) {
        risk = "MEDIUM";
      }

      return {
        name: scenario.name,
        priceAdjustmentPct: scenario.priceAdjustmentPct,
        adjustedPrice: Math.round(adjustedPrice * 100) / 100,
        projectedOccupancyPct: Math.round(projectedOccupancyPct * 100) / 100,
        projectedMonthlyRevenue: Math.round(projectedMonthlyRevenue * 100) / 100,
        projectedAnnualRevenue: Math.round(projectedAnnualRevenue * 100) / 100,
        risk,
      };
    });

    const bestScenario = results.reduce((best, current) =>
      current.projectedAnnualRevenue > best.projectedAnnualRevenue &&
      current.risk !== "HIGH"
        ? current
        : best
    );

    return {
      propertyId,
      simulatedAt: new Date(),
      scenarios: results,
      recommended: bestScenario.name,
    };
  }
}

export const aiPricingIntelligenceRoutes = new Elysia({ prefix: "/api/pricing-intelligence" })

  .post(
    "/predict",
    async ({ body, set }) => {
      try {
        const result = await PricingIntelligence.analyze({
          propertyId: body.propertyId,
          countryCode: body.countryCode,
          currency: body.currency,
          marketSegment: body.marketSegment,
        });
        return { success: true, data: result };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        propertyId: t.String(),
        countryCode: t.String(),
        currency: t.String(),
        marketSegment: t.Optional(
          t.Union([
            t.Literal("LUXURY"),
            t.Literal("MID_RANGE"),
            t.Literal("BUDGET"),
          ])
        ),
      }),
      detail: {
        summary: "Run AI pricing intelligence analysis on a property",
        tags: ["AI Pricing Intelligence"],
      },
    }
  )

  .post(
    "/simulate",
    async ({ body, set }) => {
      try {
        const results = PricingIntelligenceService.simulateScenarios(
          body.propertyId,
          body.scenarios
        );
        return { success: true, data: results };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        propertyId: t.String(),
        scenarios: t.Array(
          t.Object({
            name: t.String(),
            priceAdjustmentPct: t.Number(),
          })
        ),
      }),
      detail: {
        summary: "Simulate multiple pricing scenarios for a property",
        tags: ["AI Pricing Intelligence"],
      },
    }
  )

  .post(
    "/learn",
    async ({ body, set }) => {
      try {
        await PricingIntelligence.learnFromOutcome(
          body.propertyId,
          body.actualPrice,
          body.previousPrediction as PricePrediction
        );
        return {
          success: true,
          message: "Outcome recorded and model feedback updated",
        };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        propertyId: t.String(),
        actualPrice: t.Number(),
        previousPrediction: t.Object({
          current: t.Number(),
          recommended: t.Number(),
          min: t.Number(),
          max: t.Number(),
          trend: t.Union([
            t.Literal("UP"),
            t.Literal("DOWN"),
            t.Literal("STABLE"),
          ]),
        }),
      }),
      detail: {
        summary: "Feed back an actual outcome to improve future predictions",
        tags: ["AI Pricing Intelligence"],
      },
    }
  )

  .get(
    "/history/:propertyId",
    async ({ params, set }) => {
      try {
        const predictions = await db.aIPriceOptimization.findMany({
          where: { propertyId: params.propertyId },
          orderBy: { createdAt: "desc" },
          take: 50,
        });
        if (predictions.length === 0) {
          set.status = 404;
          return { success: false, error: "No prediction history found for this property" };
        }
        return { success: true, data: predictions };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ propertyId: t.String() }),
      detail: {
        summary: "Get historical AI pricing predictions for a property",
        tags: ["AI Pricing Intelligence"],
      },
    }
  );
