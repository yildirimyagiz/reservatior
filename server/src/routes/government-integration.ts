import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { governmentIntegrationService } from "../services/governmentintegration";
import { 
  GovernmentIntegrationPlainInputCreate, 
  GovernmentIntegrationPlainInputUpdate 
} from "../../generated/prismabox/GovernmentIntegration";
import { regionMiddleware } from "../middleware/region";

export const governmentIntegrationRoutes = new Elysia({ prefix: "/government-integrations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /government-integration
   * Retrieves all GovernmentIntegration with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return governmentIntegrationService.withDB(db as any).getAll({
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
   * POST /government-integration
   * Creates a new GovernmentIntegration.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await governmentIntegrationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: GovernmentIntegrationPlainInputCreate
  })

  /**
   * GET /government-integration/:id
   * Retrieves a single GovernmentIntegration by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await governmentIntegrationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "GovernmentIntegration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /government-integration/:id
   * Updates an existing GovernmentIntegration.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await governmentIntegrationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "GovernmentIntegration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: GovernmentIntegrationPlainInputUpdate
  })

  /**
   * DELETE /government-integration/:id
   * Deletes a GovernmentIntegration.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await governmentIntegrationService.withDB(db as any).delete(params.id);
      return { success: true, message: "GovernmentIntegration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GovernmentIntegration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
