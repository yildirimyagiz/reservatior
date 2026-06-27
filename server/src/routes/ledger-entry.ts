import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ledgerEntryService } from "../services/ledgerentry";
import { 
  LedgerEntryPlainInputCreate, 
  LedgerEntryPlainInputUpdate 
} from "../../generated/prismabox/LedgerEntry";

export const ledgerEntryRoutes = new Elysia({ prefix: "/ledger-entries" })
  .use(authMiddleware)

  /**
   * GET /ledger-entry
   * Retrieves all LedgerEntry with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return ledgerEntryService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await ledgerEntryService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LedgerEntryPlainInputCreate
  })

  /**
   * GET /ledger-entry/:id
   * Retrieves a single LedgerEntry by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await ledgerEntryService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await ledgerEntryService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await ledgerEntryService.delete(params.id);
      return { success: true, message: "LedgerEntry deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LedgerEntry not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
