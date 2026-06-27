import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { immigrationStatusCheckService } from "../services/immigrationstatuscheck";
import { 
  ImmigrationStatusCheckPlainInputCreate, 
  ImmigrationStatusCheckPlainInputUpdate 
} from "../../generated/prismabox/ImmigrationStatusCheck";
import { regionMiddleware } from "../middleware/region";

export const immigrationStatusCheckRoutes = new Elysia({ prefix: "/immigration-status-checks" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /immigration-status-check
   * Retrieves all ImmigrationStatusCheck with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return immigrationStatusCheckService.withDB(db as any).getAll({
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
   * POST /immigration-status-check
   * Creates a new ImmigrationStatusCheck.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await immigrationStatusCheckService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ImmigrationStatusCheckPlainInputCreate
  })

  /**
   * GET /immigration-status-check/:id
   * Retrieves a single ImmigrationStatusCheck by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await immigrationStatusCheckService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ImmigrationStatusCheck not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /immigration-status-check/:id
   * Updates an existing ImmigrationStatusCheck.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await immigrationStatusCheckService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ImmigrationStatusCheck not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ImmigrationStatusCheckPlainInputUpdate
  })

  /**
   * DELETE /immigration-status-check/:id
   * Deletes a ImmigrationStatusCheck.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await immigrationStatusCheckService.withDB(db as any).delete(params.id);
      return { success: true, message: "ImmigrationStatusCheck deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ImmigrationStatusCheck not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
