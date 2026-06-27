import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { referenceSourceService } from "../services/referencesource";
import { 
  ReferenceSourcePlainInputCreate, 
  ReferenceSourcePlainInputUpdate 
} from "../../generated/prismabox/ReferenceSource";

export const referenceSourceRoutes = new Elysia({ prefix: "/reference-sources" })
  .use(authMiddleware)

  /**
   * GET /reference-source
   * Retrieves all ReferenceSource with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return referenceSourceService.getAll({
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
   * POST /reference-source
   * Creates a new ReferenceSource.
   */
  .post("/", async ({ body, set }) => {
    const data = await referenceSourceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReferenceSourcePlainInputCreate
  })

  /**
   * GET /reference-source/:id
   * Retrieves a single ReferenceSource by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await referenceSourceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ReferenceSource not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /reference-source/:id
   * Updates an existing ReferenceSource.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await referenceSourceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ReferenceSource not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReferenceSourcePlainInputUpdate
  })

  /**
   * DELETE /reference-source/:id
   * Deletes a ReferenceSource.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await referenceSourceService.delete(params.id);
      return { success: true, message: "ReferenceSource deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ReferenceSource not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
