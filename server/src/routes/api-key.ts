import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { apiKeyService } from "../services/apikey";
import { 
  ApiKeyPlainInputCreate, 
  ApiKeyPlainInputUpdate 
} from "../../generated/prismabox/ApiKey";
import { regionMiddleware } from "../middleware/region";

export const apiKeyRoutes = new Elysia({ prefix: "/api-keys" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /api-key
   * Retrieves all ApiKey with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return apiKeyService.withDB(db as any).getAll({
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
   * POST /api-key
   * Creates a new ApiKey.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await apiKeyService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ApiKeyPlainInputCreate
  })

  /**
   * GET /api-key/:id
   * Retrieves a single ApiKey by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await apiKeyService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ApiKey not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /api-key/:id
   * Updates an existing ApiKey.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await apiKeyService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ApiKey not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ApiKeyPlainInputUpdate
  })

  /**
   * DELETE /api-key/:id
   * Deletes a ApiKey.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await apiKeyService.withDB(db as any).delete(params.id);
      return { success: true, message: "ApiKey deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ApiKey not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
