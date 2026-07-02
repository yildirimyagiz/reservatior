import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { apiIntegrationService } from "../services/apiintegration";
import { 
  ApiIntegrationPlainInputCreate, 
  ApiIntegrationPlainInputUpdate 
} from "../../generated/prismabox/ApiIntegration";

export const apiIntegrationRoutes = new Elysia({ prefix: "/api-integration" })
  .use(authMiddleware)

  /**
   * GET /api-integration
   * Retrieves all ApiIntegration with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return apiIntegrationService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await apiIntegrationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ApiIntegrationPlainInputCreate
  })

  /**
   * GET /api-integration/:id
   * Retrieves a single ApiIntegration by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await apiIntegrationService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await apiIntegrationService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await apiIntegrationService.delete(params.id);
      return { success: true, message: "ApiIntegration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ApiIntegration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /api-integration/:id/status
   * Updates the status of an ApiIntegration.
   */
  .patch("/:id/status", async ({ params, body, set }) => {
    try {
      const data = await apiIntegrationService.update(params.id, { status: body.status });
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ApiIntegration not found or status update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      status: t.String()
    })
  })

  /**
   * POST /api-integration/:id/sync
   * Triggers a sync for an ApiIntegration.
   */
  .post("/:id/sync", async ({ params, set }) => {
    try {
      // Trigger sync logic here
      return { success: true, message: "Sync triggered successfully" };
    } catch (e) {
      set.status = 500;
      return { success: false, error: "Sync failed" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * GET /api-integration/type/:type
   * Retrieves integrations by type.
   */
  .get("/type/:type", async ({ params, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return apiIntegrationService.getAll({
      where: { ...where, type: params.type },
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    params: t.Object({ type: t.String() }),
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  });
