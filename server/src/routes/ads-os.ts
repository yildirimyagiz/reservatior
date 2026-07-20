import { Elysia, t } from "elysia";
import { adCampaignService } from "../services/ad-campaign-service";
import { adCreativeService } from "../services/ad-creative-service";
import { audienceSegmentService } from "../services/audience-segment-service";
import { channelConnectionService } from "../services/channel-connection-service";
import { campaignBudgetService } from "../services/campaign-budget-service";
import { campaignEventService } from "../services/campaign-event-service";
import { attributionService } from "../services/attribution-service";
import { conversionMetricService } from "../services/conversion-metric-service";

export const adsOSRoutes = new Elysia({ prefix: "/ads-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const [campaignStats, channels, recentEvents, segments] = await Promise.all([
        adCampaignService.getCampaignStats(orgId).catch(() => ({ total: 0, byStatus: [] })),
        channelConnectionService.getByOrg(orgId).catch(() => []),
        campaignEventService.getEventStats("all").catch(() => ({ totalEvents: 0, byType: {} })),
        audienceSegmentService.getByOrg(orgId).catch(() => []),
      ]);
      return { success: true, data: { campaignStats, channels, recentEvents, segments } };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String() }), detail: { summary: "Ads OS Dashboard", tags: ["Ads OS"] } })

  .get("/campaigns", async ({ query, set }) => {
    try {
      const { orgId, status, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await adCampaignService.getByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
      });
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String(), status: t.Optional(t.String()), page: t.Optional(t.String()), limit: t.Optional(t.String()) }), detail: { summary: "List Campaigns", tags: ["Ads OS"] } })

  .post("/campaigns", async ({ body, set }) => {
    try {
      const data = await adCampaignService.createCampaign(body);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ orgId: t.String(), name: t.String(), objective: t.Optional(t.String()), channel: t.Optional(t.String()) }), detail: { summary: "Create Campaign", tags: ["Ads OS"] } })

  .get("/campaigns/:id", async ({ params, set }) => {
    try {
      const data = await adCampaignService.getById(params.id);
      if (!data) { set.status = 404; return { error: "Campaign not found" }; }
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Get Campaign", tags: ["Ads OS"] } })

  .post("/campaigns/:id/activate", async ({ params, set }) => {
    try {
      const data = await adCampaignService.activateCampaign(params.id);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Activate Campaign", tags: ["Ads OS"] } })

  .post("/campaigns/:id/pause", async ({ params, set }) => {
    try {
      const data = await adCampaignService.pauseCampaign(params.id);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Pause Campaign", tags: ["Ads OS"] } })

  .post("/campaigns/:id/complete", async ({ params, set }) => {
    try {
      const data = await adCampaignService.completeCampaign(params.id);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Complete Campaign", tags: ["Ads OS"] } })

  .post("/campaigns/:id/duplicate", async ({ params, body, set }) => {
    try {
      const { name } = body as any;
      const data = await adCampaignService.duplicateCampaign(params.id, name);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), body: t.Object({ name: t.String() }), detail: { summary: "Duplicate Campaign", tags: ["Ads OS"] } })

  .get("/creatives/:campaignId", async ({ params, set }) => {
    try {
      const data = await adCreativeService.getByCampaign(params.campaignId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ campaignId: t.String() }), detail: { summary: "Get Campaign Creatives", tags: ["Ads OS"] } })

  .post("/creatives", async ({ body, set }) => {
    try {
      const data = await adCreativeService.createCreative(body);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ campaignId: t.String(), title: t.String(), bodyText: t.Optional(t.String()), imageUrl: t.Optional(t.String()), ctaType: t.Optional(t.String()) }), detail: { summary: "Create Creative", tags: ["Ads OS"] } })

  .get("/segments", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await audienceSegmentService.getByOrg(orgId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String() }), detail: { summary: "List Audience Segments", tags: ["Ads OS"] } })

  .post("/segments", async ({ body, set }) => {
    try {
      const data = await audienceSegmentService.createSegment(body);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ orgId: t.String(), name: t.String(), criteria: t.Any() }), detail: { summary: "Create Audience Segment", tags: ["Ads OS"] } })

  .post("/segments/ai-generate", async ({ body, set }) => {
    try {
      const { orgId, criteria } = body as any;
      const data = await audienceSegmentService.generateAISegment(orgId, criteria);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ orgId: t.String(), criteria: t.Any() }), detail: { summary: "AI Generate Segment", tags: ["Ads OS"] } })

  .get("/channels", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await channelConnectionService.getByOrg(orgId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String() }), detail: { summary: "List Channel Connections", tags: ["Ads OS"] } })

  .post("/channels/connect", async ({ body, set }) => {
    try {
      const { orgId, channel, config } = body as any;
      const data = await channelConnectionService.connect(orgId, channel, config);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ orgId: t.String(), channel: t.String(), config: t.Any() }), detail: { summary: "Connect Channel", tags: ["Ads OS"] } })

  .post("/channels/:id/disconnect", async ({ params, set }) => {
    try {
      await channelConnectionService.disconnect(params.id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Disconnect Channel", tags: ["Ads OS"] } })

  .get("/budgets/:campaignId", async ({ params, set }) => {
    try {
      const data = await campaignBudgetService.getByCampaign(params.campaignId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ campaignId: t.String() }), detail: { summary: "Get Campaign Budget", tags: ["Ads OS"] } })

  .post("/budgets", async ({ body, set }) => {
    try {
      const { campaignId, dailyBudget, totalBudget, currency } = body as any;
      const data = await campaignBudgetService.setBudget(campaignId, { dailyBudget, totalBudget, currency });
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ campaignId: t.String(), dailyBudget: t.Number(), totalBudget: t.Number(), currency: t.Optional(t.String()) }), detail: { summary: "Set Campaign Budget", tags: ["Ads OS"] } })

  .post("/events", async ({ body, set }) => {
    try {
      const data = await campaignEventService.trackEvent(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ campaignId: t.String(), eventType: t.String(), metadata: t.Optional(t.Any()) }), detail: { summary: "Track Campaign Event", tags: ["Ads OS"] } })

  .get("/events/stats/:campaignId", async ({ params, set }) => {
    try {
      const data = await campaignEventService.getEventStats(params.campaignId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ campaignId: t.String() }), detail: { summary: "Get Event Stats", tags: ["Ads OS"] } })

  .get("/attribution", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await attributionService.getChannelPerformance(orgId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String() }), detail: { summary: "Get Channel Attribution", tags: ["Ads OS"] } })

  .post("/attribution", async ({ body, set }) => {
    try {
      const data = await attributionService.trackAttribution(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ orgId: t.String(), channel: t.String(), eventType: t.String(), campaignId: t.Optional(t.String()) }), detail: { summary: "Track Attribution", tags: ["Ads OS"] } })

  .get("/conversions", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await conversionMetricService.getFunnel(orgId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String() }), detail: { summary: "Get Conversion Funnel", tags: ["Ads OS"] } })

  .get("/conversions/roas", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await conversionMetricService.getROAS(orgId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ orgId: t.String() }), detail: { summary: "Get ROAS", tags: ["Ads OS"] } })

  .post("/conversions", async ({ body, set }) => {
    try {
      const data = await conversionMetricService.trackConversion(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ orgId: t.String(), metricType: t.String(), value: t.Number(), campaignId: t.Optional(t.String()) }), detail: { summary: "Track Conversion", tags: ["Ads OS"] } });
