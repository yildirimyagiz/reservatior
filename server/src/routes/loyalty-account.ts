import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { loyaltyAccountService } from "../services/loyaltyaccount";
import { 
  LoyaltyAccountPlainInputCreate, 
  LoyaltyAccountPlainInputUpdate 
} from "../../generated/prismabox/LoyaltyAccount";

export const loyaltyAccountRoutes = new Elysia({ prefix: "/loyalty-accounts" })
  .use(authMiddleware)

  /**
   * GET /loyalty-account
   * Retrieves all LoyaltyAccount with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return loyaltyAccountService.getAll({
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
   * POST /loyalty-account
   * Creates a new LoyaltyAccount.
   */
  .post("/", async ({ body, set }) => {
    const data = await loyaltyAccountService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LoyaltyAccountPlainInputCreate
  })

  /**
   * GET /loyalty-account/:id
   * Retrieves a single LoyaltyAccount by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await loyaltyAccountService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LoyaltyAccount not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /loyalty-account/:id
   * Updates an existing LoyaltyAccount.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await loyaltyAccountService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LoyaltyAccount not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LoyaltyAccountPlainInputUpdate
  })

  /**
   * DELETE /loyalty-account/:id
   * Deletes a LoyaltyAccount.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await loyaltyAccountService.delete(params.id);
      return { success: true, message: "LoyaltyAccount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LoyaltyAccount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });

// Frontend-compatible loyalty routes
export const loyaltyRoutes = new Elysia({ prefix: "/loyalty" })
  .use(authMiddleware)

  /**
   * GET /loyalty/account
   * Get current user's loyalty account
   */
  .get("/account", async ({ user }) => {
    const accounts = await loyaltyAccountService.getAll({
      where: { userId: user?.id },
      take: 1
    });
    const account = accounts[0];
    if (!account) {
      return { 
        points: 0, 
        level: 'BRONZE', 
        nextLevelPoints: 1000,
        currentTier: 'BRONZE'
      };
    }
    return {
      points: account.currentPoints,
      level: account.currentTier,
      nextLevelPoints: getNextLevelThreshold(account.currentTier),
      currentTier: account.currentTier
    };
  })

  /**
   * GET /loyalty/achievements
   * Get user achievements
   */
  .get("/achievements", async ({ user }) => {
    const account = await loyaltyAccountService.getAll({
      where: { userId: user?.id },
      take: 1
    });
    if (!account[0]) return [];
    
    const rewards = (account[0].rewards as any) || [];
    return rewards.map((reward: any, index: number) => ({
      id: `ach_${index}`,
      title: reward.title || 'Achievement',
      description: reward.description || '',
      unlockedAt: reward.unlockedAt,
      points: reward.points || 0,
      icon: reward.icon || 'Trophy'
    }));
  })

  /**
   * GET /loyalty/activities
   * Get loyalty activity history
   */
  .get("/activities", async ({ user }) => {
    const account = await loyaltyAccountService.getAll({
      where: { userId: user?.id },
      take: 1
    });
    if (!account[0]) return [];
    
    const history = (account[0].pointsHistory as any) || [];
    return history.map((activity: any) => ({
      type: activity.type,
      desc: activity.description,
      pts: activity.points > 0 ? `+${activity.points}` : `${activity.points}`,
      date: activity.date
    }));
  });

function getNextLevelThreshold(currentTier: string): number {
  const thresholds: Record<string, number> = {
    BRONZE: 1000,
    SILVER: 5000,
    GOLD: 15000,
    PLATINUM: 50000,
    DIAMOND: 999999
  };
  return thresholds[currentTier] || 1000;
}
