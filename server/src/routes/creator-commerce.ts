import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { prisma } from "../lib/prisma";

export const creatorCommerceRoutes = new Elysia({ prefix: "/creator-commerce" })
  .use(authMiddleware)
  .use(regionMiddleware)

  // ─── 1. List Creators ─────────────────────────────────────────────────────
  .get("/creators", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, status, tier, platform } = query as any;
      const where: any = {};
      if (orgId) where.orgId = orgId;
      if (status) where.status = status;
      if (tier) where.tier = tier;
      if (platform) where.platform = platform;

      const [creators, total] = await Promise.all([
        prisma.creatorProfile.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        prisma.creatorProfile.count({ where }),
      ]);

      return { data: { creators, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      tier: t.Optional(t.String()),
      platform: t.Optional(t.String()),
    }),
  })

  // ─── 16. Creator Leaderboard (must be before /:id) ───────────────────────
  .get("/creators/leaderboard", async ({ query, set }) => {
    try {
      const { orgId } = query as any;
      const where: any = {};
      if (orgId) where.orgId = orgId;

      const creators = await prisma.creatorProfile.findMany({
        where,
        orderBy: [
          { totalConversions: "desc" },
          { totalEarnings: "desc" },
        ],
        take: 10,
      });

      const leaderboard = creators.map((creator, index) => ({
        rank: index + 1,
        ...creator,
      }));

      return { data: leaderboard };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
  })

  // ─── 2. Get Single Creator ────────────────────────────────────────────────
  .get("/creators/:id", async ({ params, set }) => {
    try {
      const creator = await prisma.creatorProfile.findUnique({
        where: { id: params.id },
      });
      if (!creator) {
        set.status = 404;
        return { error: "Creator not found" };
      }
      return { data: creator };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
  })

  // ─── 3. Create Creator ────────────────────────────────────────────────────
  .post("/creators", async ({ body, set }) => {
    try {
      const creator = await prisma.creatorProfile.create({ data: body as any });
      set.status = 201;
      return { data: creator };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      userId: t.Optional(t.String()),
      name: t.String(),
      email: t.Optional(t.String()),
      avatarUrl: t.Optional(t.String()),
      platform: t.Optional(t.String()),
      handle: t.Optional(t.String()),
      followers: t.Optional(t.Number()),
      engagementRate: t.Optional(t.Number()),
      niche: t.Optional(t.String()),
      tier: t.Optional(t.String()),
      commissionRate: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      socialLinks: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
    }),
  })

  // ─── 4. Update Creator ────────────────────────────────────────────────────
  .put("/creators/:id", async ({ params, body, set }) => {
    try {
      const creator = await prisma.creatorProfile.update({
        where: { id: params.id },
        data: body as any,
      });
      return { data: creator };
    } catch (error: any) {
      set.status = 404;
      return { error: "Creator not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      email: t.Optional(t.String()),
      avatarUrl: t.Optional(t.String()),
      platform: t.Optional(t.String()),
      handle: t.Optional(t.String()),
      followers: t.Optional(t.Number()),
      engagementRate: t.Optional(t.Number()),
      niche: t.Optional(t.String()),
      tier: t.Optional(t.String()),
      commissionRate: t.Optional(t.Number()),
      totalEarnings: t.Optional(t.Number()),
      totalLeads: t.Optional(t.Number()),
      totalConversions: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      socialLinks: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
    }),
  })

  // ─── 5. Get Creator's Content ─────────────────────────────────────────────
  .get("/creators/:id/content", async ({ params, query, set }) => {
    try {
      const { page = "1", limit = "20" } = query as any;
      const where = { creatorId: params.id };

      const [content, total] = await Promise.all([
        prisma.creatorContent.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        prisma.creatorContent.count({ where }),
      ]);

      return { data: { content, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
  })

  // ─── 6. Create Content ────────────────────────────────────────────────────
  .post("/creator-content", async ({ body, set }) => {
    try {
      const content = await prisma.creatorContent.create({ data: body as any });
      set.status = 201;
      return { data: content };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      creatorId: t.String(),
      contentType: t.String(),
      title: t.Optional(t.String()),
      contentUrl: t.Optional(t.String()),
      thumbnailUrl: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      campaignId: t.Optional(t.String()),
      impressions: t.Optional(t.Number()),
      clicks: t.Optional(t.Number()),
      conversions: t.Optional(t.Number()),
      commission: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      publishedAt: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
  })

  // ─── 7. Get Creator's Leads ───────────────────────────────────────────────
  .get("/creators/:id/leads", async ({ params, query, set }) => {
    try {
      const { page = "1", limit = "20" } = query as any;
      const where = { creatorId: params.id };

      const [leads, total] = await Promise.all([
        prisma.leadRecord.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        prisma.leadRecord.count({ where }),
      ]);

      return { data: { leads, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
  })

  // ─── 8. Get Creator's Payouts ─────────────────────────────────────────────
  .get("/creators/:id/payouts", async ({ params, query, set }) => {
    try {
      const { page = "1", limit = "20" } = query as any;
      const where = { creatorId: params.id };

      const [payouts, total] = await Promise.all([
        prisma.creatorPayout.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        prisma.creatorPayout.count({ where }),
      ]);

      return { data: { payouts, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
  })

  // ─── 9. Process Payout ────────────────────────────────────────────────────
  .post("/creator-payouts/:payoutId/process", async ({ params, set }) => {
    try {
      const payout = await prisma.creatorPayout.findUnique({
        where: { id: params.payoutId },
      });
      if (!payout) {
        set.status = 404;
        return { error: "Payout not found" };
      }
      if (payout.status !== "PENDING") {
        set.status = 400;
        return { error: "Payout is not in PENDING status" };
      }

      const updated = await prisma.creatorPayout.update({
        where: { id: params.payoutId },
        data: {
          status: "PROCESSED",
          processedAt: new Date(),
        },
      });

      return { data: updated };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ payoutId: t.String() }),
  })

  // ─── 10. Get Liquidity Pool ───────────────────────────────────────────────
  .get("/ad-liquidity-pool", async ({ query, set }) => {
    try {
      const { orgId } = query as any;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId is required" };
      }

      const pool = await prisma.adLiquidityPool.findUnique({
        where: { orgId },
      });

      return { data: pool ?? { orgId, balance: 0, totalFunded: 0, totalSpent: 0 } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
    }),
  })

  // ─── 11. Fund Pool ────────────────────────────────────────────────────────
  .post("/ad-liquidity-pool/fund", async ({ body, set }) => {
    try {
      const { orgId, amount } = body as any;
      if (!orgId || !amount) {
        set.status = 400;
        return { error: "orgId and amount are required" };
      }

      const existing = await prisma.adLiquidityPool.findUnique({
        where: { orgId },
      });

      let pool;
      if (existing) {
        pool = await prisma.adLiquidityPool.update({
          where: { orgId },
          data: {
            balance: { increment: amount },
            totalFunded: { increment: amount },
          },
        });
      } else {
        pool = await prisma.adLiquidityPool.create({
          data: {
            orgId,
            balance: amount,
            totalFunded: amount,
          },
        });
      }

      return { data: pool };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      amount: t.Number(),
    }),
  })

  // ─── 12. List Zero-Upfront Campaigns ──────────────────────────────────────
  .get("/zero-upfront-campaigns", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, status, creatorId } = query as any;
      const where: any = {};
      if (orgId) where.orgId = orgId;
      if (status) where.status = status;
      if (creatorId) where.creatorId = creatorId;

      const [campaigns, total] = await Promise.all([
        prisma.zeroUpfrontCampaign.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        prisma.zeroUpfrontCampaign.count({ where }),
      ]);

      return { data: { campaigns, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      creatorId: t.Optional(t.String()),
    }),
  })

  // ─── 13. Create Zero-Upfront Campaign ─────────────────────────────────────
  .post("/zero-upfront-campaigns", async ({ body, set }) => {
    try {
      const campaign = await prisma.zeroUpfrontCampaign.create({
        data: body as any,
      });
      set.status = 201;
      return { data: campaign };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      creatorId: t.String(),
      propertyId: t.String(),
      campaignType: t.String(),
      networks: t.Optional(t.Any()),
      targetDemographics: t.Optional(t.Any()),
      budget: t.Optional(t.Number()),
      status: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
  })

  // ─── 14. List Closed-Loop Settlements ─────────────────────────────────────
  .get("/closed-loop-settlements", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, status, creatorId } = query as any;
      const where: any = {};
      if (orgId) where.orgId = orgId;
      if (status) where.status = status;
      if (creatorId) where.creatorId = creatorId;

      const [settlements, total] = await Promise.all([
        prisma.closedLoopSettlement.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        prisma.closedLoopSettlement.count({ where }),
      ]);

      return { data: { settlements, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      creatorId: t.Optional(t.String()),
    }),
  })

  // ─── 15. Process Settlement ───────────────────────────────────────────────
  .post("/closed-loop-settlements/:reservationId/process", async ({ params, set }) => {
    try {
      const settlement = await prisma.closedLoopSettlement.findFirst({
        where: { reservationId: params.reservationId },
      });
      if (!settlement) {
        set.status = 404;
        return { error: "Settlement not found for this reservation" };
      }
      if (settlement.status !== "PENDING") {
        set.status = 400;
        return { error: "Settlement is not in PENDING status" };
      }

      const bookingAmount = Number(settlement.bookingAmount);
      const commissionAmount = Number(settlement.commissionAmount);
      const platformFee = bookingAmount * 0.05;
      const netPayout = commissionAmount - platformFee;

      const updated = await prisma.closedLoopSettlement.update({
        where: { id: settlement.id },
        data: {
          platformFee,
          netPayout,
          status: "COMPLETED",
          processedAt: new Date(),
        },
      });

      let creatorPayout = null;
      if (settlement.creatorId) {
        creatorPayout = await prisma.creatorPayout.create({
          data: {
            orgId: settlement.orgId,
            creatorId: settlement.creatorId,
            amount: netPayout,
            currency: settlement.currency,
            period: new Date().toISOString().slice(0, 7),
            status: "PENDING",
            reference: `Settlement: ${settlement.id}`,
          },
        });

        await prisma.creatorProfile.update({
          where: { id: settlement.creatorId },
          data: {
            totalEarnings: { increment: netPayout },
          },
        });
      }

      return { data: { settlement: updated, creatorPayout } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ reservationId: t.String() }),
  });
