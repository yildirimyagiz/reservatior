import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { MarketplaceEngine } from "../services/ai/marketplace-engine";
import { prismaManager } from "../lib/prisma";

export const marketplaceRoutes = new Elysia({ prefix: "/marketplace" })
  .use(authMiddleware)

  /**
   * GET /marketplace/dashboard
   * Fetches recent Marketplace OS records for admin UI.
   */
  .get("/dashboard", async ({ headers }: any) => {
    const region = headers["x-region"] || "US";
    const db = prismaManager.getClient(region);

    const [trustScores, paymentRoutings, failovers, rlFeedback] = await Promise.all([
      db.propertyTrustScore.findMany({ take: 10, orderBy: { lastCalculated: "desc" }, include: { property: { select: { name: true } } } }),
      db.paymentRoutingLog.findMany({ take: 10, orderBy: { createdAt: "desc" } }),
      db.bookingFailoverEvent.findMany({ take: 10, orderBy: { createdAt: "desc" } }),
      db.aIFeedbackLoop.findMany({ take: 10, orderBy: { processedAt: "desc" } })
    ]);

    return {
      success: true,
      data: {
        trustScores,
        paymentRoutings,
        failovers,
        rlFeedback
      }
    };
  })

  /**
   * POST /marketplace/payment/route
   * Optimizes and routes card vs A2A Open Banking transactions.
   */
  .post(
    "/payment/route",
    async ({ body, headers }: any) => {
      const { amount, currency, riskScore, supportsA2A, cardSuccessProb, reservationId } = body;
      const region = headers["x-region"] || "US";
      const result = await MarketplaceEngine.optimizePaymentRoute(
        amount,
        currency,
        riskScore,
        supportsA2A,
        cardSuccessProb,
        reservationId,
        region
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        amount: t.Number(),
        currency: t.String(),
        riskScore: t.Number(),
        supportsA2A: t.Boolean(),
        cardSuccessProb: t.Number(),
        reservationId: t.Optional(t.String())
      })
    }
  )

  /**
   * POST /marketplace/failover
   * Triggers fallback inventory search when primary booking fails.
   */
  .post(
    "/failover",
    async ({ body, headers }: any) => {
      const { originalHotelId, destination, maxBudget } = body;
      const region = headers["x-region"] || "US";
      const result = await MarketplaceEngine.executeFailoverRouting(
        originalHotelId,
        destination,
        maxBudget,
        region
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        originalHotelId: t.String(),
        destination: t.String(),
        maxBudget: t.Number()
      })
    }
  )

  /**
   * POST /marketplace/escrow/release
   * Verifies check-in validation and performs Split Payout.
   */
  .post(
    "/escrow/release",
    async ({ body, headers }: any) => {
      const { reservationId, hasDispute } = body;
      const region = headers["x-region"] || "US";
      const result = await MarketplaceEngine.evaluateEscrowPayout(
        reservationId,
        hasDispute,
        region
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        reservationId: t.String(),
        hasDispute: t.Boolean()
      })
    }
  )

  /**
   * POST /marketplace/intelligence
   * Real-time Gemini market intelligence interpretation.
   */
  .post(
    "/intelligence",
    async ({ body, headers }: any) => {
      const { query, budget, location } = body;
      const region = headers["x-region"] || "US";
      const result = await MarketplaceEngine.geminiMarketIntelligence(
        query,
        budget,
        location,
        region
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        query: t.String(),
        budget: t.Number(),
        location: t.String()
      })
    }
  )

  /**
   * POST /marketplace/trust/evaluate
   * Evaluates property trust score, risk rating, and listing quality tier.
   */
  .post(
    "/trust/evaluate",
    async ({ body, headers }: any) => {
      const { propertyId, orgId, cleanlinessScore, hostReliability, cancellationHistory, inspectionVerification, disputeFrequency } = body;
      const region = headers["x-region"] || "US";
      const result = await MarketplaceEngine.evaluatePropertyTrust(
        propertyId,
        orgId,
        cleanlinessScore,
        hostReliability,
        cancellationHistory,
        inspectionVerification,
        disputeFrequency,
        region
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        propertyId: t.String(),
        orgId: t.String(),
        cleanlinessScore: t.Number(),
        hostReliability: t.Number(),
        cancellationHistory: t.Number(),
        inspectionVerification: t.Boolean(),
        disputeFrequency: t.Number()
      })
    }
  )

  /**
   * POST /marketplace/compliance/validate
   * Validates jurisdictional legality, compliance limits, and allowed payment rails.
   */
  .post(
    "/compliance/validate",
    async ({ body }: any) => {
      const { amount, country, hostLicenseVerified, jurisdictionCode } = body;
      const result = MarketplaceEngine.validateCompliance(
        amount,
        country,
        hostLicenseVerified,
        jurisdictionCode
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        amount: t.Number(),
        country: t.String(),
        hostLicenseVerified: t.Boolean(),
        jurisdictionCode: t.String()
      })
    }
  )

  /**
   * POST /marketplace/feedback/submit
   * Closed-loop reinforcement learning trainer submission endpoint.
   */
  .post(
    "/feedback/submit",
    async ({ body, headers }: any) => {
      const { decisionId, conversionSuccess, marginRealized, cancellationCost, disputePenalty, fallbackFailure } = body;
      const region = headers["x-region"] || "US";
      const result = await MarketplaceEngine.submitLearningFeedback(
        decisionId,
        conversionSuccess,
        marginRealized,
        cancellationCost,
        disputePenalty,
        fallbackFailure,
        region
      );
      return { success: true, data: result };
    },
    {
      body: t.Object({
        decisionId: t.String(),
        conversionSuccess: t.Boolean(),
        marginRealized: t.Number(),
        cancellationCost: t.Number(),
        disputePenalty: t.Number(),
        fallbackFailure: t.Boolean()
      })
    }
  );
