import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { apiTokenService } from "../services/apitoken";
import { 
  ApiTokenPlainInputCreate, 
  ApiTokenPlainInputUpdate 
} from "../../generated/prismabox/ApiToken";

export const apiTokenRoutes = new Elysia({ prefix: "/api-tokens" })
  .use(authMiddleware)

  /**
   * GET /api-token
   * Retrieves all ApiToken with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return apiTokenService.getAll({
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
   * POST /api-token
   * Creates a new ApiToken.
   */
  .post("/", async ({ body, set }) => {
    const data = await apiTokenService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ApiTokenPlainInputCreate
  })

  /**
   * GET /api-token/:id
   * Retrieves a single ApiToken by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await apiTokenService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ApiToken not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /api-token/:id
   * Updates an existing ApiToken.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await apiTokenService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ApiToken not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ApiTokenPlainInputUpdate
  })

  /**
   * DELETE /api-token/:id
   * Deletes a ApiToken.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await apiTokenService.delete(params.id);
      return { success: true, message: "ApiToken deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ApiToken not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
