import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { orgSubscriptionService } from "../services/orgsubscription";
import { 
  OrgSubscriptionPlainInputCreate, 
  OrgSubscriptionPlainInputUpdate 
} from "../../generated/prismabox/OrgSubscription";

export const orgSubscriptionRoutes = new Elysia({ prefix: "/org-subscriptions" })
  .use(authMiddleware)

  /**
   * GET /org-subscription
   * Retrieves all OrgSubscription with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return orgSubscriptionService.getAll({
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
   * POST /org-subscription
   * Creates a new OrgSubscription.
   */
  .post("/", async ({ body, set }) => {
    const data = await orgSubscriptionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: OrgSubscriptionPlainInputCreate
  })

  /**
   * GET /org-subscription/:id
   * Retrieves a single OrgSubscription by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await orgSubscriptionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "OrgSubscription not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /org-subscription/:id
   * Updates an existing OrgSubscription.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await orgSubscriptionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "OrgSubscription not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: OrgSubscriptionPlainInputUpdate
  })

  /**
   * DELETE /org-subscription/:id
   * Deletes a OrgSubscription.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await orgSubscriptionService.delete(params.id);
      return { success: true, message: "OrgSubscription deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "OrgSubscription not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
