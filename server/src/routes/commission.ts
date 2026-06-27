import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { commissionService } from "../services/commission";
import { 
  CommissionPlainInputCreate, 
  CommissionPlainInputUpdate 
} from "../../generated/prismabox/Commission";
import { regionMiddleware } from "../middleware/region";

export const commissionRoutes = new Elysia({ prefix: "/commission" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * POST /commission/subscription
   * Creates a recurring subscription commission with automated splits.
   */
  .post("/subscription", async ({ orgId, db, body, set }) => {
    try {
      const commission = await commissionService.withDB(db as any).createSubscriptionCommission(body as any);
      set.status = 201;
      return { data: commission };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message || "Failed to create subscription commission" };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      leaseId: t.Optional(t.String()),
      listingId: t.Optional(t.String()),
      agentId: t.Optional(t.String()),
      agencyId: t.Optional(t.String()),
      monthlyRent: t.Number(),
      currency: t.Optional(t.String()),
      frequency: t.Optional(t.String()),
      totalInstallments: t.Optional(t.Number()),
      splits: t.Array(t.Object({
        partyType: t.String(),
        partyId: t.Optional(t.String()),
        partyName: t.Optional(t.String()),
        rate: t.Number()
      }))
    })
  })

  /**
   * POST /commission/:id/bill
   * Bill the next recurring installment for a subscription commission.
   */
  .post("/:id/bill", async ({ orgId, db, params, set }) => {
    try {
      const result = await commissionService.withDB(db as any).billRecurringCommission(params.id);
      return { data: result };
    } catch (e: any) {
      set.status = 400;
      return { error: e.message || "Failed to bill commission" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * GET /commission
   * Retrieves all Commission with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return commissionService.withDB(db as any).getAll({
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
   * POST /commission
   * Creates a new Commission.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await commissionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: CommissionPlainInputCreate
  })

  /**
   * GET /commission/:id
   * Retrieves a single Commission by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await commissionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Commission not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /commission/:id
   * Updates an existing Commission.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await commissionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Commission not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CommissionPlainInputUpdate
  })

  /**
   * DELETE /commission/:id
   * Deletes a Commission.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await commissionService.withDB(db as any).delete(params.id);
      return { success: true, message: "Commission deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Commission not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
