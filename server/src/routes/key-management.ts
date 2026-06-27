import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { keyManagementService } from "../services/keymanagement";
import { 
  KeyManagementPlainInputCreate, 
  KeyManagementPlainInputUpdate 
} from "../../generated/prismabox/KeyManagement";

export const keyManagementRoutes = new Elysia({ prefix: "/key-managements" })
  .use(authMiddleware)

  /**
   * GET /key-management
   * Retrieves all KeyManagement with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return keyManagementService.getAll({
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
   * POST /key-management
   * Creates a new KeyManagement.
   */
  .post("/", async ({ body, set }) => {
    const data = await keyManagementService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: KeyManagementPlainInputCreate
  })

  /**
   * GET /key-management/:id
   * Retrieves a single KeyManagement by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await keyManagementService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "KeyManagement not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /key-management/:id
   * Updates an existing KeyManagement.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await keyManagementService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "KeyManagement not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: KeyManagementPlainInputUpdate
  })

  /**
   * DELETE /key-management/:id
   * Deletes a KeyManagement.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await keyManagementService.delete(params.id);
      return { success: true, message: "KeyManagement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "KeyManagement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
