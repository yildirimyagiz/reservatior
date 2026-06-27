import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { escrowStatusHistoryService } from "../services/escrowstatushistory";
import { 
  EscrowStatusHistoryPlainInputCreate, 
  EscrowStatusHistoryPlainInputUpdate 
} from "../../generated/prismabox/EscrowStatusHistory";
import { regionMiddleware } from "../middleware/region";

export const escrowStatusHistoryRoutes = new Elysia({ prefix: "/escrow-status-history" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /escrow-status-history
   * Retrieves all EscrowStatusHistory with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return escrowStatusHistoryService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { changedAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /escrow-status-history
   * Creates a new EscrowStatusHistory.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await escrowStatusHistoryService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: EscrowStatusHistoryPlainInputCreate
  })

  /**
   * GET /escrow-status-history/:id
   * Retrieves a single EscrowStatusHistory by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await escrowStatusHistoryService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "EscrowStatusHistory not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /escrow-status-history/:id
   * Updates an existing EscrowStatusHistory.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await escrowStatusHistoryService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowStatusHistory not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EscrowStatusHistoryPlainInputUpdate
  })

  /**
   * DELETE /escrow-status-history/:id
   * Deletes a EscrowStatusHistory.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await escrowStatusHistoryService.withDB(db as any).delete(params.id);
      return { success: true, message: "EscrowStatusHistory deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowStatusHistory not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
