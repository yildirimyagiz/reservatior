import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { subscriptionService } from "../services/subscription";
import { 
  SubscriptionPlainInputCreate, 
  SubscriptionPlainInputUpdate 
} from "../../generated/prismabox/Subscription";
import { regionMiddleware } from "../middleware/region";
import { prismaManager } from "../lib/prisma";

export const subscriptionRoutes = new Elysia({ prefix: "/subscription" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /subscription/active
   * Retrieves the currently active subscription for the authenticated user.
   */
  .get("/active", async ({ db, orgId }) => {
    if (!orgId) {
      return { error: "No organization found for this user." };
    }

    const prisma = prismaManager.getDefault();

    // First check Subscription model (old system)
    const activeSub = await prisma.subscription.findFirst({
      where: { orgId, isActive: true },
      orderBy: { createdAt: "desc" }
    });

    if (activeSub) {
      return { data: activeSub };
    }

    // Fallback: check OrgSubscription + Plan (new system)
    const orgSub = await prisma.orgSubscription.findFirst({
      where: { orgId, status: "ACTIVE" },
      include: { plan: true },
      orderBy: { createdAt: "desc" }
    });

    if (orgSub?.plan) {
      const limits = orgSub.plan.limits as any;
      return {
        data: {
          maxListings: limits?.maxListings || 5,
          featuredListings: limits?.featuredListings || 0,
          maxProperties: limits?.maxProperties || 1,
          maxUsers: limits?.maxUsers || 1,
          aiFeatures: limits?.aiFeatures || false,
          type: orgSub.plan.key || "BASIC",
          isActive: orgSub.status === "ACTIVE",
          currentPeriodEnd: orgSub.currentPeriodEnd,
          planName: orgSub.plan.name,
        }
      };
    }

    // Final fallback default limits
    return {
      data: {
        maxListings: 1,
        featuredListings: 0,
        maxProperties: 1,
        maxUsers: 1,
        aiFeatures: false,
        type: "BASIC",
        isActive: true
      }
    };
  })

  /**
   * GET /subscription
   * Retrieves all Subscription with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return subscriptionService.withDB(db as any).getAll({
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
   * POST /subscription
   * Creates a new Subscription.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await subscriptionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: SubscriptionPlainInputCreate
  })

  /**
   * GET /subscription/:id
   * Retrieves a single Subscription by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await subscriptionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Subscription not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /subscription/:id
   * Updates an existing Subscription.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await subscriptionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Subscription not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SubscriptionPlainInputUpdate
  })

  /**
   * DELETE /subscription/:id
   * Deletes a Subscription.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await subscriptionService.withDB(db as any).delete(params.id);
      return { success: true, message: "Subscription deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Subscription not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
