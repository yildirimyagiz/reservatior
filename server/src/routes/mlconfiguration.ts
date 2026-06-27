import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLConfigurationService } from "../services/mlconfiguration";
import { 
  MLConfigurationPlainInputCreate, 
  MLConfigurationPlainInputUpdate 
} from "../../generated/prismabox/MLConfiguration";

export const mlconfigurationRoutes = new Elysia({ prefix: "/mlconfiguration" })
  .use(authMiddleware)

  /**
   * GET /mlconfiguration
   * Retrieves all MLConfiguration with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mLConfigurationService.getAll({
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
   * POST /mlconfiguration
   * Creates a new MLConfiguration.
   */
  .post("/", async ({ body, set }) => {
    const data = await mLConfigurationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLConfigurationPlainInputCreate
  })

  /**
   * GET /mlconfiguration/:id
   * Retrieves a single MLConfiguration by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mLConfigurationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MLConfiguration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mlconfiguration/:id
   * Updates an existing MLConfiguration.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mLConfigurationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MLConfiguration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MLConfigurationPlainInputUpdate
  })

  /**
   * DELETE /mlconfiguration/:id
   * Deletes a MLConfiguration.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mLConfigurationService.delete(params.id);
      return { success: true, message: "MLConfiguration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLConfiguration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
