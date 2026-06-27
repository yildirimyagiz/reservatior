import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { apiIntegrationService } from "../services/apiintegration";
import { 
  ApiIntegrationPlainInputCreate, 
  ApiIntegrationPlainInputUpdate 
} from "../../generated/prismabox/ApiIntegration";
import { regionMiddleware } from "../middleware/region";

export const apiIntegrationRoutes = new Elysia({ prefix: "/api-integration" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /api-integration
   * Retrieves all ApiIntegration with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return apiIntegrationService.withDB(db as any).getAll({
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
   * POST /api-integration
   * Creates a new ApiIntegration.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await apiIntegrationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ApiIntegrationPlainInputCreate
  })

  /**
   * GET /api-integration/:id
   * Retrieves a single ApiIntegration by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await apiIntegrationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ApiIntegration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /api-integration/:id
   * Updates an existing ApiIntegration.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await apiIntegrationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ApiIntegration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ApiIntegrationPlainInputUpdate
  })

  /**
   * DELETE /api-integration/:id
   * Deletes a ApiIntegration.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await apiIntegrationService.withDB(db as any).delete(params.id);
      return { success: true, message: "ApiIntegration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ApiIntegration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
