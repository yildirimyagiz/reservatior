import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mlsDataMappingService } from "../services/mlsdatamapping";
import { 
  MlsDataMappingPlainInputCreate, 
  MlsDataMappingPlainInputUpdate 
} from "../../generated/prismabox/MlsDataMapping";
import { regionMiddleware } from "../middleware/region";

export const mlsDataMappingRoutes = new Elysia({ prefix: "/mls-data-mappings" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mls-data-mapping
   * Retrieves all MlsDataMapping with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mlsDataMappingService.withDB(db as any).getAll({
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
   * POST /mls-data-mapping
   * Creates a new MlsDataMapping.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mlsDataMappingService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MlsDataMappingPlainInputCreate
  })

  /**
   * GET /mls-data-mapping/:id
   * Retrieves a single MlsDataMapping by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mlsDataMappingService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MlsDataMapping not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mls-data-mapping/:id
   * Updates an existing MlsDataMapping.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mlsDataMappingService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MlsDataMapping not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MlsDataMappingPlainInputUpdate
  })

  /**
   * DELETE /mls-data-mapping/:id
   * Deletes a MlsDataMapping.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mlsDataMappingService.withDB(db as any).delete(params.id);
      return { success: true, message: "MlsDataMapping deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MlsDataMapping not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
