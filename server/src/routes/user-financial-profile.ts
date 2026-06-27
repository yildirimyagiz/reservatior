import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { userFinancialProfileService } from "../services/userfinancialprofile";
import { 
  UserFinancialProfilePlainInputCreate, 
  UserFinancialProfilePlainInputUpdate 
} from "../../generated/prismabox/UserFinancialProfile";
import { regionMiddleware } from "../middleware/region";

export const userFinancialProfileRoutes = new Elysia({ prefix: "/user-financial-profiles" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /user-financial-profile
   * Retrieves all UserFinancialProfile with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return userFinancialProfileService.withDB(db as any).getAll({
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
   * POST /user-financial-profile
   * Creates a new UserFinancialProfile.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await userFinancialProfileService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: UserFinancialProfilePlainInputCreate
  })

  /**
   * GET /user-financial-profile/:id
   * Retrieves a single UserFinancialProfile by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await userFinancialProfileService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "UserFinancialProfile not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /user-financial-profile/:id
   * Updates an existing UserFinancialProfile.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await userFinancialProfileService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "UserFinancialProfile not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: UserFinancialProfilePlainInputUpdate
  })

  /**
   * DELETE /user-financial-profile/:id
   * Deletes a UserFinancialProfile.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await userFinancialProfileService.withDB(db as any).delete(params.id);
      return { success: true, message: "UserFinancialProfile deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "UserFinancialProfile not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
