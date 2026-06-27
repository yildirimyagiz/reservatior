import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { orgSubscriptionService } from "../services/orgsubscription";
import { 
  OrgSubscriptionPlainInputCreate, 
  OrgSubscriptionPlainInputUpdate 
} from "../../generated/prismabox/OrgSubscription";
import { regionMiddleware } from "../middleware/region";

export const orgSubscriptionRoutes = new Elysia({ prefix: "/org-subscriptions" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /org-subscription
   * Retrieves all OrgSubscription with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    const result = await orgSubscriptionService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
      include: { plan: true }
    });
    const data = result.data.map((sub: any) => ({
      id: sub.id,
      orgId: sub.orgId,
      plan: sub.plan?.key || sub.planId,
      planId: sub.planId,
      status: sub.status,
      stripeCustomerId: sub.stripeCustomerId,
      stripeSubscriptionId: sub.stripeSubscriptionId,
      currentPeriodEnd: sub.currentPeriodEnd,
      startDate: sub.createdAt,
      amount: sub.plan?.priceMonthlyCents || 0,
      currency: "USD",
      createdAt: sub.createdAt,
      updatedAt: sub.updatedAt,
      limits: sub.plan?.limits || {},
    }));
    return { data, total: result.total };
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await orgSubscriptionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: OrgSubscriptionPlainInputCreate
  })

  /**
   * GET /org-subscription/:id
   * Retrieves a single OrgSubscription by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await orgSubscriptionService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await orgSubscriptionService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await orgSubscriptionService.withDB(db as any).delete(params.id);
      return { success: true, message: "OrgSubscription deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "OrgSubscription not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
