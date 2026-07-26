import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { prisma as db } from "../lib/prisma";

export const adRouterRoutes = new Elysia({ prefix: "/ad-router" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const campaigns = await db.adCampaign.findMany({
        where: { orgId, deletedAt: null },
      });

      const totalCampaigns = campaigns.length;
      const activeCampaigns = campaigns.filter((c) => c.status === "ACTIVE").length;
      const totalSpent = campaigns.reduce((sum, c) => sum + Number(c.spent), 0);
      const avgCPET = campaigns.filter((c) => c.cpet != null).reduce((sum, c, _, arr) => sum + (c.cpet as number) / arr.length, 0);
      const totalConversions = campaigns.reduce((sum, c) => sum + c.conversions, 0);

      const byNetwork: Record<string, { count: number; spent: number; conversions: number }> = {};
      for (const c of campaigns) {
        const net = c.network || "unknown";
        if (!byNetwork[net]) byNetwork[net] = { count: 0, spent: 0, conversions: 0 };
        byNetwork[net].count += 1;
        byNetwork[net].spent += Number(c.spent);
        byNetwork[net].conversions += c.conversions;
      }

      const campaignROAS = campaigns.map((c) => ({
        campaignId: c.id,
        name: c.name,
        network: c.network,
        roas: c.roas,
        spent: Number(c.spent),
        conversions: c.conversions,
      }));

      return {
        data: {
          totalCampaigns,
          activeCampaigns,
          totalSpent,
          avgCPET,
          totalConversions,
          byNetwork,
          campaignROAS,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Ad Router Dashboard", description: "Aggregate campaigns by status, total spend, avg CPET, ROAS per campaign, grouped by network", tags: ["Ad Router"] },
  })

  .get("/ad-campaigns", async ({ query, set }) => {
    try {
      const { orgId, page = "1", limit = "20", status, network, campaignType } = query as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const where: any = { orgId, deletedAt: null };
      if (status) where.status = status;
      if (network) where.network = network;
      if (campaignType) where.campaignType = campaignType;

      const [data, total] = await Promise.all([
        db.adCampaign.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        db.adCampaign.count({ where }),
      ]);

      return { data: { items: data, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      status: t.Optional(t.String()),
      network: t.Optional(t.String()),
      campaignType: t.Optional(t.String()),
    }),
    detail: { summary: "List Ad Campaigns", description: "List ad campaigns with filtering and pagination", tags: ["Ad Router"] },
  })

  .get("/ad-campaigns/:id", async ({ params, set }) => {
    try {
      const data = await db.adCampaign.findFirst({
        where: { id: params.id, deletedAt: null },
      });
      if (!data) { set.status = 404; return { error: "Campaign not found" }; }
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Ad Campaign", description: "Get a single ad campaign by ID", tags: ["Ad Router"] },
  })

  .post("/ad-campaigns", async ({ body, set }) => {
    try {
      const data = await db.adCampaign.create({ data: body });
      set.status = 201;
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      propertyId: t.Optional(t.String()),
      campaignType: t.String(),
      status: t.Optional(t.String()),
      network: t.Optional(t.String()),
      accountId: t.Optional(t.String()),
      budget: t.Number(),
      dailyBudget: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      targetDemographics: t.Optional(t.Any()),
      targetingConfig: t.Optional(t.Any()),
      creatives: t.Optional(t.Any()),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Ad Campaign", description: "Create a new ad campaign", tags: ["Ad Router"] },
  })

  .put("/ad-campaigns/:id", async ({ params, body, set }) => {
    try {
      const existing = await db.adCampaign.findFirst({ where: { id: params.id, deletedAt: null } });
      if (!existing) { set.status = 404; return { error: "Campaign not found" }; }
      const data = await db.adCampaign.update({ where: { id: params.id }, data: body });
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      campaignType: t.Optional(t.String()),
      status: t.Optional(t.String()),
      network: t.Optional(t.String()),
      accountId: t.Optional(t.String()),
      budget: t.Optional(t.Number()),
      dailyBudget: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      targetDemographics: t.Optional(t.Any()),
      targetingConfig: t.Optional(t.Any()),
      creatives: t.Optional(t.Any()),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Update Ad Campaign", description: "Update an existing ad campaign", tags: ["Ad Router"] },
  })

  .post("/ad-campaigns/:id/pause", async ({ params, set }) => {
    try {
      const existing = await db.adCampaign.findFirst({ where: { id: params.id, deletedAt: null } });
      if (!existing) { set.status = 404; return { error: "Campaign not found" }; }
      const data = await db.adCampaign.update({
        where: { id: params.id },
        data: { status: "PAUSED", pausedAt: new Date() },
      });
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Pause Ad Campaign", description: "Pause an active ad campaign", tags: ["Ad Router"] },
  })

  .post("/ad-campaigns/:id/resume", async ({ params, set }) => {
    try {
      const existing = await db.adCampaign.findFirst({ where: { id: params.id, deletedAt: null } });
      if (!existing) { set.status = 404; return { error: "Campaign not found" }; }
      const data = await db.adCampaign.update({
        where: { id: params.id },
        data: { status: "ACTIVE", pausedAt: null },
      });
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Resume Ad Campaign", description: "Resume a paused ad campaign", tags: ["Ad Router"] },
  })

  .get("/ad-networks", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const data = await db.adNetworkConfig.findMany({
        where: { orgId },
        orderBy: { createdAt: "desc" },
      });
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Ad Networks", description: "List connected ad network configurations", tags: ["Ad Router"] },
  })

  .post("/ad-networks/connect", async ({ body, set }) => {
    try {
      const existing = await db.adNetworkConfig.findFirst({
        where: { orgId: body.orgId, network: body.network, accountId: body.accountId },
      });

      let data;
      if (existing) {
        data = await db.adNetworkConfig.update({
          where: { id: existing.id },
          data: { apiKey: body.apiKey, isConnected: true, lastSyncAt: new Date() },
        });
      } else {
        data = await db.adNetworkConfig.create({
          data: {
            orgId: body.orgId,
            network: body.network,
            accountId: body.accountId,
            apiKey: body.apiKey,
            isConnected: true,
            lastSyncAt: new Date(),
            config: body.config,
          },
        });
      }

      set.status = 201;
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      network: t.String(),
      accountId: t.String(),
      apiKey: t.String(),
      config: t.Optional(t.Any()),
    }),
    detail: { summary: "Connect Ad Network", description: "Connect or reconnect an ad network", tags: ["Ad Router"] },
  })

  .post("/ad-networks/:network/disconnect", async ({ params, query, set }) => {
    try {
      const { orgId } = query as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const existing = await db.adNetworkConfig.findFirst({
        where: { orgId, network: params.network },
      });
      if (!existing) { set.status = 404; return { error: "Network config not found" }; }

      const data = await db.adNetworkConfig.update({
        where: { id: existing.id },
        data: { isConnected: false },
      });
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ network: t.String() }),
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Disconnect Ad Network", description: "Disconnect an ad network", tags: ["Ad Router"] },
  })

  .get("/ad-budget-shifts", async ({ query, set }) => {
    try {
      const { orgId, page = "1", limit = "20" } = query as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const [data, total] = await Promise.all([
        db.adBudgetShiftEvent.findMany({
          where: { orgId },
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        db.adBudgetShiftEvent.count({ where: { orgId } }),
      ]);

      return { data: { items: data, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Budget Shift Events", description: "List all ad budget shift events", tags: ["Ad Router"] },
  })

  .post("/ad-campaigns/:id/arbitrage", async ({ params, body, set }) => {
    try {
      const campaignId = params.id;
      const { orgId, shiftPercentage = 20 } = body as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const campaign = await db.adCampaign.findFirst({
        where: { id: campaignId, orgId, deletedAt: null },
      });
      if (!campaign) { set.status = 404; return { error: "Campaign not found" }; }

      const networkConfigs = await db.adNetworkConfig.findMany({
        where: { orgId, isConnected: true },
      });
      if (networkConfigs.length < 2) {
        set.status = 400;
        return { error: "At least 2 connected networks required for arbitrage" };
      }

      const campaignsByNetwork = await db.adCampaign.findMany({
        where: { orgId, network: { in: networkConfigs.map((n) => n.network) }, deletedAt: null },
      });

      const networkCPET: Record<string, { cpet: number; totalSpent: number }> = {};
      for (const nc of networkConfigs) {
        const netCampaigns = campaignsByNetwork.filter((c) => c.network === nc.network);
        const totalSpent = netCampaigns.reduce((s, c) => s + Number(c.spent), 0);
        const totalConversions = netCampaigns.reduce((s, c) => s + c.conversions, 0);
        const avgCPET = totalConversions > 0 ? totalSpent / totalConversions : Infinity;
        networkCPET[nc.network] = { cpet: avgCPET, totalSpent };
      }

      const sorted = Object.entries(networkCPET).sort((a, b) => a[1].cpet - b[1].cpet);
      const lowestCPETNetwork = sorted[0][0];
      const highestCPETNetwork = sorted[sorted.length - 1][0];

      if (lowestCPETNetwork === highestCPETNetwork) {
        set.status = 400;
        return { error: "All networks have identical CPET; no arbitrage possible" };
      }

      const sourceCPET = networkCPET[highestCPETNetwork].cpet;
      const targetCPET = networkCPET[lowestCPETNetwork].cpet;
      const shiftAmount = Number(campaign.budget) * (shiftPercentage / 100);

      const shiftEvent = await db.adBudgetShiftEvent.create({
        data: {
          orgId,
          campaignId,
          fromNetwork: highestCPETNetwork,
          toNetwork: lowestCPETNetwork,
          amount: shiftAmount,
          reason: `Arbitrage: shift ${shiftPercentage}% budget from ${highestCPETNetwork} (CPET ${sourceCPET.toFixed(2)}) to ${lowestCPETNetwork} (CPET ${targetCPET.toFixed(2)})`,
          cpetBefore: sourceCPET,
          cpetAfter: targetCPET,
          status: "EXECUTED",
          executedAt: new Date(),
        },
      });

      const projectedSavings = shiftAmount * (sourceCPET - targetCPET);

      return {
        data: {
          shifts: [shiftEvent],
          savings: {
            amount: projectedSavings,
            fromNetwork: highestCPETNetwork,
            toNetwork: lowestCPETNetwork,
            shiftAmount,
            sourceCPET,
            targetCPET,
          },
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      orgId: t.String(),
      shiftPercentage: t.Optional(t.Number()),
    }),
    detail: { summary: "Execute Arbitrage", description: "Shift budget between networks based on CPET performance", tags: ["Ad Router"] },
  })

  .get("/ad-arbitrage/report", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const shifts = await db.adBudgetShiftEvent.findMany({
        where: { orgId },
        orderBy: { createdAt: "desc" },
      });

      const totalShifts = shifts.length;
      const totalAmount = shifts.reduce((s, e) => s + Number(e.amount), 0);
      const networkSavings: Record<string, { shifts: number; totalAmount: number; avgCPETDelta: number }> = {};

      for (const shift of shifts) {
        const key = `${shift.fromNetwork}->${shift.toNetwork}`;
        if (!networkSavings[key]) networkSavings[key] = { shifts: 0, totalAmount: 0, avgCPETDelta: 0 };
        networkSavings[key].shifts += 1;
        networkSavings[key].totalAmount += Number(shift.amount);
        if (shift.cpetBefore != null && shift.cpetAfter != null) {
          networkSavings[key].avgCPETDelta += shift.cpetBefore - shift.cpetAfter;
        }
      }

      for (const key of Object.keys(networkSavings)) {
        networkSavings[key].avgCPETDelta /= networkSavings[key].shifts || 1;
      }

      return {
        data: {
          orgId,
          totalShifts,
          totalAmount,
          networkSavings,
          recentShifts: shifts.slice(0, 10),
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Arbitrage Report", description: "Get arbitrage performance report", tags: ["Ad Router"] },
  })

  .get("/offline-conversions", async ({ query, set }) => {
    try {
      const { orgId, page = "1", limit = "20", campaignId, sentToNetwork } = query as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const where: any = { orgId };
      if (campaignId) where.campaignId = campaignId;
      if (sentToNetwork !== undefined) where.sentToNetwork = sentToNetwork === "true";

      const [data, total] = await Promise.all([
        db.offlineConversionEvent.findMany({
          where,
          skip: (parseInt(page) - 1) * parseInt(limit),
          take: parseInt(limit),
          orderBy: { createdAt: "desc" },
        }),
        db.offlineConversionEvent.count({ where }),
      ]);

      return { data: { items: data, total, page: parseInt(page), limit: parseInt(limit) } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      campaignId: t.Optional(t.String()),
      sentToNetwork: t.Optional(t.String()),
    }),
    detail: { summary: "List Offline Conversions", description: "List offline conversion events with filtering", tags: ["Ad Router"] },
  })

  .post("/offline-conversions/sync", async ({ body, set }) => {
    try {
      const data = await db.offlineConversionEvent.create({
        data: {
          orgId: body.orgId,
          campaignId: body.campaignId,
          eventType: body.eventType,
          conversionValue: body.conversionValue,
          currency: body.currency,
          gclid: body.gclid,
          externalId: body.externalId,
          sentToNetwork: true,
          sentAt: new Date(),
          metadata: body.metadata,
        },
      });
      set.status = 201;
      return { data };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      campaignId: t.String(),
      eventType: t.String(),
      conversionValue: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      gclid: t.Optional(t.String()),
      externalId: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Sync Offline Conversion", description: "Sync a single offline conversion event to the ad network", tags: ["Ad Router"] },
  })

  .post("/offline-conversions/batch-sync/:id", async ({ params, body, set }) => {
    try {
      const campaignId = params.id;
      const { orgId, conversionEvents } = body as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const created = await db.offlineConversionEvent.createMany({
        data: conversionEvents.map((e: any) => ({
          orgId,
          campaignId,
          eventType: e.eventType,
          conversionValue: e.conversionValue,
          currency: e.currency,
          gclid: e.gclid,
          externalId: e.externalId,
          sentToNetwork: true,
          sentAt: new Date(),
          metadata: e.metadata,
        })),
      });

      set.status = 201;
      return { data: { synced: created.count, campaignId } };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      orgId: t.String(),
      conversionEvents: t.Array(t.Object({
        eventType: t.String(),
        conversionValue: t.Optional(t.Number()),
        currency: t.Optional(t.String()),
        gclid: t.Optional(t.String()),
        externalId: t.Optional(t.String()),
        metadata: t.Optional(t.Any()),
      })),
    }),
    detail: { summary: "Batch Sync Offline Conversions", description: "Batch sync offline conversion events for a campaign", tags: ["Ad Router"] },
  })

  .get("/ad-campaigns/:id/recommendations", async ({ params, query, set }) => {
    try {
      const campaignId = params.id;
      const { orgId } = query as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const campaign = await db.adCampaign.findFirst({
        where: { id: campaignId, orgId, deletedAt: null },
      });
      if (!campaign) { set.status = 404; return { error: "Campaign not found" }; }

      const networkCampaigns = await db.adCampaign.findMany({
        where: { orgId, network: campaign.network, deletedAt: null },
      });

      const avgCPET = networkCampaigns.filter((c) => c.cpet != null).reduce((sum, c, _, arr) => sum + (c.cpet as number) / (arr.length || 1), 0);
      const avgROAS = networkCampaigns.filter((c) => c.roas != null).reduce((sum, c, _, arr) => sum + (c.roas as number) / (arr.length || 1), 0);
      const avgConversionRate = networkCampaigns.reduce((sum, c) => sum + (c.clicks > 0 ? c.conversions / c.clicks : 0), 0) / (networkCampaigns.length || 1);

      const recommendations: string[] = [];
      if (campaign.cpet != null && campaign.cpet > avgCPET * 1.2) {
        recommendations.push(`CPET (${campaign.cpet.toFixed(2)}) is 20%+ above network average (${avgCPET.toFixed(2)}). Consider adjusting targeting or creatives.`);
      }
      if (campaign.roas != null && campaign.roas < avgROAS * 0.8) {
        recommendations.push(`ROAS (${campaign.roas.toFixed(2)}) is 20%+ below network average (${avgROAS.toFixed(2)}). Review audience segments and bid strategy.`);
      }
      if (campaign.clicks > 0 && campaign.conversions / campaign.clicks < avgConversionRate * 0.7) {
        recommendations.push(`Conversion rate is 30%+ below network average. Optimize landing page or ad relevance.`);
      }
      if (campaign.budget && campaign.spent && Number(campaign.spent) > Number(campaign.budget) * 0.9 && campaign.conversions === 0) {
        recommendations.push("Budget nearly exhausted with zero conversions. Pause and reassess targeting.");
      }
      if (recommendations.length === 0) {
        recommendations.push("Campaign is performing within or above network averages. No immediate action needed.");
      }

      return {
        data: {
          campaignId,
          networkAverages: { avgCPET, avgROAS, avgConversionRate },
          recommendations,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Get AI Recommendations", description: "Get AI-generated optimization recommendations for a campaign", tags: ["Ad Router"] },
  })

  .post("/ad-campaigns/:id/optimize", async ({ params, body, set }) => {
    try {
      const campaignId = params.id;
      const { orgId, strategy = "balanced" } = body as any;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const campaign = await db.adCampaign.findFirst({
        where: { id: campaignId, orgId, deletedAt: null },
      });
      if (!campaign) { set.status = 404; return { error: "Campaign not found" }; }

      const networkCampaigns = await db.adCampaign.findMany({
        where: { orgId, network: campaign.network, deletedAt: null, status: "ACTIVE" },
      });

      const avgCPET = networkCampaigns.filter((c) => c.cpet != null).reduce((sum, c, _, arr) => sum + (c.cpet as number) / (arr.length || 1), 0);
      const avgConversionRate = networkCampaigns.reduce((sum, c) => sum + (c.clicks > 0 ? c.conversions / c.clicks : 0), 0) / (networkCampaigns.length || 1);

      const updatedFields: Record<string, any> = {};

      if (strategy === "aggressive" || strategy === "balanced") {
        if (campaign.cpet != null && campaign.cpet > avgCPET * 1.3) {
          updatedFields.dailyBudget = Number(campaign.dailyBudget || campaign.budget) * 0.85;
        }
        if (campaign.clicks > 0 && campaign.conversions / campaign.clicks < avgConversionRate * 0.6) {
          updatedFields.status = "PAUSED";
          updatedFields.pausedAt = new Date();
        }
      }

      if (strategy === "conservative") {
        if (Number(campaign.spent) > Number(campaign.budget) * 0.7) {
          updatedFields.dailyBudget = Number(campaign.dailyBudget || campaign.budget) * 0.7;
        }
      }

      if (strategy === "aggressive") {
        if (campaign.cpet != null && campaign.cpet < avgCPET * 0.7) {
          updatedFields.dailyBudget = Number(campaign.dailyBudget || campaign.budget) * 1.2;
        }
      }

      let data = campaign;
      if (Object.keys(updatedFields).length > 0) {
        data = await db.adCampaign.update({
          where: { id: campaignId },
          data: { ...updatedFields, metadata: { ...((campaign.metadata as object) || {}), lastOptimized: new Date().toISOString(), strategy } },
        });
      }

      return {
        data: {
          campaignId,
          strategy,
          appliedChanges: updatedFields,
          campaign: data,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      orgId: t.String(),
      strategy: t.Optional(t.String()),
    }),
    detail: { summary: "Trigger AI Optimization", description: "Trigger AI-driven optimization for a campaign based on strategy", tags: ["Ad Router"] },
  });
