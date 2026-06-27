import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { includedServiceService } from "../services/includedservice";
import { 
  IncludedServicePlainInputCreate, 
  IncludedServicePlainInputUpdate 
} from "../../generated/prismabox/IncludedService";

export const includedServiceRoutes = new Elysia({ prefix: "/included-services" })
  .use(authMiddleware)

  /**
   * GET /included-service
   * Retrieves all IncludedService with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return includedServiceService.getAll({
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
   * POST /included-service
   * Creates a new IncludedService.
   */
  .post("/", async ({ body, set }) => {
    const data = await includedServiceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: IncludedServicePlainInputCreate
  })

  /**
   * GET /included-service/:id
   * Retrieves a single IncludedService by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await includedServiceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "IncludedService not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /included-service/:id
   * Updates an existing IncludedService.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await includedServiceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "IncludedService not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: IncludedServicePlainInputUpdate
  })

  /**
   * DELETE /included-service/:id
   * Deletes a IncludedService.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await includedServiceService.delete(params.id);
      return { success: true, message: "IncludedService deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "IncludedService not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
