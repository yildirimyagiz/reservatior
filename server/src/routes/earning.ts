import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { earningService } from "../services/earning";
import { 
  EarningPlainInputCreate, 
  EarningPlainInputUpdate 
} from "../../generated/prismabox/Earning";
import { regionMiddleware } from "../middleware/region";

export const earningRoutes = new Elysia({ prefix: "/financials/earnings" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /earning
   * Retrieves all Earning with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return earningService.withDB(db as any).getAll({
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
   * POST /earning
   * Creates a new Earning.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await earningService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: EarningPlainInputCreate
  })

  /**
   * GET /earning/:id
   * Retrieves a single Earning by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await earningService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Earning not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /earning/:id
   * Updates an existing Earning.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await earningService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Earning not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EarningPlainInputUpdate
  })

  /**
   * DELETE /earning/:id
   * Deletes a Earning.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await earningService.withDB(db as any).delete(params.id);
      return { success: true, message: "Earning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Earning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
