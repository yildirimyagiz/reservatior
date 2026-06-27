import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leadService } from "../services/lead";
import { 
  LeadPlainInputCreate, 
  LeadPlainInputUpdate 
} from "../../generated/prismabox/Lead";
import { regionMiddleware } from "../middleware/region";

export const leadRoutes = new Elysia({ prefix: "/lead" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /lead
   * Retrieves all Lead with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return leadService.withDB(db as any).getAll({
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
   * POST /lead
   * Creates a new Lead.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await leadService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: LeadPlainInputCreate
  })

  /**
   * GET /lead/:id
   * Retrieves a single Lead by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await leadService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Lead not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /lead/:id
   * Updates an existing Lead.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await leadService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Lead not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LeadPlainInputUpdate
  })

  /**
   * DELETE /lead/:id
   * Deletes a Lead.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await leadService.withDB(db as any).delete(params.id);
      return { success: true, message: "Lead deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Lead not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
