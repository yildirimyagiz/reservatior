import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { dealService } from "../services/deal";
import { 
  DealPlainInputCreate, 
  DealPlainInputUpdate 
} from "../../generated/prismabox/Deal";
import { regionMiddleware } from "../middleware/region";

export const dealRoutes = new Elysia({ prefix: "/deal" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /deal
   * Retrieves all Deal with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return dealService.withDB(db as any).getAll({
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
   * POST /deal
   * Creates a new Deal.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await dealService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: DealPlainInputCreate
  })

  /**
   * GET /deal/:id
   * Retrieves a single Deal by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await dealService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Deal not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /deal/:id
   * Updates an existing Deal.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await dealService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Deal not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DealPlainInputUpdate
  })

  /**
   * DELETE /deal/:id
   * Deletes a Deal.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await dealService.withDB(db as any).delete(params.id);
      return { success: true, message: "Deal deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Deal not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
