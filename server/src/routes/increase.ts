import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { increaseService } from "../services/increase";
import { 
  IncreasePlainInputCreate, 
  IncreasePlainInputUpdate 
} from "../../generated/prismabox/Increase";

export const increaseRoutes = new Elysia({ prefix: "/increases" })
  .use(authMiddleware)

  /**
   * GET /increase
   * Retrieves all Increase with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return increaseService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await increaseService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: IncreasePlainInputCreate
  })

  /**
   * GET /increase/:id
   * Retrieves a single Increase by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await increaseService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await increaseService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await increaseService.delete(params.id);
      return { success: true, message: "Increase deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Increase not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
