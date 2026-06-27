import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { increaseService } from "../services/increase";
import { 
  IncreasePlainInputCreate, 
  IncreasePlainInputUpdate 
} from "../../generated/prismabox/Increase";
import { regionMiddleware } from "../middleware/region";

export const increaseRoutes = new Elysia({ prefix: "/increases" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /increase
   * Retrieves all Increase with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return increaseService.withDB(db as any).getAll({
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
   * POST /increase
   * Creates a new Increase.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await increaseService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: IncreasePlainInputCreate
  })

  /**
   * GET /increase/:id
   * Retrieves a single Increase by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await increaseService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Increase not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /increase/:id
   * Updates an existing Increase.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await increaseService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Increase not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: IncreasePlainInputUpdate
  })

  /**
   * DELETE /increase/:id
   * Deletes a Increase.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await increaseService.withDB(db as any).delete(params.id);
      return { success: true, message: "Increase deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Increase not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
