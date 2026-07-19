import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { campaignService } from "../services/campaign";

export const commerceCampaignRoutes = new Elysia({ prefix: "/campaigns" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return campaignService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      type: t.Optional(t.String()),
    })),
    detail: {
      summary: "List Campaigns",
      description: "List all campaigns with pagination",
      tags: ["Commerce OS"]
    }
  })

  .get("/:id", async ({ params, set }) => {
    const data = await campaignService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Campaign not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
    detail: {
      summary: "Get Campaign",
      description: "Get a single campaign by ID",
      tags: ["Commerce OS"]
    }
  })

  .post("/", async ({ body, set }) => {
    const data = await campaignService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      type: t.String(),
      status: t.Optional(t.String()),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
      discountType: t.Optional(t.String()),
      discountValue: t.Optional(t.Number()),
      maxDiscount: t.Optional(t.Number()),
      minPurchase: t.Optional(t.Number()),
      targetProducts: t.Optional(t.Any()),
      targetBundles: t.Optional(t.Any()),
      targetRegions: t.Optional(t.Any()),
      targetSegments: t.Optional(t.Any()),
      maxUses: t.Optional(t.Number()),
      perUserLimit: t.Optional(t.Number()),
      agentBonusRate: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Create Campaign",
      description: "Create a new campaign",
      tags: ["Commerce OS"]
    }
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await campaignService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Campaign not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      description: t.Optional(t.String()),
      type: t.Optional(t.String()),
      status: t.Optional(t.String()),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
      discountType: t.Optional(t.String()),
      discountValue: t.Optional(t.Number()),
      maxDiscount: t.Optional(t.Number()),
      minPurchase: t.Optional(t.Number()),
      targetProducts: t.Optional(t.Any()),
      targetBundles: t.Optional(t.Any()),
      targetRegions: t.Optional(t.Any()),
      targetSegments: t.Optional(t.Any()),
      maxUses: t.Optional(t.Number()),
      perUserLimit: t.Optional(t.Number()),
      agentBonusRate: t.Optional(t.Number()),
      metadata: t.Optional(t.Any()),
    }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Update Campaign",
      description: "Update an existing campaign",
      tags: ["Commerce OS"]
    }
  })

  .post("/:id/activate", async ({ params, set }) => {
    try {
      const data = await campaignService.activate(params.id);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Campaign not found or activation failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    beforeHandle: hasPermission("COMMERCE_MANAGE"),
    detail: {
      summary: "Activate Campaign",
      description: "Activate a campaign",
      tags: ["Commerce OS"]
    }
  });
