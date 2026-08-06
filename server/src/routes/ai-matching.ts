import { Elysia, t } from "elysia";
import { aiMatchingService } from "../services/rental-finance/ai-matching-service";

/**
 * AI Tenant-Property Matching (rule-based + ML, no LLM for scoring)
 * Prefix: /api/v1/matching
 */
export const aiMatchingRoutes = new Elysia({ prefix: "/api/v1/matching" })
  .get(
    "/score",
    async ({ query }) => {
      const { tenantId, propertyId } = query;
      const score = aiMatchingService.computeMatchScore(tenantId, propertyId, {
        reliabilityScore: query.reliabilityScore,
        incomeStability: query.incomeStability,
        desiredRegion: query.desiredRegion,
        propertyRegion: query.propertyRegion,
        familySize: query.familySize,
        propertyCapacity: query.propertyCapacity,
        creditScore: query.creditScore,
      });
      return { tenantId, propertyId, matchScore: score };
    },
    {
      query: t.Object({
        tenantId: t.String(),
        propertyId: t.String(),
        reliabilityScore: t.Optional(t.Number()),
        incomeStability: t.Optional(t.Number()),
        desiredRegion: t.Optional(t.String()),
        propertyRegion: t.Optional(t.String()),
        familySize: t.Optional(t.Number()),
        propertyCapacity: t.Optional(t.Number()),
        creditScore: t.Optional(t.Number()),
      }),
      detail: { summary: "AI tenant-property match score", tags: ["Matching"] },
    },
  );
