import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ambassadorCampaignService } from "../services/ambassadorcampaign";
import { 
  AmbassadorCampaignPlainInputCreate, 
  AmbassadorCampaignPlainInputUpdate 
} from "../../generated/prismabox/AmbassadorCampaign";

export const ambassadorCampaignRoutes = new Elysia({ prefix: "/ambassador-campaigns" })
  .use(authMiddleware)

  /**
   * GET /ambassador-campaign
   * Retrieves all AmbassadorCampaign with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return ambassadorCampaignService.getAll({
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
   * POST /ambassador-campaign
   * Creates a new AmbassadorCampaign.
   */
  .post("/", async ({ body, set }) => {
    const data = await ambassadorCampaignService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AmbassadorCampaignPlainInputCreate
  })

  /**
   * GET /ambassador-campaign/:id
   * Retrieves a single AmbassadorCampaign by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await ambassadorCampaignService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AmbassadorCampaign not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ambassador-campaign/:id
   * Updates an existing AmbassadorCampaign.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await ambassadorCampaignService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AmbassadorCampaign not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AmbassadorCampaignPlainInputUpdate
  })

  /**
   * DELETE /ambassador-campaign/:id
   * Deletes a AmbassadorCampaign.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await ambassadorCampaignService.delete(params.id);
      return { success: true, message: "AmbassadorCampaign deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AmbassadorCampaign not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
