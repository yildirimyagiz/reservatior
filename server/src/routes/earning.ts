import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { earningService } from "../services/earning";
import { 
  EarningPlainInputCreate, 
  EarningPlainInputUpdate 
} from "../../generated/prismabox/Earning";

export const earningRoutes = new Elysia({ prefix: "/financials/earnings" })
  .use(authMiddleware)

  /**
   * GET /earning
   * Retrieves all Earning with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return earningService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await earningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: EarningPlainInputCreate
  })

  /**
   * GET /earning/:id
   * Retrieves a single Earning by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await earningService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await earningService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await earningService.delete(params.id);
      return { success: true, message: "Earning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Earning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
