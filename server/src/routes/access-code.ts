import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { accessCodeService } from "../services/accesscode";
import { 
  AccessCodePlainInputCreate, 
  AccessCodePlainInputUpdate 
} from "../../generated/prismabox/AccessCode";

export const accessCodeRoutes = new Elysia({ prefix: "/access-code" })
  .use(authMiddleware)

  /**
   * GET /access-code
   * Retrieves all AccessCode with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return accessCodeService.getAll({
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
   * POST /access-code
   * Creates a new AccessCode.
   */
  .post("/", async ({ body, set }) => {
    const data = await accessCodeService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AccessCodePlainInputCreate
  })

  /**
   * GET /access-code/:id
   * Retrieves a single AccessCode by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await accessCodeService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AccessCode not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /access-code/:id
   * Updates an existing AccessCode.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await accessCodeService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AccessCode not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AccessCodePlainInputUpdate
  })

  /**
   * DELETE /access-code/:id
   * Deletes a AccessCode.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await accessCodeService.delete(params.id);
      return { success: true, message: "AccessCode deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AccessCode not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
