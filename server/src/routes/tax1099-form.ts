import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { tax1099FormService } from "../services/tax1099form";
import { 
  Tax1099FormPlainInputCreate, 
  Tax1099FormPlainInputUpdate 
} from "../../generated/prismabox/Tax1099Form";
import { regionMiddleware } from "../middleware/region";

export const tax1099FormRoutes = new Elysia({ prefix: "/tax-1099-forms" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /tax1099-form
   * Retrieves all Tax1099Form with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return tax1099FormService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /tax1099-form
   * Creates a new Tax1099Form.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await tax1099FormService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: Tax1099FormPlainInputCreate
  })

  /**
   * GET /tax1099-form/:id
   * Retrieves a single Tax1099Form by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await tax1099FormService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Tax1099Form not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /tax1099-form/:id
   * Updates an existing Tax1099Form.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await tax1099FormService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tax1099Form not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: Tax1099FormPlainInputUpdate
  })

  /**
   * DELETE /tax1099-form/:id
   * Deletes a Tax1099Form.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await tax1099FormService.withDB(db as any).delete(params.id);
      return { success: true, message: "Tax1099Form deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Tax1099Form not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
