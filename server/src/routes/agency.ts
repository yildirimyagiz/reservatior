import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agencyService } from "../services/agency";
import { 
  AgencyPlainInputCreate, 
  AgencyPlainInputUpdate 
} from "../../generated/prismabox/Agency";
import { regionMiddleware } from "../middleware/region";

export const agencyRoutes = new Elysia({ prefix: "/agencies" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /agency
   * Retrieves all Agency with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return agencyService.withDB(db as any).getAll({
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
   * POST /agency
   * Creates a new Agency.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await agencyService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgencyPlainInputCreate
  })

  /**
   * GET /agency/:id
   * Retrieves a single Agency by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await agencyService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Agency not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agency/:id
   * Updates an existing Agency.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await agencyService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Agency not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgencyPlainInputUpdate
  })

  /**
   * DELETE /agency/:id
   * Deletes a Agency.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await agencyService.withDB(db as any).delete(params.id);
      return { success: true, message: "Agency deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Agency not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
