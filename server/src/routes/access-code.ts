import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { accessCodeService } from "../services/accesscode";
import { 
  AccessCodePlainInputCreate, 
  AccessCodePlainInputUpdate 
} from "../../generated/prismabox/AccessCode";
import { regionMiddleware } from "../middleware/region";

export const accessCodeRoutes = new Elysia({ prefix: "/access-code" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /access-code
   * Retrieves all AccessCode with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return accessCodeService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await accessCodeService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AccessCodePlainInputCreate
  })

  /**
   * GET /access-code/:id
   * Retrieves a single AccessCode by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await accessCodeService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await accessCodeService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await accessCodeService.withDB(db as any).delete(params.id);
      return { success: true, message: "AccessCode deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AccessCode not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
