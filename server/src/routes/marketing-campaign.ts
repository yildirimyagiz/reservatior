import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { marketingCampaignService } from "../services/marketingcampaign";
import { 
  MarketingCampaignPlainInputCreate, 
  MarketingCampaignPlainInputUpdate 
} from "../../generated/prismabox/MarketingCampaign";

export const marketingCampaignRoutes = new Elysia({ prefix: "/marketing-campaigns" })
  .use(authMiddleware)

  /**
   * GET /marketing-campaign
   * Retrieves all MarketingCampaign with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return marketingCampaignService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /marketing-campaign
   * Creates a new MarketingCampaign.
   */
  .post("/", async ({ body, set }) => {
    const data = await marketingCampaignService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MarketingCampaignPlainInputCreate
  })

  /**
   * GET /marketing-campaign/:id
   * Retrieves a single MarketingCampaign by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await marketingCampaignService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MarketingCampaign not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /marketing-campaign/:id
   * Updates an existing MarketingCampaign.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await marketingCampaignService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MarketingCampaign not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MarketingCampaignPlainInputUpdate
  })

  /**
   * DELETE /marketing-campaign/:id
   * Deletes a MarketingCampaign.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await marketingCampaignService.delete(params.id);
      return { success: true, message: "MarketingCampaign deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MarketingCampaign not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
