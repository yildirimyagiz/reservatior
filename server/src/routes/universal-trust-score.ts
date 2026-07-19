import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { universalTrustScoreService } from "../services/universal-trust-score";

const VALID_ENTITY_TYPES = ["TENANT", "LANDLORD", "AGENT", "PROPERTY", "ORGANIZATION", "VENDOR"];
const VALID_SIGNAL_CATEGORIES = ["PAYMENT", "BEHAVIOR", "VERIFICATION", "OPERATIONAL", "FINANCIAL", "COMPLIANCE", "SOCIAL", "MAINTENANCE"];

export const universalTrustScoreRoutes = new Elysia({ prefix: "/trust-score" })
  .use(authMiddleware)

  /**
   * GET /trust-score/:entityType/:entityId
   * Calculate and return composite trust score.
   */
  .get("/:entityType/:entityId", async ({ params, query, set }) => {
    const { entityType, entityId } = params as { entityType: string; entityId: string };
    const { orgId } = query as { orgId?: string };

    if (!VALID_ENTITY_TYPES.includes(entityType as string)) {
      set.status = 400;
      return { error: `Invalid entityType. Must be one of: ${VALID_ENTITY_TYPES.join(", ")}` };
    }

    const result = await universalTrustScoreService.calculateScore(
      entityType as string,
      entityId,
      orgId ?? null
    );
    return result;
  }, {
    params: t.Object({
      entityType: t.String(),
      entityId: t.String(),
    }),
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
    detail: {
      summary: "Calculate Trust Score",
      description: "Calculate and return composite trust score for an entity",
      tags: ["Trust Score"]
    }
  })

  /**
   * GET /trust-score/:entityType/:entityId/public
   * Returns a public-safe, sanitized score.
   */
  .get("/:entityType/:entityId/public", async ({ params, set }) => {
    const { entityType, entityId } = params as { entityType: string; entityId: string };

    if (!VALID_ENTITY_TYPES.includes(entityType as string)) {
      set.status = 400;
      return { error: `Invalid entityType. Must be one of: ${VALID_ENTITY_TYPES.join(", ")}` };
    }

    const result = await universalTrustScoreService.getPublicScore(
      entityType as string,
      entityId
    );

    if (!result) {
      set.status = 404;
      return { error: "No public trust score found for this entity" };
    }

    return result;
  }, {
    params: t.Object({
      entityType: t.String(),
      entityId: t.String(),
    }),
    detail: {
      summary: "Get Public Trust Score",
      description: "Returns a public-safe, sanitized trust score for an entity",
      tags: ["Trust Score"]
    }
  })

  /**
   * GET /trust-score/:entityType/:entityId/history
   * Returns current score with version history and recent events.
   */
  .get("/:entityType/:entityId/history", async ({ params, query, set }) => {
    const { entityType, entityId } = params as { entityType: string; entityId: string };
    const { orgId } = query as { orgId?: string };

    if (!VALID_ENTITY_TYPES.includes(entityType as string)) {
      set.status = 400;
      return { error: `Invalid entityType. Must be one of: ${VALID_ENTITY_TYPES.join(", ")}` };
    }

    const result = await universalTrustScoreService.getScoreWithHistory(
      entityType as string,
      entityId,
      orgId ?? null
    );

    if (!result) {
      set.status = 404;
      return { error: "No trust score found for this entity" };
    }

    return result;
  }, {
    params: t.Object({
      entityType: t.String(),
      entityId: t.String(),
    }),
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
    detail: {
      summary: "Get Trust Score History",
      description: "Returns current score with version history and recent signal events",
      tags: ["Trust Score"]
    }
  })

  /**
   * GET /trust-score/:entityType/:entityId/explain
   * Returns human-readable explanation of why a score is what it is.
   */
  .get("/:entityType/:entityId/explain", async ({ params, query, set }) => {
    const { entityType, entityId } = params as { entityType: string; entityId: string };
    const { orgId } = query as { orgId?: string };

    if (!VALID_ENTITY_TYPES.includes(entityType as string)) {
      set.status = 400;
      return { error: `Invalid entityType. Must be one of: ${VALID_ENTITY_TYPES.join(", ")}` };
    }

    const result = await universalTrustScoreService.getExplainableScore(
      entityType as string,
      entityId,
      orgId ?? null
    );

    if (!result) {
      set.status = 404;
      return { error: "No trust score found for this entity" };
    }

    return result;
  }, {
    params: t.Object({
      entityType: t.String(),
      entityId: t.String(),
    }),
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
    detail: {
      summary: "Explain Trust Score",
      description: "Returns human-readable explanation of why a score is what it is",
      tags: ["Trust Score"]
    }
  })

  /**
   * POST /trust-score/:entityType/:entityId/event
   * Record a new signal event and recalculate score impact.
   */
  .post("/:entityType/:entityId/event", async ({ params, body, set }) => {
    const { entityType, entityId } = params as { entityType: string; entityId: string };
    const { orgId, signalKey, category, rawValue, weight, sourceEntityId, sourceEntityType, description } = body as {
      orgId?: string;
      signalKey: string;
      category: string;
      rawValue: any;
      weight?: number;
      sourceEntityId?: string;
      sourceEntityType?: string;
      description?: string;
    };

    if (!VALID_ENTITY_TYPES.includes(entityType as string)) {
      set.status = 400;
      return { error: `Invalid entityType. Must be one of: ${VALID_ENTITY_TYPES.join(", ")}` };
    }

    if (!VALID_SIGNAL_CATEGORIES.includes(category as string)) {
      set.status = 400;
      return { error: `Invalid category. Must be one of: ${VALID_SIGNAL_CATEGORIES.join(", ")}` };
    }

    const existing = await universalTrustScoreService.calculateScore(
      entityType as string,
      entityId,
      orgId ?? null
    );

    const result = await universalTrustScoreService.recordEvent(
      existing.score.id,
      signalKey,
      category as string,
      rawValue,
      weight ?? 1.0,
      { sourceEntityId, sourceEntityType, description }
    );

    set.status = 201;
    return result;
  }, {
    params: t.Object({
      entityType: t.String(),
      entityId: t.String(),
    }),
    body: t.Object({
      orgId: t.Optional(t.String()),
      signalKey: t.String(),
      category: t.String(),
      rawValue: t.Any(),
      weight: t.Optional(t.Number()),
      sourceEntityId: t.Optional(t.String()),
      sourceEntityType: t.Optional(t.String()),
      description: t.Optional(t.String()),
    }),
    beforeHandle: hasPermission("TRUST_SCORE_MANAGE"),
    detail: {
      summary: "Record Trust Score Event",
      description: "Record a new signal event and recalculate score impact for an entity",
      tags: ["Trust Score"]
    }
  })

  /**
   * POST /trust-score/decay/run
   * Trigger decay for all inactive scores.
   */
  .post("/decay/run", async ({ set }) => {
    const inactiveScores = await (await import("../lib/prisma")).prisma.universalTrustScore.findMany({
      where: {
        status: "ACTIVE",
        lastSignalAt: {
          lt: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
        },
      },
      take: 500,
    });

    const results = await Promise.allSettled(
      inactiveScores.map((s) => universalTrustScoreService.applyDecay(s.id))
    );

    const decayed = results.filter((r) => r.status === "fulfilled" && (r.value as any).decayed).length;
    const failed = results.filter((r) => r.status === "rejected").length;
    const skipped = results.length - decayed - failed;

    return {
      processed: inactiveScores.length,
      decayed,
      skipped,
      failed,
      errors: results
        .filter((r) => r.status === "rejected")
        .map((r) => (r as PromiseRejectedResult).reason?.message ?? "Unknown error"),
    };
  }, {
    beforeHandle: hasPermission("TRUST_SCORE_MANAGE"),
    detail: {
      summary: "Run Trust Score Decay",
      description: "Trigger decay calculation for all inactive trust scores",
      tags: ["Trust Score"]
    }
  })

  /**
   * GET /trust-score/org/:orgId
   * Returns all trust scores for an organization.
   */
  .get("/org/:orgId", async ({ params, query, set }) => {
    const { orgId } = params as { orgId: string };
    const { entityType, tier, status, page = "1", limit = "50" } = query as {
      entityType?: string;
      tier?: string;
      status?: string;
      page?: string;
      limit?: string;
    };

    const where: any = { orgId };
    if (entityType) {
      if (!VALID_ENTITY_TYPES.includes(entityType as string)) {
        set.status = 400;
        return { error: `Invalid entityType. Must be one of: ${VALID_ENTITY_TYPES.join(", ")}` };
      }
      where.entityType = entityType;
    }
    if (tier) where.tier = tier;
    if (status) where.status = status;

    const skip = (parseInt(page) - 1) * parseInt(limit);
    const take = parseInt(limit);

    const [data, total] = await Promise.all([
      (await import("../lib/prisma")).prisma.universalTrustScore.findMany({
        where,
        orderBy: { overallScore: "desc" },
        skip,
        take,
      }),
      (await import("../lib/prisma")).prisma.universalTrustScore.count({ where }),
    ]);

    return {
      data,
      total,
      page: parseInt(page),
      limit: take,
      totalPages: Math.ceil(total / take),
    };
  }, {
    params: t.Object({
      orgId: t.String(),
    }),
    query: t.Object({
      entityType: t.Optional(t.String()),
      tier: t.Optional(t.String()),
      status: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: {
      summary: "List Organization Trust Scores",
      description: "Returns all trust scores for an organization with filtering and pagination",
      tags: ["Trust Score"]
    }
  });
