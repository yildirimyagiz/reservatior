import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leadSourceService } from "../services/leadsource";
import { 
  LeadSourcePlainInputCreate, 
  LeadSourcePlainInputUpdate 
} from "../../generated/prismabox/LeadSource";

export const leadSourceRoutes = new Elysia({ prefix: "/lead-sources" })
  .use(authMiddleware)

  /**
   * GET /lead-source
   * Retrieves all LeadSource with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return leadSourceService.getAll({
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
   * POST /lead-source
   * Creates a new LeadSource.
   */
  .post("/", async ({ body, set }) => {
    const data = await leadSourceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LeadSourcePlainInputCreate
  })

  /**
   * GET /lead-source/:id
   * Retrieves a single LeadSource by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await leadSourceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LeadSource not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /lead-source/:id
   * Updates an existing LeadSource.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await leadSourceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LeadSource not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LeadSourcePlainInputUpdate
  })

  /**
   * DELETE /lead-source/:id
   * Deletes a LeadSource.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await leadSourceService.delete(params.id);
      return { success: true, message: "LeadSource deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LeadSource not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
