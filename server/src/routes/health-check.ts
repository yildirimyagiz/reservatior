import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { healthCheckService } from "../services/healthcheck";
import { 
  HealthCheckPlainInputCreate, 
  HealthCheckPlainInputUpdate 
} from "../../generated/prismabox/HealthCheck";

export const healthCheckRoutes = new Elysia({ prefix: "/health-checks" })
  .use(authMiddleware)

  /**
   * GET /health-check
   * Retrieves all HealthCheck with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return healthCheckService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /health-check
   * Creates a new HealthCheck.
   */
  .post("/", async ({ body, set }) => {
    const data = await healthCheckService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: HealthCheckPlainInputCreate
  })

  /**
   * GET /health-check/:id
   * Retrieves a single HealthCheck by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await healthCheckService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "HealthCheck not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /health-check/:id
   * Updates an existing HealthCheck.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await healthCheckService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "HealthCheck not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: HealthCheckPlainInputUpdate
  })

  /**
   * DELETE /health-check/:id
   * Deletes a HealthCheck.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await healthCheckService.delete(params.id);
      return { success: true, message: "HealthCheck deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "HealthCheck not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
