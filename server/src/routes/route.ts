import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { routeService } from "../services/route";
import { 
  RoutePlainInputCreate, 
  RoutePlainInputUpdate 
} from "../../generated/prismabox/Route";

export const routeRoutes = new Elysia({ prefix: "/route" })
  .use(authMiddleware)

  /**
   * GET /route
   * Retrieves all Route with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return routeService.getAll({
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
   * POST /route
   * Creates a new Route.
   */
  .post("/", async ({ body, set }) => {
    const data = await routeService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: RoutePlainInputCreate
  })

  /**
   * GET /route/:id
   * Retrieves a single Route by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await routeService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Route not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /route/:id
   * Updates an existing Route.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await routeService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Route not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RoutePlainInputUpdate
  })

  /**
   * DELETE /route/:id
   * Deletes a Route.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await routeService.delete(params.id);
      return { success: true, message: "Route deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Route not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
