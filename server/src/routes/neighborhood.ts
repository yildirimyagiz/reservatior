import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { neighborhoodService } from "../services/neighborhood";
import { 
  NeighborhoodPlainInputCreate, 
  NeighborhoodPlainInputUpdate 
} from "../../generated/prismabox/Neighborhood";
import { regionMiddleware } from "../middleware/region";

export const neighborhoodRoutes = new Elysia({ prefix: "/neighborhoods" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /neighborhood
   * Retrieves all Neighborhood with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return neighborhoodService.withDB(db as any).getAll({
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
   * POST /neighborhood
   * Creates a new Neighborhood.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await neighborhoodService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: NeighborhoodPlainInputCreate
  })

  /**
   * GET /neighborhood/:id
   * Retrieves a single Neighborhood by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await neighborhoodService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Neighborhood not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /neighborhood/:id
   * Updates an existing Neighborhood.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await neighborhoodService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Neighborhood not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: NeighborhoodPlainInputUpdate
  })

  /**
   * DELETE /neighborhood/:id
   * Deletes a Neighborhood.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await neighborhoodService.withDB(db as any).delete(params.id);
      return { success: true, message: "Neighborhood deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Neighborhood not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
