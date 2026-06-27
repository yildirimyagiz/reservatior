import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { escrowAccountService } from "../services/escrowaccount";
import { 
  EscrowAccountPlainInputCreate, 
  EscrowAccountPlainInputUpdate 
} from "../../generated/prismabox/EscrowAccount";
import { regionMiddleware } from "../middleware/region";

export const escrowAccountRoutes = new Elysia({ prefix: "/escrow-account" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /escrow-account
   * Retrieves all EscrowAccount with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return escrowAccountService.withDB(db as any).getAll({
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
   * POST /escrow-account
   * Creates a new EscrowAccount.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await escrowAccountService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: EscrowAccountPlainInputCreate
  })

  /**
   * GET /escrow-account/:id
   * Retrieves a single EscrowAccount by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await escrowAccountService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "EscrowAccount not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /escrow-account/:id
   * Updates an existing EscrowAccount.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await escrowAccountService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowAccount not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EscrowAccountPlainInputUpdate
  })

  /**
   * DELETE /escrow-account/:id
   * Deletes a EscrowAccount.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await escrowAccountService.withDB(db as any).delete(params.id);
      return { success: true, message: "EscrowAccount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowAccount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
