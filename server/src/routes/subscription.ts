import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { subscriptionService } from "../services/subscription";
import { 
  SubscriptionPlainInputCreate, 
  SubscriptionPlainInputUpdate 
} from "../../generated/prismabox/Subscription";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";
import { prismaManager } from "../lib/prisma";

export const subscriptionRoutes = new Elysia({ prefix: "/subscription" })
  .use(authMiddleware)

  /**
   * GET /subscription/active
   * Retrieves the currently active subscription for the authenticated user.
   */
  .get("/active", async ({ orgId, db }) => {
    if (!orgId) {
      return { error: "No organization found for this user." };
    }
    const { PrismaClient } = await import("@prisma/client");
    const prisma = new PrismaClient();
    
    const activeSub = await prisma.subscription.findFirst({
      where: { orgId, isActive: true },
      orderBy: { createdAt: "desc" }
    });

    if (!activeSub) {
      return {
        data: {
          maxListings: 1,
          featuredListings: 0,
          type: "BASIC",
          isActive: true
        }
      };
    }
    return { data: activeSub };
  })

  /**
   * GET /subscription
   * Retrieves all Subscription with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return subscriptionService.getAll({
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
   * Creates a new Subscription — triggers onboarding telemetry.
   */
  .post("/", async ({ body, set }) => {
    const data = await subscriptionService.create(body);
    const db = prismaManager.getClient();

    // --- ML Trigger: New subscription created ---
    MLBridgeService.sendFeedback("subscription-lifecycle", "SUBSCRIPTION_CREATED", +3.0, {
      subscriptionId: data.id,
      orgId: data.orgId,
      type: data.type,
      price: Number(data.price),
      billingCycle: data.billingCycle
    }).catch(console.error);

    // Audit log
    try {
      await db.auditLog.create({
        data: {
          action: "SUBSCRIPTION_CREATED",
          entityType: "Subscription",
          entityId: data.id,
          details: `New ${data.type} subscription created. Price: ${data.price} ${data.currency}/${data.billingCycle}.`,
          orgId: data.orgId
        }
      });
    } catch (e) { console.warn("Audit log failed:", e); }

    set.status = 201;
    return { data };
  }, {
    body: SubscriptionPlainInputCreate
  })

  /**
   * GET /subscription/:id
   * Retrieves a single Subscription by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await subscriptionService.getById(params.id);
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
   * Updates an existing Subscription — detects upgrades, downgrades, and cancellations.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const oldData = await subscriptionService.getById(params.id);
      const data = await subscriptionService.update(params.id, body);
      const db = prismaManager.getClient();

      if (oldData) {
        // Detect subscription cancellation (isActive toggled off)
        if (oldData.isActive && body.isActive === false) {
          MLBridgeService.sendFeedback("subscription-lifecycle", "SUBSCRIPTION_CANCELLED", -5.0, {
            subscriptionId: data.id,
            orgId: data.orgId,
            type: data.type
          }).catch(console.error);

          await db.auditLog.create({
            data: {
              action: "SUBSCRIPTION_CANCELLED",
              entityType: "Subscription",
              entityId: data.id,
              details: `${data.type} subscription cancelled by organization.`,
              orgId: data.orgId
            }
          }).catch(console.warn);

          // Notify linked agents about the cancellation
          const linkedAgents = await db.agent.findMany({
            where: { subscriptions: { some: { id: data.id } } },
            select: { id: true, ownerId: true }
          }).catch(() => []);

          for (const agent of linkedAgents) {
            if (agent.ownerId) {
              await db.notification.create({
                data: {
                  title: "Subscription Cancelled",
                  content: `Your agency's ${data.type} subscription has been cancelled. Your listing limits will revert to the free tier.`,
                  type: "ALERT",
                  isRead: false,
                  userId: agent.ownerId,
                  orgId: data.orgId
                }
              }).catch(console.warn);
            }
          }
        }

        // Detect plan upgrade/downgrade (type changed)
        if (body.type && oldData.type !== body.type) {
          const isUpgrade = Number(data.price) > Number(oldData.price);
          MLBridgeService.sendFeedback("subscription-lifecycle", isUpgrade ? "SUBSCRIPTION_UPGRADED" : "SUBSCRIPTION_DOWNGRADED", isUpgrade ? +5.0 : -2.0, {
            subscriptionId: data.id,
            orgId: data.orgId,
            oldType: oldData.type,
            newType: data.type,
            priceDiff: Number(data.price) - Number(oldData.price)
          }).catch(console.error);

          await db.auditLog.create({
            data: {
              action: isUpgrade ? "SUBSCRIPTION_UPGRADED" : "SUBSCRIPTION_DOWNGRADED",
              entityType: "Subscription",
              entityId: data.id,
              details: `Plan changed from ${oldData.type} to ${data.type}. Price: ${oldData.price} → ${data.price} ${data.currency}.`,
              orgId: data.orgId
            }
          }).catch(console.warn);
        }
      }

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
  .delete("/:id", async ({ params, set }) => {
    try {
      await subscriptionService.delete(params.id);
      return { success: true, message: "Subscription deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Subscription not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
