import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { smartLockService } from "../services/smartlock";
import { 
  SmartLockPlainInputCreate, 
  SmartLockPlainInputUpdate 
} from "../../generated/prismabox/SmartLock";

export const smartLockRoutes = new Elysia({ prefix: "/smart-lock" })
  .use(authMiddleware)

  /**
   * GET /smart-lock
   * Retrieves all SmartLock with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return smartLockService.getAll({
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
   * POST /smart-lock
   * Creates a new SmartLock.
   */
  .post("/", async ({ body, set }) => {
    const data = await smartLockService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SmartLockPlainInputCreate
  })

  /**
   * GET /smart-lock/:id
   * Retrieves a single SmartLock by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await smartLockService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SmartLock not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /smart-lock/:id
   * Updates an existing SmartLock.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await smartLockService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SmartLock not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SmartLockPlainInputUpdate
  })

  /**
   * DELETE /smart-lock/:id
   * Deletes a SmartLock.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await smartLockService.delete(params.id);
      return { success: true, message: "SmartLock deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SmartLock not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
