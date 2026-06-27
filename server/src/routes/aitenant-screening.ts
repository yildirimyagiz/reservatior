import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aITenantScreeningService } from "../services/aitenantscreening";
import { 
  AITenantScreeningPlainInputCreate, 
  AITenantScreeningPlainInputUpdate 
} from "../../generated/prismabox/AITenantScreening";

export const aitenantScreeningRoutes = new Elysia({ prefix: "/ai-tenant-screenings" })
  .use(authMiddleware)

  /**
   * GET /aitenant-screening
   * Retrieves all AITenantScreening with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aITenantScreeningService.getAll({
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
   * POST /aitenant-screening
   * Creates a new AITenantScreening.
   */
  .post("/", async ({ body, set }) => {
    const data = await aITenantScreeningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AITenantScreeningPlainInputCreate
  })

  /**
   * GET /aitenant-screening/:id
   * Retrieves a single AITenantScreening by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aITenantScreeningService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AITenantScreening not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aitenant-screening/:id
   * Updates an existing AITenantScreening.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aITenantScreeningService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AITenantScreening not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AITenantScreeningPlainInputUpdate
  })

  /**
   * DELETE /aitenant-screening/:id
   * Deletes a AITenantScreening.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aITenantScreeningService.delete(params.id);
      return { success: true, message: "AITenantScreening deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AITenantScreening not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
