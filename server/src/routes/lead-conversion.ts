import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leadConversionService } from "../services/leadconversion";
import { 
  LeadConversionPlainInputCreate, 
  LeadConversionPlainInputUpdate 
} from "../../generated/prismabox/LeadConversion";
import { regionMiddleware } from "../middleware/region";

export const leadConversionRoutes = new Elysia({ prefix: "/lead-conversion" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /lead-conversion
   * Retrieves all LeadConversion with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return leadConversionService.withDB(db as any).getAll({
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
   * POST /lead-conversion
   * Creates a new LeadConversion.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await leadConversionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: LeadConversionPlainInputCreate
  })

  /**
   * GET /lead-conversion/:id
   * Retrieves a single LeadConversion by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await leadConversionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LeadConversion not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /lead-conversion/:id
   * Updates an existing LeadConversion.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await leadConversionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LeadConversion not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LeadConversionPlainInputUpdate
  })

  /**
   * DELETE /lead-conversion/:id
   * Deletes a LeadConversion.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await leadConversionService.withDB(db as any).delete(params.id);
      return { success: true, message: "LeadConversion deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LeadConversion not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
