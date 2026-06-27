import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { userFinancialProfileService } from "../services/userfinancialprofile";
import { 
  UserFinancialProfilePlainInputCreate, 
  UserFinancialProfilePlainInputUpdate 
} from "../../generated/prismabox/UserFinancialProfile";

export const userFinancialProfileRoutes = new Elysia({ prefix: "/user-financial-profiles" })
  .use(authMiddleware)

  /**
   * GET /user-financial-profile
   * Retrieves all UserFinancialProfile with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return userFinancialProfileService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await userFinancialProfileService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: UserFinancialProfilePlainInputCreate
  })

  /**
   * GET /user-financial-profile/:id
   * Retrieves a single UserFinancialProfile by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await userFinancialProfileService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await userFinancialProfileService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await userFinancialProfileService.delete(params.id);
      return { success: true, message: "UserFinancialProfile deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "UserFinancialProfile not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
