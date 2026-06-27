import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mlsDataMappingService } from "../services/mlsdatamapping";
import { 
  MlsDataMappingPlainInputCreate, 
  MlsDataMappingPlainInputUpdate 
} from "../../generated/prismabox/MlsDataMapping";

export const mlsDataMappingRoutes = new Elysia({ prefix: "/mls-data-mappings" })
  .use(authMiddleware)

  /**
   * GET /mls-data-mapping
   * Retrieves all MlsDataMapping with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mlsDataMappingService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await mlsDataMappingService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MlsDataMappingPlainInputCreate
  })

  /**
   * GET /mls-data-mapping/:id
   * Retrieves a single MlsDataMapping by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mlsDataMappingService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mlsDataMappingService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await mlsDataMappingService.delete(params.id);
      return { success: true, message: "MlsDataMapping deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MlsDataMapping not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
