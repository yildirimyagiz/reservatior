import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ledgerEntryService } from "../services/ledgerentry";
import { 
  LedgerEntryPlainInputCreate, 
  LedgerEntryPlainInputUpdate 
} from "../../generated/prismabox/LedgerEntry";
import { regionMiddleware } from "../middleware/region";

export const ledgerEntryRoutes = new Elysia({ prefix: "/ledger-entries" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /ledger-entry
   * Retrieves all LedgerEntry with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return ledgerEntryService.withDB(db as any).getAll({
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
   * POST /ledger-entry
   * Creates a new LedgerEntry.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await ledgerEntryService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: LedgerEntryPlainInputCreate
  })

  /**
   * GET /ledger-entry/:id
   * Retrieves a single LedgerEntry by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await ledgerEntryService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LedgerEntry not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ledger-entry/:id
   * Updates an existing LedgerEntry.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await ledgerEntryService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LedgerEntry not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LedgerEntryPlainInputUpdate
  })

  /**
   * DELETE /ledger-entry/:id
   * Deletes a LedgerEntry.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await ledgerEntryService.withDB(db as any).delete(params.id);
      return { success: true, message: "LedgerEntry deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LedgerEntry not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
