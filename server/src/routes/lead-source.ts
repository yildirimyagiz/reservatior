import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leadSourceService } from "../services/leadsource";
import { 
  LeadSourcePlainInputCreate, 
  LeadSourcePlainInputUpdate 
} from "../../generated/prismabox/LeadSource";
import { regionMiddleware } from "../middleware/region";

export const leadSourceRoutes = new Elysia({ prefix: "/lead-sources" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /lead-source
   * Retrieves all LeadSource with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return leadSourceService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await leadSourceService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: LeadSourcePlainInputCreate
  })

  /**
   * GET /lead-source/:id
   * Retrieves a single LeadSource by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await leadSourceService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await leadSourceService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await leadSourceService.withDB(db as any).delete(params.id);
      return { success: true, message: "LeadSource deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LeadSource not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
