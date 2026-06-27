import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIPredictionService } from "../services/aiprediction";
import { 
  AIPredictionPlainInputCreate, 
  AIPredictionPlainInputUpdate 
} from "../../generated/prismabox/AIPrediction";

export const aipredictionRoutes = new Elysia({ prefix: "/ai-predictions" })
  .use(authMiddleware)

  /**
   * GET /aiprediction
   * Retrieves all AIPrediction with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIPredictionService.getAll({
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
   * POST /aiprediction
   * Creates a new AIPrediction.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIPredictionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIPredictionPlainInputCreate
  })

  /**
   * GET /aiprediction/:id
   * Retrieves a single AIPrediction by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIPredictionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIPrediction not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aiprediction/:id
   * Updates an existing AIPrediction.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIPredictionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIPrediction not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIPredictionPlainInputUpdate
  })

  /**
   * DELETE /aiprediction/:id
   * Deletes a AIPrediction.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIPredictionService.delete(params.id);
      return { success: true, message: "AIPrediction deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIPrediction not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
